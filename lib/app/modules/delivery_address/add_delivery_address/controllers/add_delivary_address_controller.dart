import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:import_mark/app/routes/app_pages.dart';
import 'package:import_mark/global/log_printer.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import '../../../../../global/global_snackbar.dart';
import '../../../../models/address_model.dart';

class AddDeliveryAddressController extends GetxController {
  //TODO: Implement AddDeliveryAddressController
  final btnController = RoundedLoadingButtonController();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final address = Rxn<Address>();
  final isUpdating = false.obs;

  /// Text Editing Controller
  TextEditingController addressTitleTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  TextEditingController areaTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();
  TextEditingController districtTextController = TextEditingController();

  ///  Add Shipping Address
  Future<void> addAddress(Address address) async {
    try {
      btnController.start();
      await _fireStore
          .collection('addresses')
          .doc(address.id)
          .set(address.toJson());
      globalSnackBar(
          durationInSeconds: 2,
          title: "Success!",
          message: "Address added successfully.");
      btnController.stop();
      Get.offNamed(Routes.DELIVERY_ADDRESS);
      Get.delete<AddDeliveryAddressController>();
    } catch (e) {
      globalSnackBar(title: "Error!", message: e.toString());
      Log.i("Error adding address: $e");
      btnController.stop();
    }
  }

  /// Update Shipping Address
  Future<void> updateAddress(Address address) async {
    try {
      btnController.start();
      await _fireStore
          .collection('addresses')
          .doc(address.id)
          .update(address.toJson());
      btnController.stop();
      Get.delete<AddDeliveryAddressController>();
      Get.back();
      globalSnackBar(
          durationInSeconds: 2,
          title: 'Updated Address',
          message: "Update address successfully");
    } catch (e) {
      globalSnackBar(title: "Error!", message: e.toString());
      Log.i("Error adding address: $e");
      btnController.stop();
    }
  }

  // Set Existing Data for Editing
  void setAddressForEditing(Address address) {
    addressTitleTextController.text = address.addressTitle;
    nameTextController.text = address.name;
    phoneTextController.text = address.phone;
    emailTextController.text = address.email;
    cityTextController.text = address.city;
    districtTextController.text = address.district;
    areaTextController.text = address.area;
    addressTextController.text = address.address;
  }

  // Clear all textFields
  void clearForm() {
    addressTitleTextController.clear();
    nameTextController.clear();
    phoneTextController.clear();
    emailTextController.clear();
    addressTextController.clear();
    areaTextController.clear();
    districtTextController.clear();
    cityTextController.clear();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments.containsKey('address')) {
      Log.i(Get.arguments['address']);

      address.value = Get.arguments['address'];
      setAddressForEditing(address.value!);
      isUpdating.value = true;
    } else {
      isUpdating.value = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    clearForm();
  }
}
