import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:import_mark/global/global_snackbar.dart';
import 'package:import_mark/global/log_printer.dart';

import '../../../models/address_model.dart';

class DeliveryAddressController extends GetxController {
  //TODO: Implement DeliveryAddressController

  Function?
      onAddressSelectedCallback; // Callback function to be called when an address is selected

  ///Get Shipping Address
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final addressList = <Address>[].obs;
  final isAddressFetching = true.obs;
  final selectedAddressId = "".obs;

  /// Fetch addresses from Firestore
  Future<void> fetchAddresses() async {
    try {
      isAddressFetching.value = true;
      final snapshot = await _fireStore.collection('addresses').get();
      addressList.value = snapshot.docs
          .map((doc) => Address.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      isAddressFetching.value = false;
    } catch (e) {
      globalSnackBar(title: "Error!", message: e.toString());
      Log.i("Error fetching addresses: $e");
      isAddressFetching.value = false;
    }
  }

  /// Delete an address by id
  Future<void> deleteAddress(String id) async {
    try {
      await _fireStore.collection('addresses').doc(id).delete();
      addressList.removeWhere((address) => address.id == id);
    } catch (e) {
      Log.e("Error deleting address: $e");
    }
  }

  // Set the callback function to be called when an address is selected
  // void setOnAddressSelectedCallback(Function callback) {
  //   onAddressSelectedCallback = callback;
  // }

  // Select an address by its ID and invoke the callback function
  // void selectAddress(int addressId) {
  //   selectedAddressId.value = addressId;
  //   onAddressSelectedCallback?.call();
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchAddresses();
    super.onInit();
  }
}
