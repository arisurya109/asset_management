import 'package:file_picker/file_picker.dart';

class PreparationComponentFnc {
  static Future<PlatformFile?> pickedFilePdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile platformFile = result.files.first;

      return platformFile;
    } else {
      return null;
    }
  }
}
