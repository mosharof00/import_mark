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
                // final List<XFile>? files = await PickFile.pickMultiFile();
                final XFile? files = await PickFile.pickSingleFile(
                    imageSource: ImageSource.gallery);

                if (files != null) {
                  // controller.selectedFiles.value = files;
                  controller.selectedImage.value = files;
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
                    const Text(
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
                  // controller.uploadImages();
                  // controller.uploadFile(
                  //     file: controller.selectedImage.value!,
                  //     folderName: 'product');

                  controller.uploadSingleFile(
                      file: controller.selectedImage.value!,
                      folderName: 'product',
                    presetName: 'product'

                  );
                },
                child: AppTextStyle(text: "Uoload image on Cloudinary")),
            Obx(() {
              if (controller.isUploading.value) {
                return const CircularProgressIndicator();
              } else {
                return 0.height;
              }
            }),

            20.height,
            globalButton(
                onTap: () async {
                  Log.w(controller.uploadedImageUrl.value);
                  if (controller.uploadedImageUrl.value.isEmpty) return;
                  try {
                    bool success = await controller.deleteImage(
                       imageUrl: controller.uploadedImageUrl.value);
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
