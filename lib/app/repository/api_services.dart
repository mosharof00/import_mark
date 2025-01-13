import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/response/response.dart'
    as get_response;
import 'package:image_picker/image_picker.dart';
import 'package:import_mark/app/models/foods_product_model.dart';
import 'package:import_mark/global/log_printer.dart';

import '../models/productModel/single_file_upload_model.dart';

//
const String canadianFoodsApiEndPoint =
    "https://www.themealdb.com/api/json/v1/1/filter.php?a=Canadian";
const String categoriesProductApiEndPoint =
    "https://www.themealdb.com/api/json/v1/1/categories.php";

// Cloudinary configuration
const String cloudName = "dvmsjvhmu"; // Replace with your Cloudinary cloud name
const String apiKey = "557245362198125"; // Replace with your Cloudinary API key
const String apiSecret =
    "70ZkO6Wad7U54_4B-9PmS7dqmLM"; // Replace with your Cloudinary API secret
const String cloudinaryUrl =
    "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

abstract class ApiService {
  Future<FoodsProductModel> getFoodProducts();
  // Future<FoodsProductModel> getCategoriesProduct();

  /// Upload single file to Cloudinary
  Future<SingleFileUploadModel> uploadSingleFile({
    required XFile file,
    required String folderName,
    required String presetName,
  });

  /// Delete file from Cloudinary using its URL
  Future<bool> deleteFileFromCloudinary(String imageUrl);
}

class ApiServices implements ApiService {
  final Dio _dio;
  ApiServices()
      : _dio = Dio(BaseOptions(
          validateStatus: (statusCode) {
            if (statusCode == null) {
              return false;
            }
            if (statusCode == 422 || statusCode == 400 || statusCode == 401) {
              // Handle certain http status codes
              return true;
            } else {
              return statusCode >= 200 && statusCode < 300;
            }
          },
        )) {
    _dio.interceptors.add(LogInterceptor());
  }

  @override
  Future<FoodsProductModel> getFoodProducts() async =>
      _handleRequest<FoodsProductModel>(
          () => _dio.get(canadianFoodsApiEndPoint),
          (dynamic data) => FoodsProductModel.fromJson(data));

//   @override
//   Future<CategoriesProductModel> getCategoriesProduct() async =>
//       _handleRequest<CategoriesProductModel>(
//           () => _dio.get(categoriesProductApiEndPoint),
//           (dynamic data) => CategoriesProductModel.fromJson(data));

  /// Upload single file to Cloudinary
  @override
  Future<SingleFileUploadModel> uploadSingleFile({
    required XFile file,
    required String folderName,
    required String presetName,
  }) async {
    final String fileName = file.path.split('/').last;

    final data = dio.FormData.fromMap({
      "file": await dio.MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      "upload_preset": presetName,
      "folder": folderName,
    });

    return _handleRequest<SingleFileUploadModel>(
      () => _dio.post(cloudinaryUrl, data: data),
      (dynamic data) => SingleFileUploadModel.fromJson(data),
    );
  }

  /// Upload a list of files to Cloudinary concurrently and get a list of URLs
  Future<List<String>> uploadMultiFile({
    required List<XFile> files,
    required String folderName,
    required String presetName,
  }) async {
    List<Future<String?>> uploadFutures = [];
    List<String> uploadedUrls = [];

    try {
      Log.i('Starting concurrent file uploads');

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
            cloudinaryUrl,
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

      Log.i("Batch upload complete: $uploadedUrls");

      return uploadedUrls;
    } catch (e) {
      Log.e('Error during batch upload: $e');
      return [];
    }
  }

  /// Delete a file from Cloudinary using public_id

  @override
  Future<bool> deleteFileFromCloudinary(String imageUrl) async {
    try {
      // Extract public_id from the URL
      String? publicId = _extractPublicId(imageUrl);
      if (publicId == null) {
        throw Exception('Failed to extract public_id from URL');
      }

      // Generate a timestamp
      final timestamp =
          (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
      // Create a signature

      String generateSignature(
          String publicId, String timestamp, String apiSecret) {
        final String data =
            'public_id=$publicId&timestamp=$timestamp$apiSecret';
        return sha1.convert(utf8.encode(data)).toString();
      }

      final String signature =
          generateSignature(publicId, timestamp, apiSecret);
      Log.i(signature);

      // Prepare request data
      final data = <String, dynamic>{
        'public_id': publicId,
        'api_key': apiKey,
        'signature': signature,
        'timestamp': timestamp,
      };

      // Make the API call
      final response = await _dio.post(
        "https://api.cloudinary.com/v1_1/$cloudName/image/destroy",
        data: data,
      );

      if (response.statusCode == 200 && response.data['result'] == 'ok') {
        Log.i("File successfully deleted from Cloudinary.");
        return true; // Deletion was successful
      } else {
        Log.e("Failed to delete image: ${response.data}");
        throw Exception("Failed to delete image: ${response.data}");
      }
    } catch (e) {
      Log.e("Error deleting image: $e");
      return false;
    }
  }

  /// Extract public_id from Cloudinary URL
  String? _extractPublicId(String imageUrl) {
    try {
      Uri uri = Uri.parse(imageUrl);
      List<String> segments = uri.pathSegments;

      // Find the 'upload' segment and extract everything after it (excluding version and extension)
      int uploadIndex = segments.indexWhere((segment) => segment == 'upload');
      if (uploadIndex == -1 || uploadIndex + 1 >= segments.length) {
        return null; // Invalid URL structure
      }

      // Remove version and file extension
      String publicIdWithVersion = segments.sublist(uploadIndex + 1).join('/');
      List<String> parts = publicIdWithVersion.split('/');
      parts.removeAt(0); // Remove the version part (e.g., v1736265711)

      String publicId =
          parts.join('/').split('.').first; // Remove the file extension
      return publicId;
    } catch (e) {
      Log.e("Failed to extract public_id: $e");
      return null;
    }
  }
}

// Handle API request and response with error handling
Future<T> _handleRequest<T>(
  Future<dio.Response<dynamic>> Function() request,
  T Function(dynamic) mapper,
) async {
  try {
    final dio.Response response = await request();

    if (response.statusCode == 200) {
      return mapper(response.data);
    } else {
      throw ApiException(
        'Failed to load data: ${response.statusCode}',
        statusCode: response.statusCode!,
      );
    }
  } catch (e) {
    throw ApiException(
      'Failed to load data: $e',
      statusCode: 500,
    );
  }
}

// Custom exception class for API errors
class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, {this.statusCode = 500});
}
