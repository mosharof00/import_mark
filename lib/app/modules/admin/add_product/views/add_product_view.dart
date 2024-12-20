import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:import_mark/app/modules/admin/addCategory/views/add_category_view.dart';
import 'package:import_mark/app/repository/api_services.dart';
import 'package:import_mark/global/app_text_style.dart';
import 'package:import_mark/global/global_button.dart';
import 'package:import_mark/global/global_snackbar.dart';
import 'package:import_mark/global/log_printer.dart';
import 'package:import_mark/global/methods/pick_files.dart';
import 'package:import_mark/global/sizedbox_extension.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('AddProductView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller.folderController,
              decoration: InputDecoration(
                labelText: "Folder Name",
                border: OutlineInputBorder(),
                hintText: "e.g., Products, Categories",
              ),
            ),
            SizedBox(height: 16),
            Obx(
              () => Container(
                  height: 200,
                  width: Get.width,
                  child: Center(
                    child: controller.selectedImage.value == null
                        ? AppTextStyle(text: 'Image is not selected')
                        : Image.file(
                            File(controller.selectedImage.value!.path),
                            fit: BoxFit.cover,
                          ),
                  )),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                final List<XFile>? files = await PickFile.pickMultiFile();

                if (files != null) {
                  controller.selectedFiles.value = files;
                } else {
                  Log.e("No images selected");
                }
              },
              icon: Icon(Icons.image),
              label: Text("Pick Image"),
            ),
            SizedBox(height: 16),
            Obx(() {
              if (controller.isUploading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.uploadedImageUrl.value.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Uploaded Image URL:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    SelectableText(
                      controller.uploadedImageUrl.value,
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(height: 16),
                    Image.network(
                      controller.uploadedImageUrl.value,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                );
              } else {
                return Text("No image uploaded yet.");
              }
            }),
            SizedBox(height: 16),
            ElevatedButton(
                onPressed: () async {
                  // if (controller.folderController.text.isNotEmpty &&
                  //     controller.selectedImage.value != null) {
                  //   Log.i('called from view');
                  //   controller.uploadedImageUrl.value =
                  //       (await controller.uploadFile(
                  //           file: controller.selectedImage.value!,
                  //           folderName: "categories"))!;
                  // } else {
                  //   globalSnackBar(
                  //       title: "Alert!",
                  //       message: "Please enter all Required feeds.");
                  // }
                  controller.uploadImages();
                },
                child: AppTextStyle(text: "Uoload image on Cloudinary")),
            Obx(() {
              if (controller.isUploading.value) {
                return CircularProgressIndicator();
              } else {
                return 0.height;
              }
            }),
            globalButton(
                onTap: () async {
                  try {
                    bool success = await controller.deleteFileFromCloudinary(
                        'https://res.cloudinary.com/dvmsjvhmu/image/upload/v1733070408/products/p1wftzq9q8nozeztokpc.jpg');
                    if (success) {
                      print("File deleted successfully.");
                    } else {
                      print("Failed to delete file.");
                    }
                  } catch (e) {
                    print("Error: $e");
                  }
                  //   final apiService = ApiServices();
                  //   apiService.deleteFileFromCloudinary(
                  //       'https://res.cloudinary.com/dvmsjvhmu/image/upload/v1733070408/products/p1wftzq9q8nozeztokpc.jpg');
                },
                text: "Delete")
          ],
        ),
      ),
    );
  }
}
