import 'package:flutter_add_to_cart_button/flutter_add_to_cart_button.dart';
import 'package:get/get.dart';

import '../../../../models/foods_product_model.dart';

class ProductDetailsController extends GetxController {
  //TODO: Implement ProductDetailsController


  AddToCartButtonStateId stateId = AddToCartButtonStateId.idle;
  void updateStateId(AddToCartButtonStateId newStateId) {
    stateId = newStateId;
    update(); // This will notify all Obx widgets that depend on this controller.
  }

  final cartIndex = 0.obs;

  /// For Variation
  final variationChecked = false.obs;
  final variationIndex = 1000.obs;
  final isVariationSelected = false.obs;
  List<int> variationItems = [
    1,
    4,
    8,
    10,
  ];
  List<int> variationItemPrice = [
    100,
    350,
    700,
    800,
  ];

  /// For  Optional Products

  // final optionalProductIndex = 1000.obs;
  //  final optionalSelectedItemsList = RxList<int>([]);

  final List optionalSelectedItemsList = [].obs;
  List<int> optionalProductPrice = [
    150,
    100,
    230,
    400,
    190,
    540,
  ];

  //
  // void addToMenuList(Meal productId) {
  //   if (!menuListItems.contains(productId.idMeal!)) {
  //     menuListItems.add(productId.idMeal!);
  //     update();
  //   }
  // }
  //
  // // for  Sort
  //
  // void removeFromMenuList(Meal productId) {
  //   menuListItems.remove(productId.idMeal!);
  //   update();
  // }

  /// For DrinkItems
  final drinkListItems = RxList<String>([]);

  void addToDrinkList(Meal productId) {
    if (!drinkListItems.contains(productId.idMeal!)) {
      drinkListItems.add(productId.idMeal!);
      update();
    }
  }

  // for  Sort

  void removeDrinkMenuList(Meal productId) {
    drinkListItems.remove(productId.idMeal!);
    update();
  }
}
