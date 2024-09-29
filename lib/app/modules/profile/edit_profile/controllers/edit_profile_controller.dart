import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  //TODO: Implement EditProfileController


  //     For Profile photo
  final Rx<XFile?> selectedProfilePhoto = Rxn<XFile>();
  final exceptions = "".obs;

  Future<void> getProfileImageFromFile() async {
    final XFile? pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedProfilePhoto.value = pickedImage;
      exceptions.value = pickedImage.path.toString();
    }else {
      return ;
    }
  }

  Future<void> getProfileImageFromCamera() async {
    final XFile? pickedImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      selectedProfilePhoto.value = pickedImage;
      // imagePath.value = pickedImage.path;
    } else {
      return;
    }
  }

  RxString selectedGender = ''.obs;
  final List dropDownClassList = [
    'Male'.tr,
    'Female'.tr,
    'Others'.tr,

  ];
  void upDateSelectedGender(String value) {
    selectedGender.value = value;
  }


  // for Date pick

  // TextEditingController leaveReasonController = TextEditingController();
  Rx<dynamic> myData = Rx<DateTime>(DateTime.now());
  late final date = "".obs;

  void setDate(DateTime? data) {
    myData.value = data;
    date.value =
    '${myData.value!.day}/${myData.value!.month}/${myData.value!.year}';
  }
}
