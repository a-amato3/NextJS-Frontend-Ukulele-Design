part of 'draggable_item_list_bloc.dart';

class DraggableItemListState extends Equatable {
  final List<DraggableItem> draggableItemList;

  const DraggableItemListState({
    required this.draggableItemList,
  });

  factory DraggableItemListState.initial() {
    return const DraggableItemListState(draggableItemList: []);
  }

  @override
  List<Object> get props => [draggableItemList];

  @override
  bool get stringify => true;

  DraggableItemListState copyWith({
    List<DraggableItem>? draggableItemList,
  }) {
    return DraggableItemListState(
      draggableItemList: draggableItemList ?? this.draggableItemList,
    );
  }
}
