import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

import '../../../../helper/log_printer.dart';
import '../../../repository/api_services.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  ApiServices apiService = ApiServices();
  CarouselSliderController carouselSliderController =
  CarouselSliderController();
  final notificationCount = 2.obs;

  /// for Banner   ///

  List<String> sliderPicture = [
    'https://img.freepik.com/free-vector/flat-design-food-sale-banner-with-special-offer_23-2149113276.jpg',
    'https://cdn.grabon.in/gograbon/images/web-images/uploads/1618575517942/food-coupons.jpg',
    'https://img.freepik.com/free-photo/hamburger-with-tomato-it_1340-26747.jpg?t=st=1715672660~exp=1715676260~hmac=2e840429e8c9fdbd57ece58b65f5328d58e63294ceabb94f2532aa306df146a0&w=1380',
    'https://static.toiimg.com/thumb/imgsize-23456,msid-68229674,width-600,resizemode-4/68229674.jpg',
  ];
  final RxInt bannerCurrentIndex = 0.obs;

  // final Rx<List<Meal>> canadianMeals = Rx([]);
  final canadianMeals = [].obs;
  final categoriesProducts = [].obs;
  final recommendedProductList = [].obs;

  void fetchFoodProducts() async {
    try {
      final products = await apiService.getFoodProducts();
      canadianMeals.assignAll(products.meals!);
      recommendedProductList.value = products.meals!.reversed.toList();
    } catch (e) {
      // handleException(e);
      Log.e(' Fetching Error');
    }
  }

  // void fetchCategoriesProducts() async {
  //   try {
  //     final products = await apiService.getCategoriesProduct();
  //     categoriesProducts.assignAll(products.categories);
  //     // flashSalesList.value = products.reversed.toList();
  //   } catch (e) {
  //     handleException(e);
  //   }
  // }

  @override
  void onInit() {
    carouselSliderController;
    fetchFoodProducts();
    super.onInit();
  }
}
