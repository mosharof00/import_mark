import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:import_mark/global/log_printer.dart'; // Prefix Dio library

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
      "import_mark"; // Replace with your Cloudinary API secret

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

  /// Upload product image
  Future<String?> uploadProductImage(XFile file) async {
    return await uploadFile(file: file, folderName: "products");
  }

  /// Upload category image
  Future<String?> uploadCategoryImage(XFile file) async {
    return await uploadFile(file: file, folderName: "categories");
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _dio;
    super.onInit();
  }
}
