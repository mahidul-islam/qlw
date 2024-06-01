import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:qlw_parser/app/data/qlw.dart';

class HomeController extends GetxController {
  final Rx<QlwFile?> qlwFile = Rx(null);

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['qlw'],
    );

    if (result != null) {
      Uint8List? bytes = result.files.single.bytes;
      if (bytes != null) {
        qlwFile.value = await parseQlwFile(bytes);
      }
    }
  }
}
