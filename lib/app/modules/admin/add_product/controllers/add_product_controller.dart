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
  Future<void> uploadSingleFile({
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




  final selectedFiles = <XFile>[].obs;
  final imageUrls = <String>[].obs;


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
