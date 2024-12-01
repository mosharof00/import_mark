import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:import_mark/global/log_printer.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../../../models/category_model.dart';

class AddCategoryController extends GetxController {
  //TODO: Implement AddCategoryController
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  final categoryList = <CategoryModel>[].obs;
  final isCategoryLoading = false.obs;
  final selectedIndex = 0.obs;
  final isUpdateMode = false.obs;
  final isGetImageFromFile = false.obs;
  final Rx<XFile?> selectedPhoto = Rx<XFile?>(null);
  final selectedBrandID = 0.obs;
  final nameEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();


  void setBrandForUpdate(CategoryModel category) {
    selectedBrandID.value = category.id;
    nameEditingController.text = category.name;
    descriptionEditingController.text = category.description;
    selectedPhoto.value = XFile(category.image);
    isUpdateMode.value = true;
    isGetImageFromFile.value = false;
  }



  Future<void> fetchCategories() async {
    try {
      isCategoryLoading.value = true;
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('categories').get();

      // Map each document to a CategoryModel and add it to categoryList
      categoryList.value = snapshot.docs
          .map((doc) =>
              CategoryModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      isCategoryLoading.value = false;
      Log.i("Categories fetched successfully!");
    } catch (e) {
      isCategoryLoading.value = false;
      Log.i("Failed to fetch categories: $e");
    }
  }


  Future<void> addCategory(CategoryModel category) async {
    try {
      btnController.start();
      await _fireStore
          .collection('categories')
          .doc(category.id.toString())
          .set(category.toMap());
      btnController.stop();

      Log.i("Category added successfully!");
    } catch (e) {
      btnController.stop;
      Log.e("Failed to add category: $e");
    }
  }

  @override
  void onInit() {
    btnController;
    fetchCategories();
    super.onInit();
  }
}
