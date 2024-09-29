import 'package:dio/dio.dart';
import 'package:import_mark/app/models/foods_product_model.dart';

//
const String canadianFoodsApiEndPoint =
    "https://www.themealdb.com/api/json/v1/1/filter.php?a=Canadian";
const String categoriesProductApiEndPoint =
    "https://www.themealdb.com/api/json/v1/1/categories.php";

abstract class ApiService {
  Future<FoodsProductModel> getFoodProducts();
  // Future<FoodsProductModel> getCategoriesProduct();
}

class ApiServices implements ApiService {
  final Dio _dio = Dio();
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
