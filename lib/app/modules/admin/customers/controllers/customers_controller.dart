import 'package:get/get.dart';
import 'package:import_mark/app/modules/home/controllers/home_controller.dart';

class CustomersController extends GetxController {
  //TODO: Implement CustomersController

  // final apiService = ApiServices();
  final customerList = [].obs;
  final isLoading = false.obs;

  Future<void> getCustomers() async {
    // try{
    //   isLoading.value = true;
    //   final response = await apiService.getCustomers();
    //   customerList.value = response.data!;
    //   isLoading.value = false;
    // } catch(e){
    //   handleException(e);
    //   isLoading.value = false;
    // }
    isLoading.value = true;
    customerList.addAll(Get.find<HomeController>().canadianMeals);
    isLoading.value = false;
  }

  @override
  void onInit() {
    getCustomers();
    super.onInit();
  }
}
