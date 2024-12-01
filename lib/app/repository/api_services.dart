import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:import_mark/app/models/foods_product_model.dart';
import 'package:import_mark/global/log_printer.dart';

//
const String canadianFoodsApiEndPoint =
    "https://www.themealdb.com/api/json/v1/1/filter.php?a=Canadian";
const String categoriesProductApiEndPoint =
    "https://www.themealdb.com/api/json/v1/1/categories.php";

// Cloudinary configuration
const String cloudName = "dvmsjvhmu"; // Replace with your Cloudinary cloud name
const String apiKey = "557245362198125"; // Replace with your Cloudinary API key
const String apiSecret = "70ZkO6Wad7U54_4B-9PmS7dqmLM"; // Replace with your Cloudinary API secret
const String presetName = "import_mark"; // Replace with your Cloudinary preset name

abstract class ApiService {
  Future<FoodsProductModel> getFoodProducts();
  // Future<FoodsProductModel> getCategoriesProduct();


  /// Upload single file to Cloudinary
  // Future<String?> uploadFileToCloudinary({required XFile file, required String folderName});

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



  @override
  Future<bool> deleteFileFromCloudinary(String imageUrl) async {
    try {
      // Extract public_id from the image URL (assuming format: https://res.cloudinary.com/your_cloud_name/image/upload/v1634237280/folder_name/image_name.jpg)
      String publicId = _extractPublicId(imageUrl);

      // Prepare the request data
      FormData formData = FormData.fromMap({
        'public_id': publicId,
        'api_key': apiKey,
        'api_secret': apiSecret,
      });
Log.i("publicId is: $publicId");
      final response = await _dio.post(
        "https://api.cloudinary.com/v1_1/$cloudName/image/destroy",
        data: formData,
      );

      if (response.statusCode == 200 && response.data['result'] == 'ok') {
        return true; // Return true if deletion is successful
      } else {
        throw ApiException("Failed to delete image: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exception (network issues, server errors, etc.)
      throw ApiException("Error deleting image: $e");
    }
  }
  // Extract the public_id from the image URL
  String _extractPublicId(String imageUrl) {
    final regex = RegExp(r"/v\d+/(\S+?)(?=\.\w+$)"); // Regex to match public_id in URL
    final match = regex.firstMatch(imageUrl);
    if (match != null) {
      return match.group(1) ?? "";
    } else {
      throw ApiException("Unable to extract public_id from URL: $imageUrl");
    }
  }
}

//Handle API request and response with error handling
Future<T> _handleRequest<T>(Future<Response<dynamic>> Function() request,
    T Function(dynamic) mapper) async {
  try {
    final response = await request();

    if (response.statusCode == 200) {
      return mapper(response.data);
    } else {
      throw ApiException('Failed to load data: ${response.statusCode}',
          statusCode: response.statusCode!);
    }
  } catch (e) {
    throw ApiException('Failed to load data: $e', statusCode: 500);
  }
}

// Custom exception class for API errors
class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, {this.statusCode = 500});
}

