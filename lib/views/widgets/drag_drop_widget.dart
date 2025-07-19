import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/drag_drop_controller.dart';
import 'dart:io';

import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';

class DragDropImageUpload extends StatefulWidget {
  const DragDropImageUpload({super.key});

  @override
  State<DragDropImageUpload> createState() => _DragDropImageUploadState();
}

class _DragDropImageUploadState extends State<DragDropImageUpload> {
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<DragDropController>(
      builder: (context, drop, child) => DropTarget(
        onDragDone: (details) {
          if (details.files.isNotEmpty) {
            drop.updateDropFile(File(details.files.first.path));
          }
        },
        onDragEntered: (details) => setState(() => _dragging = true),
        onDragExited: (details) => setState(() => _dragging = false),
        child: Container(
          width: 200,
          height: 200,
          margin: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: Constants.BORDER_RADIUS_20,
            color: _dragging ? Colors.grey.withOpacity(0.2) : Theme.of(context).colorScheme.surfaceTint,
          ),
          child: drop.droppedFile == null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const DefaultText(txt: "Drop your image here\nor",),
                  const SizedBox(height: 5),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      elevation: WidgetStateProperty.all(0),
                      padding: WidgetStateProperty.all(const EdgeInsets.all(15)),
                    ),
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.image,
                      );

                      if (result != null && result.files.single.path != null) {
                        drop.updateDropFile(File(result.files.single.path!));
                      }
                    },
                    icon: Icon(Iconsax.document_upload, color: Theme.of(context).colorScheme.secondary,size: 20),
                    label: DefaultText(txt: 'Browse Images', color: Theme.of(context).colorScheme.onSurface,),
                  ),
                ],
              )
              : ClipRRect(
              borderRadius: Constants.BORDER_RADIUS_20,
              child: Image.file(drop.droppedFile!, fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
