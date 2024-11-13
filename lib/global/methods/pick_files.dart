import 'package:image_picker/image_picker.dart';
import 'package:import_mark/global/log_printer.dart';

class PickFiles {
  static Future<XFile?> pickSingleFile(
      {required ImageSource imageSource}) async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: imageSource);
    if (pickedImage != null) {
      return pickedImage;
    } else {
      Log.e(pickedImage);
      return null;
    }
  }
}
