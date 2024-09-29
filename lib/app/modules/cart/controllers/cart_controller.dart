import 'package:flutter_add_to_cart_button/flutter_add_to_cart_button.dart';
import 'package:get/get.dart';
import '../../../models/foods_product_model.dart';

class CartController extends GetxController {
  //TODO: Implement CartController
  AddToCartButtonStateId stateId = AddToCartButtonStateId.idle;
  void updateStateId(AddToCartButtonStateId newStateId) {
    stateId = newStateId;
    update();

    /// This will notify all Obx widgets that depend on this controller.
  }

  final cartedItemsList = RxList<String>([]);

  void addToCartList(Meal productId) {
    if (!cartedItemsList.contains(productId.idMeal!)) {
      cartedItemsList.add(productId.idMeal!);
      update();
    }
  }

  void removeToCartList(Meal productId) {
    cartedItemsList.remove(productId.idMeal!);
    update();
  }

  final demo = [].obs;
  List<String> extraAddedItemList = [
    "Add Cheese",
    "Add Meat (Extra Patty)",
  ];
  List<String> extraAddedItemPrice = ["0.30", "1.00"];

  final productQuantity = 1.obs;
}
