import 'dart:io';

import 'package:flutter/cupertino.dart';

class DragDropController extends ChangeNotifier {
  File? _droppedFile;

  void updateDropFile(File droppedFile){
    _droppedFile = droppedFile;
    notifyListeners();
  }

  File? get droppedFile => _droppedFile;
}