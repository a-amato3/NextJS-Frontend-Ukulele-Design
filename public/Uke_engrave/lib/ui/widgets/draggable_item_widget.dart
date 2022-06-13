import 'package:flutter/material.dart';
import 'package:uke_engraver/core/blocs/draggable_item_list/draggable_item_list_bloc.dart';
import 'package:uke_engraver/core/models/draggable_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

class DraggableItemWidget extends StatelessWidget {
  final DraggableItem itemInput;

  const DraggableItemWidget({Key? key, required this.itemInput})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final call = context.read<DraggableItemListBloc>();
    final listen = context.watch<DraggableItemListBloc>();

    return Draggable(
        childWhenDragging: Container(),
        onDragStarted: () {},
        onDragEnd: (value) {
          call.add(
            UpdateDraggableItemPositionEvent(
              item: itemInput,
              newX: value.offset.dx,
              newY: value.offset.dy - 56,
            ),
          );
        },
        onDragCompleted: () {
          // call.add(
          //   ToggleItemSelectionEvent(),
          // );
        },
        child: SelectionItem(
          height: 200 * itemInput.scale,
          width: 200 * itemInput.scale,
          child: itemInput.child,
          selected: itemInput.selected,
          rotation: itemInput.rotation,
          scale: itemInput.scale,
          feedbackWidget: false,
        ),
        feedback: Opacity(
          opacity: 0.8,
          child: SelectionItem(
            height: 200 * itemInput.scale,
            width: 200 * itemInput.scale,
            child: itemInput.child,
            selected: itemInput.selected,
            rotation: itemInput.rotation,
            scale: itemInput.scale,
            feedbackWidget: true,
          ),
        ));
  }
}

class SelectionItem extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final bool selected;
  final double rotation;
  final double scale;
  final bool feedbackWidget;
  const SelectionItem(
      {Key? key,
      required this.height,
      required this.width,
      required this.child,
      required this.selected,
      required this.rotation,
      required this.scale,
      required this.feedbackWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Transform.rotate(
        angle: rotation * (pi / 180),
        child: Material(
          borderRadius: BorderRadius.circular(5),
          color: selected || feedbackWidget
              ? Colors.red.withOpacity(0.3)
              : Colors.white.withOpacity(0),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(child: child),
          ),
        ),
      ),
    );
  }
}
