import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:import_mark/global/log_printer.dart';
import 'package:import_mark/global/methods/pick_files.dart'; // Prefix Dio library

class AddProductController extends GetxController {
  //TODO: Implement AddProductController
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
      "test_preset"; // Replace with your Cloudinary API secret

  final dio.Dio _dio = dio.Dio();

  /// Upload file to Cloudinary
  Future<String?> uploadFile({
    required XFile file,
    required String folderName,
  }) async {
    try {
      Log.i('called');
      isUploading.value = true;
      // Create the Cloudinary API endpoint
      final String apiUrl =
          "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

      // Prepare file name and folder
      final String fileName = file.path.split('/').last;

      dio.FormData formData = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(file.path, filename: fileName),
        "upload_preset": presetName,
        "folder": folderName,
      });

      final response = await _dio.post(
        apiUrl,
        data: formData,
        options: dio.Options(
          headers: {
            "Authorization":
                "Basic ${base64Encode(utf8.encode("your_api_key:your_api_secret"))}",
          },
        ),
      );

      // Check response and return the secure URL
      if (response.statusCode == 200) {
        Log.i(response);
        isUploading.value = false;
        return response
            .data["secure_url"]; // Return the URL of the uploaded file

      } else {
        isUploading.value = false;
        throw Exception("Failed to upload image: ${response.data}");
      }
    } catch (e) {
      isUploading.value = false;
      Log.e(e);
      Get.snackbar("Error", e.toString());

      return null;
    }
  }




  /// Upload a list of files to Cloudinary concurrently and get a list of URLs
  Future<List<String>> uploadFiles({
    required List<XFile> files,
    required String folderName,
  }) async {
    List<Future<dio.Response>> uploadFutures = [];
    List<String> uploadedUrls = [];

    try {
      Log.i('Starting concurrent file upload');
      isUploading.value = true;

      // Prepare the Cloudinary API endpoint
      final String apiUrl = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

      // Prepare a list of futures for uploading files
      for (var file in files) {
        final String fileName = file.path.split('/').last;

        dio.FormData formData = dio.FormData.fromMap({
          "file": await dio.MultipartFile.fromFile(file.path, filename: fileName),
          "upload_preset": presetName,
          "folder": folderName,
        });

        // Add each upload request to the list of futures
        uploadFutures.add(_dio.post(apiUrl, data: formData));
      }

      // Wait for all file uploads to complete
      final List<dio.Response> responses = await Future.wait(uploadFutures);

      // Check responses and collect URLs
      for (var response in responses) {
        if (response.statusCode == 200) {
          uploadedUrls.add(response.data["secure_url"]); // Add secure URL to the list
        } else {
          throw Exception("Failed to upload file: ${response.data}");
        }
      }

      isUploading.value = false;
      Log.i("Batch upload complete: $uploadedUrls");
      return uploadedUrls; // Return the list of uploaded URLs
    } catch (e) {
      isUploading.value = false;
      Log.e(e);
      Get.snackbar("Error", "File upload failed: $e");
      return [];
    }
  }



  final selectedFiles =<XFile>[].obs;
  final imageUrls = <String>[].obs;

  Future<void> uploadImages() async {
    // Select multiple images


    if (selectedFiles.isNotEmpty) {
      // Upload the selected images concurrently and get the URLs
      imageUrls.value = await uploadFiles(
        files: selectedFiles,
        folderName: "products", // Replace with your folder name
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
  Future<bool> deleteFileFromCloudinary(String imageUrl) async {
    try {
      // Extract public_id from the image URL
      String publicId = _extractPublicId(imageUrl);

      // Prepare the request data
      dio.FormData formData = dio.FormData.fromMap({
        'public_id': publicId,
        // No need to pass API key and secret in formData; use basic authentication instead.
      });
      Log.i("Public Id is: $publicId");

      final String apiUrl = "https://api.cloudinary.com/v1_1/$cloudName/image/destroy";

      // Send the deletion request with basic auth
      final response = await _dio.post(
        apiUrl,
        data: formData,
        options: dio.Options(
          headers: {
            'Authorization': 'Basic ' +
                base64Encode(utf8.encode('$apiKey:$apiSecret')), // Basic Authentication
          },
        ),
      );

      // Check the response status code and result field for success
      if (response.statusCode == 200 && response.data['result'] == 'ok') {
        // File deletion successful
        Log.i("Image deleted successfully.");
        return true;
      } else {
        // Handle errors in the response
        Log.e("Failed to delete file: ${response.data}");
        return false;
      }
    } catch (e) {
      // Handle exceptions like network issues, server errors, etc.
      Log.e("Error deleting image: $e");
      return false;
    }
  }


  /// Helper method to extract the public_id from a Cloudinary image URL
  String _extractPublicId(String imageUrl) {
    final regex = RegExp(r"/v\d+/(\S+?)(?=\.\w+$)"); // Regex to match public_id in URL
    final match = regex.firstMatch(imageUrl);
    if (match != null) {
      return match.group(1) ?? "";
    } else {
      throw Exception("Unable to extract public_id from URL: $imageUrl");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _dio;
    super.onInit();
  }
}
