// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'draggable_item_list_bloc.dart';

abstract class DraggableItemListEvent extends Equatable {
  const DraggableItemListEvent();

  @override
  List<Object> get props => [];
}

class AddDraggableItemEvent extends DraggableItemListEvent {
  final Widget newWidget;

  const AddDraggableItemEvent({
    required this.newWidget,
  });

  @override
  List<Object> get props => [newWidget];
}

class RemoveDraggableItemEvent extends DraggableItemListEvent {
  @override
  List<Object> get props => [];
}

class UpdateDraggableItemPositionEvent extends DraggableItemListEvent {
  final DraggableItem item;
  final double newX;
  final double newY;

  const UpdateDraggableItemPositionEvent({
    required this.item,
    required this.newX,
    required this.newY,
  });
  @override
  String toString() =>
      'UpdateDraggableItemPositionEvent(item: $item, newX: $newX, newY: $newY)';

  @override
  List<Object> get props => [item, newX, newY];
}

class ToggleItemSelectionEvent extends DraggableItemListEvent {
  @override
  List<Object> get props => [];
}

class UpdateScaleEvent extends DraggableItemListEvent {
  final DraggableItem item;
  final double newScale;

  const UpdateScaleEvent({
    required this.item,
    required this.newScale,
  });

  @override
  String toString() => 'UpdateScaleEvent(scale: $newScale)';

  @override
  List<Object> get props => [item, newScale];
}

class UpdateRotationOrScaleEvent extends DraggableItemListEvent {
  final double mouseRotation;

  const UpdateRotationOrScaleEvent({
    required this.mouseRotation,
  });

  @override
  String toString() => 'RotateObject(rotation: $mouseRotation)';

  @override
  List<Object> get props => [mouseRotation];
}

class UnselectAllEvent extends DraggableItemListEvent {
  @override
  List<Object> get props => [];
}

class CopySelectedWidgetsEvent extends DraggableItemListEvent {
  @override
  List<Object> get props => [];
}

class FlipItemEvent extends DraggableItemListEvent {
  @override
  List<Object> get props => [];
}
