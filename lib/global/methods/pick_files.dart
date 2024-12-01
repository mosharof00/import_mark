import 'package:image_picker/image_picker.dart';
import 'package:import_mark/global/log_printer.dart';

class PickFile {
  static Future<XFile?> pickSingleFile(
      {required ImageSource imageSource}) async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: imageSource);
    if (pickedImage != null) {
      Log.i("$pickedImage path is: ${pickedImage.path}");
      return pickedImage;
    } else {
      Log.e("Picked file is null");
      return null;
    }
  }

  static Future<List<XFile>?> pickMultiFile() async {
    final ImagePicker picker = ImagePicker();

    try {
      // Pick multiple images
      final List<XFile>? pickedFiles = await picker.pickMultiImage();

      // If images are selected, return the list
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        return pickedFiles;
      } else {
        Log.e("Picked file is null");
        return null; // No images selected
      }
    } catch (e) {
      Log.e("Error picking images: $e");
      return null; // In case of error, return null
    }
  }
}
