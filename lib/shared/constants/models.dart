import 'dart:typed_data' show Uint8List;

import 'package:image_picker/image_picker.dart' show XFile;
import 'package:veteranam/shared/models/models.dart';

class FilterItem {
  FilterItem(
    this.value, {
    this.number = 1,
    this.valueEN,
    this.isSelected = false,
  });

  final dynamic value;
  final dynamic valueEN;
  final bool isSelected;
  final int number;

  FilterItem copyWith({
    dynamic value,
    dynamic valueEN,
    bool? isSelected,
    int? number,
  }) {
    return FilterItem(
      value ?? this.value,
      valueEN: valueEN ?? this.valueEN,
      isSelected: isSelected ?? this.isSelected,
      number: number ?? this.number,
    );
  }
}

class FilePickerItem {
  FilePickerItem({
    required this.bytes,
    required this.name,
    required this.ref,
    this.extension,
  });

  final Uint8List bytes;
  final String? extension;
  final String? name;
  final String? ref;

  static Future<FilePickerItem?> getFromImage(XFile? image) async {
    if (image == null) return null;
    final hasExtension = image.name.contains('.');
    return FilePickerItem(
      bytes: await image.readAsBytes(),
      extension: hasExtension
          ? image.name.substring(
              image.name.lastIndexOf('.'),
            )
          : null,
      name: image.name,
      ref: image.path,
    );
  }

  ImageModel image(String downloadURL) => ImageModel(
        downloadURL: downloadURL,
        name: name,
        ref: ref,
        type: extension,
      );

  ResumeModel resume(String downloadURL) => ResumeModel(
        downloadURL: downloadURL,
        name: name,
        ref: ref,
        type: extension,
      );
}
