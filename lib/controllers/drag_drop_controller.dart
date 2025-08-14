import 'dart:typed_data';
import 'package:flutter/material.dart';

class DragDropController extends ChangeNotifier {
  Uint8List? droppedBytes;
  String? droppedFileName;

  void updateDropFile(Uint8List bytes, String name) {
    droppedBytes = bytes;
    droppedFileName = name;
    notifyListeners();
  }

  void clear() {
    droppedBytes = null;
    droppedFileName = null;
    notifyListeners();
  }
}
