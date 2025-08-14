import 'dart:io';
import 'package:file_picker_desktop/file_picker_desktop.dart';

Future<List<File>> pickMultipleFiles() async {
  try {
    final result = await pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths
          .whereType<String>()
          .map((path) => File(path))
          .toList();

      return files;
    } else {
      print('File Dialog Cancelled!');
      return [];
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}
