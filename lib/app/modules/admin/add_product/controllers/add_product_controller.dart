import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:import_mark/app/repository/api_services.dart';
import 'package:import_mark/global/global_snackbar.dart';
import 'package:import_mark/global/log_printer.dart';
import 'package:import_mark/global/methods/pick_files.dart';
import 'package:import_mark/helper/handle_exceptioon.dart'; // Prefix Dio library

class AddProductController extends GetxController {
  //TODO: Implement AddProductController
  ApiServices apiServices = ApiServices();
  final TextEditingController folderController = TextEditingController();
  final selectedImage = Rx<XFile?>(null);

  var isUploading = false.obs;
  var uploadedImageUrl = ''.obs;
  // Cloudinary configuration
  final String cloudName =
      "dvmsjvhmu"; // Replace with your Cloudinary cloud name
  final String apiKey =
      "557245362198125"; // Replace with your Cloudinary API key
  final String apiSecret =
      "70ZkO6Wad7U54_4B-9PmS7dqmLM"; // Replace with your Cloudinary API secret
  final String presetName =
      "product"; // Replace with your Cloudinary API secret

  final dio.Dio _dio = dio.Dio();

  /// Upload file to Cloudinary
  Future<void> uploadSingelFile({
    required XFile file,
    required String folderName,
    required String presetName,
  }) async {
    try {
      isUploading.value = true;
      final response = await apiServices.uploadSingleFile(
          file: file, folderName: folderName, presetName: presetName);
      uploadedImageUrl.value = response.secureUrl!;
      isUploading.value = false;
      Log.w(uploadedImageUrl.value);
      globalSnackBar(
          title: "File upload successfully",
          message: 'Your file is uploaded successfully.');
    } catch (e) {
      isUploading.value = false;
      handleException(e);
      Log.e(e);
    }
  }

  // /// Upload file to Cloudinary
  // Future<String?> uploadFile({
  //   required XFile file,
  //   required String folderName,
  //   required String presetName,
  // }) async {
  //   try {
  //     Log.i('Upload started');
  //     isUploading.value = true;
  //     final String apiUrl =
  //         "https://api.cloudinary.com/v1_1/$cloudName/image/upload";
  //
  //     final String fileName = file.path.split('/').last;
  //
  //     final formData = dio.FormData.fromMap({
  //       "file": await dio.MultipartFile.fromFile(
  //         file.path,
  //         filename: fileName,
  //       ),
  //       "upload_preset": presetName,
  //       "folder": folderName,
  //     });
  //
  //     final response = await _dio.post(
  //       apiUrl,
  //       data: formData,
  //       options: dio.Options(
  //         headers: {
  //           "Authorization":
  //               "Basic ${base64Encode(utf8.encode("$apiKey:$apiSecret"))}",
  //         },
  //       ),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       Log.i('Upload Successful: ${response.data}');
  //       Log.w(response.data['secure_url']);
  //       uploadedImageUrl.value = response.data['secure_url'];
  //       isUploading.value = false;
  //       return response.data["secure_url"];
  //     } else {
  //       isUploading.value = false;
  //       Log.e('Failed Upload: ${response.data}');
  //       throw Exception("Failed to upload image: ${response.data}");
  //     }
  //   } catch (e) {
  //     isUploading.value = false;
  //     Log.e('Error: $e');
  //     Get.snackbar("Error", e.toString());
  //     return null;
  //   }
  // }

  /// Upload a list of files to Cloudinary concurrently and get a list of URLs
  Future<List<String>> uploadMultiFile({
    required List<XFile> files,
    required String folderName,
  }) async {
    List<Future<String?>> uploadFutures = [];
    List<String> uploadedUrls = [];

    try {
      Log.i('Starting concurrent file uploads');
      isUploading.value = true;

      final String apiUrl =
          "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

      for (var file in files) {
        final String fileName = file.path.split('/').last;

        final dio.FormData formData = dio.FormData.fromMap({
          "file":
              await dio.MultipartFile.fromFile(file.path, filename: fileName),
          "upload_preset": presetName,
          "folder": folderName,
        });

        // Each upload is handled independently
        uploadFutures.add(
          _dio
              .post(
            apiUrl,
            data: formData,
            options: dio.Options(
              headers: {
                "Authorization":
                    "Basic ${base64Encode(utf8.encode("$apiKey:$apiSecret"))}",
              },
            ),
          )
              .then<String?>((response) {
            if (response.statusCode == 200) {
              Log.i('File uploaded: ${response.data["secure_url"]}');
              return response.data["secure_url"] as String?;
            } else {
              Log.e('Failed to upload file: ${response.data}');
              return null; // Return null for failed uploads
            }
          }).catchError((e) {
            Log.e('Error uploading file: $e');
            return null; // Return null if an error occurs
          }),
        );
      }

      // Wait for all uploads to complete
      final List<String?> results = await Future.wait(uploadFutures);

      // Filter out null values (failed uploads)
      uploadedUrls = results.whereType<String>().toList();

      isUploading.value = false;
      Log.i("Batch upload complete: $uploadedUrls");

      return uploadedUrls;
    } catch (e) {
      isUploading.value = false;
      Log.e('Error during batch upload: $e');
      Get.snackbar("Error", "Batch upload failed: $e");
      return [];
    }
  }

  final selectedFiles = <XFile>[].obs;
  final imageUrls = <String>[].obs;

  Future<void> uploadImages() async {
    // Select multiple images

    if (selectedFiles.isNotEmpty) {
      // Upload the selected images concurrently and get the URLs
      imageUrls.value = await uploadMultiFile(
        files: selectedFiles,
        folderName: "product", // Replace with your folder name
      );

      if (imageUrls.isNotEmpty) {
        Log.i("Uploaded Image URLs: $imageUrls");
        Get.snackbar("Success", "All images uploaded successfully!");
      } else {
        Log.w("No images were uploaded.");
      }
    } else {
      Log.w("No images selected.");
    }
  }

  /// Delete a file from Cloudinary using its URL
  Future<bool> deleteImage({required String imageUrl}) async {
    try {
      final response = await apiServices.deleteFileFromCloudinary(imageUrl);
      return response;
    } catch (e) {
      Log.e(e);
      return false;
    }
  }
}
// [https://res.cloudinary.com/dvmsjvhmu/image/upload/v1736264377/product/g1vtk5ctsaodimtjxi78.jpg, https://res.cloudinary.com/dvmsjvhmu/image/upload/v1736264390/product/d0d2uh6punm3bmdkqqxn.jpg]
