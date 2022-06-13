import 'package:flutter/material.dart';
import 'package:uke_engraver/core/blocs/draggable_item_list/draggable_item_list_bloc.dart';
import 'package:uke_engraver/core/blocs/renderer/renderer_bloc.dart';
import 'package:uke_engraver/core/models/draggable_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uke_engraver/ui/layout/constants.dart';
import 'package:uke_engraver/ui/widgets/draggable_item_widget.dart';

// bool dragging = false;
double value = 1;
double scale = 0.2;

class UkeEditTile extends StatefulWidget {
  const UkeEditTile({Key? key}) : super(key: key);

  @override
  State<UkeEditTile> createState() => _UkeEditTileState();
}

class _UkeEditTileState extends State<UkeEditTile> {
  @override
  Widget build(BuildContext context) {
    // final List<DraggableItem> items =
    //     context.watch<DraggableItemListBloc>().state.draggableItemList;

    return Stack(
      // fit: StackFit.expand,
      // alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            context.read<DraggableItemListBloc>().add(
                  UnselectAllEvent(),
                );
          },
        ),
        for (DraggableItem item
            in context.watch<DraggableItemListBloc>().state.draggableItemList)
          Positioned(
            left: item.xPosition,
            top: item.yPosition,
            child: DraggableItemWidget(
              itemInput: item,
            ),
          ),
        Visibility(
          visible: context.watch<RendererBloc>().state.overlayVisibility,
          child: IgnorePointer(
            child: Center(
              child: SizedBox(
                child: Image.asset(
                  'uke_full_outline.png',
                  scale: scale,
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: !context.watch<RendererBloc>().state.overlayVisibility,
          child: IgnorePointer(
            child: Opacity(
              opacity: 0.7,
              child: Center(
                child: SizedBox(
                  child: Image.asset(
                    'uke_full_outline.png',
                    scale: scale,
                  ),
                ),
              ),
            ),
          ),
        ),
        IgnorePointer(
          child: Center(
            child: SizedBox(
              child: Image.asset(
                'uke_full.png',
                scale: scale,
              ),
            ),
          ),
        ),
        IgnorePointer(
          child: Opacity(
            opacity: 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.grey,
                  width: 200,
                ),
                Container(
                  color: Colors.grey,
                  width: 200,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 30,
          right: 50,
          child: SizedBox(
              // width: 300,
              child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Rotate object - Mouse wheel',
                      style: kButtonShortcutsStyle),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Scale object - Mouse wheel + Shift',
                      style: kButtonShortcutsStyle),
                ),
              ],
            ),
          )),
        ),
      ],
    );
  }
}

// var _ukeProvider = Provider.of<UkeProvider>(context);
// var _ukeProviderCaller = Provider.of<UkeProvider>(context, listen: false);
// Positioned(
//   left: _ukeProvider.x,
//   top: _ukeProvider.y,
//   child: Draggable(
//     childWhenDragging: Container(),
//     onDragStarted: () {
//       setState(() {
//         dragging = true;
//       });
//     },
//     onDragEnd: (value) {
//       _ukeProviderCaller.updatePosition(
//           value.offset.dx, value.offset.dy - 50);
//     },
//     onDragCompleted: () {},
//     child: SizedBox(
//         height: 50, width: 50, child: Image.asset('pattern_1.png')),
//     feedback: SizedBox(
//         height: 50, width: 50, child: Image.asset('pattern_1.png')),
//   ),
// ),

// Positioned(
//   left: _ukeProvider.x,
//   top: _ukeProvider.y,
//   child: Draggable(
//     onDragStarted: () {},
//     onDragEnd: (value) {
//       _ukeProviderCaller.updatePosition(value.offset.dx, value.offset.dy);
//     },
//     child: SizedBox(
//         height: 50, width: 50, child: Image.asset('pattern_1.png')),
//     feedback: SizedBox(
//         height: 50, width: 50, child: Image.asset('pattern_1.png')),
//   ),
// ),
