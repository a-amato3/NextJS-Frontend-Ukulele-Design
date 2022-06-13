import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class DraggableItem extends Equatable {
  final String itemKey;
  final double xPosition;
  final double yPosition;
  final double scale;
  final double rotation;
  final bool show;
  final bool selected;
  final Widget child;

  DraggableItem({
    String? itemKey,
    double? xPosition,
    double? yPosition,
    this.scale = 1,
    this.rotation = 0,
    this.show = true,
    bool? selected,
    Widget? child,
  })  : this.itemKey = itemKey ?? uuid.v4(),
        this.xPosition = xPosition ?? 75,
        this.yPosition = yPosition ?? 75,
        this.child = child ?? Container(),
        this.selected = selected ?? false;

  // copyParts(DraggableItem item) {
  //   DraggableItem newitem = item;
  //   return newitem;
  // }

  @override
  List<Object> get props {
    return [
      itemKey,
      xPosition,
      yPosition,
      scale,
      rotation,
      child,
      selected,
    ];
  }
}
