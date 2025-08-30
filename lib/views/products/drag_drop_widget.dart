import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/drag_drop_controller.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';

class DragDropImageUpload extends StatefulWidget {
  const DragDropImageUpload({super.key});

  @override
  State<DragDropImageUpload> createState() => _DragDropImageUploadState();
}

class _DragDropImageUploadState extends State<DragDropImageUpload> {
  late DropzoneViewController _dropzoneController;
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<DragDropController>(
      builder: (context, drop, child) => Stack(
        children: [
          // DropzoneView(
          //   onCreated: (controller) => _dropzoneController = controller,
          //   onHover: () => setState(() => _dragging = true),
          //   onLeave: () => setState(() => _dragging = false),
          //   onDrop: (event) async {
          //     final bytes = await _dropzoneController.getFileData(event);
          //     final name = await _dropzoneController.getFilename(event);
          //     drop.updateDropFile(bytes, name);
          //   },
          // ),
          Container(
            width: double.infinity,
            height: 500,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: Constants.BORDER_RADIUS_20,
              color: _dragging
                  ? Colors.grey.withOpacity(0.2)
                  : Theme.of(context).colorScheme.surfaceTint,
            ),
            child: drop.droppedBytes == null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const DefaultText(
                  txt: "Drop your image here\nor",
                ),
                const SizedBox(height: 5),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all(0),
                    padding: WidgetStateProperty.all(
                        const EdgeInsets.all(15)),
                  ),
                  onPressed: () async {
                    FilePickerResult? result =
                    await FilePicker.platform.pickFiles(
                      type: FileType.image,
                      withData: true, // so we can get bytes on web
                    );

                    if (result != null &&
                        result.files.single.bytes != null) {
                      drop.updateDropFile(
                        result.files.single.bytes!,
                        result.files.single.name,
                      );
                    }
                  },
                  icon: Icon(
                    Iconsax.document_upload,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 20,
                  ),
                  label: DefaultText(
                    txt: 'Browse Images',
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            )
                : ClipRRect(
              borderRadius: Constants.BORDER_RADIUS_20,
              child: Image.memory(
                drop.droppedBytes!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
