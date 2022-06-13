import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uke_engraver/core/blocs/draggable_item_list/draggable_item_list_bloc.dart';
import 'package:uke_engraver/core/blocs/keyboard_inputs/keyboard_inputs_bloc.dart';
import 'package:uke_engraver/core/blocs/renderer/renderer_bloc.dart';
import 'package:uke_engraver/ui/views/uke_edit_view/components/uke_edit_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

class UkeEditPage extends StatefulWidget {
  const UkeEditPage({Key? key}) : super(key: key);

  @override
  State<UkeEditPage> createState() => _UkeEditPageState();
}

class _UkeEditPageState extends State<UkeEditPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var _ukeProvider = Provider.of<UkeProvider>(context);

    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (value) {
        context.read<KeyboardInputsBloc>().add(
              ControlPressEvent(pressed: value.isShiftPressed),
            );
      },
      child: Listener(
        onPointerSignal: (pointerSignal) {
          if (pointerSignal is PointerScrollEvent) {
            context.read<DraggableItemListBloc>().add(
                  UpdateRotationOrScaleEvent(
                    mouseRotation: pointerSignal.scrollDelta.direction,
                  ),
                );
          }
        },
        child: Scaffold(
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () async {
                  context.read<DraggableItemListBloc>().add(
                        FlipItemEvent(),
                      );
                },
                child: const Icon(
                  Icons.rotate_90_degrees_ccw,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () async {
                  context.read<DraggableItemListBloc>().add(
                        CopySelectedWidgetsEvent(),
                      );
                },
                child: const Icon(
                  Icons.copy,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FloatingActionButton(
                backgroundColor:
                    context.watch<RendererBloc>().state.overlayVisibility
                        ? Colors.black
                        : Colors.white,
                onPressed: () async {
                  context.read<RendererBloc>().add(
                        ToggleRenderEvent(),
                      );
                },
                child: Icon(
                  Icons.brush,
                  color: context.watch<RendererBloc>().state.overlayVisibility
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () async {
                  context.read<DraggableItemListBloc>().add(
                        RemoveDraggableItemEvent(),
                      );
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['png', 'pdf', 'JPG', 'jpg'],
                  );
                  Uint8List file;

                  if (result != null) {
                    file = result.files.single.bytes!;
                    context.read<DraggableItemListBloc>().add(
                          AddDraggableItemEvent(
                            // newWidget: Image.asset('uke_1.png'),
                            newWidget: Image.memory(file),
                          ),
                        );
                  } else {
                    // User canceled the picker
                  }
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFFFFFFF),
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('Design your Uke!'),
          ),
          body: const Center(
            child: UkeEditTile(),
          ),
        ),
      ),
    );
  }
}
