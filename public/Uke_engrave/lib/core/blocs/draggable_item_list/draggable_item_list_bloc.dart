import 'dart:async';
import 'dart:js';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uke_engraver/core/blocs/keyboard_inputs/keyboard_inputs_bloc.dart';
import 'package:uke_engraver/core/blocs/renderer/renderer_bloc.dart';
import 'package:uke_engraver/core/models/draggable_item.dart';
import 'package:uke_engraver/ui/views/uke_edit_view/components/uke_edit_tile.dart';

part 'draggable_item_list_event.dart';
part 'draggable_item_list_state.dart';

class DraggableItemListBloc
    extends Bloc<DraggableItemListEvent, DraggableItemListState> {
  final KeyboardInputsBloc keyboardInputsBloc;
  final RendererBloc rendererBloc;
  late final StreamSubscription renderStream;

  DraggableItemListBloc(
      {required this.keyboardInputsBloc, required this.rendererBloc})
      : super(DraggableItemListState.initial()) {
    renderStream = rendererBloc.stream.listen((RendererState rendererState) {
      if (rendererState.overlayVisibility) {
        unSelectitems();
      }
    });

    on<AddDraggableItemEvent>(_addDraggable);
    on<RemoveDraggableItemEvent>(_removeDraggable);
    on<UpdateDraggableItemPositionEvent>(_updateDraggable);
    on<ToggleItemSelectionEvent>(_toggleItemSelection);
    on<UpdateRotationOrScaleEvent>(_updateRotationOrScale);
    on<UnselectAllEvent>(_unselectAll);
    on<CopySelectedWidgetsEvent>(_copyAndPasteWidgets);
    on<FlipItemEvent>(_flipItem);
  }

  void unSelectitems() {
    add(UnselectAllEvent());
  }

  void _addDraggable(
      AddDraggableItemEvent event, Emitter<DraggableItemListState> emit) {
    final newItem =
        DraggableItem(child: event.newWidget, xPosition: 100, yPosition: 100);

    final List<DraggableItem> newItems = [...state.draggableItemList, newItem];

    emit(state.copyWith(draggableItemList: newItems));
  }

  void _removeDraggable(event, emit) {
    final newItems = state.draggableItemList
        .where((DraggableItem item) => !item.selected)
        .toList();

    emit(state.copyWith(draggableItemList: newItems));
  }

  // void _toggleSelected()

  void _updateDraggable(UpdateDraggableItemPositionEvent event,
      Emitter<DraggableItemListState> emit) {
    final newItems = state.draggableItemList.map((DraggableItem draggableItem) {
      if (draggableItem == event.item) {
        bool selected = true;
        double deltaX = event.newX - draggableItem.xPosition;
        double deltaY = event.newY - draggableItem.yPosition;

        if (deltaX < 2 && deltaX > -2 && deltaY < 2 && deltaY > -2) {
          selected = !event.item.selected;
        }

        return DraggableItem(
            itemKey: event.item.itemKey,
            xPosition: event.newX,
            yPosition: event.newY,
            rotation: event.item.rotation,
            child: event.item.child,
            scale: event.item.scale,
            selected: selected);
      }
      return DraggableItem(
          itemKey: draggableItem.itemKey,
          xPosition: draggableItem.xPosition,
          yPosition: draggableItem.yPosition,
          rotation: draggableItem.rotation,
          child: draggableItem.child,
          scale: draggableItem.scale,
          selected: false);
    }).toList();

    emit(state.copyWith(draggableItemList: newItems));
  }

  void _toggleItemSelection(
      ToggleItemSelectionEvent event, Emitter<DraggableItemListState> emit) {
    final newItems = state.draggableItemList.map((DraggableItem draggableItem) {
      return DraggableItem(
          itemKey: draggableItem.itemKey,
          xPosition: draggableItem.xPosition,
          yPosition: draggableItem.yPosition,
          rotation: draggableItem.rotation,
          child: draggableItem.child,
          scale: draggableItem.scale,
          selected: !draggableItem.selected);
    }).toList();

    emit(state.copyWith(draggableItemList: newItems));
  }

  void _updateRotationOrScale(
      UpdateRotationOrScaleEvent event, Emitter<DraggableItemListState> emit) {
    final newItems = state.draggableItemList.map((DraggableItem draggableItem) {
      if (draggableItem.selected == true) {
        if (!keyboardInputsBloc.state.controlPressed) {
          double newScale = event.mouseRotation > 0 ? 0.1 : -0.1;

          return DraggableItem(
              itemKey: draggableItem.itemKey,
              xPosition: draggableItem.xPosition,
              yPosition: draggableItem.yPosition,
              child: draggableItem.child,
              scale: draggableItem.scale + newScale,
              rotation: draggableItem.rotation,
              selected: draggableItem.selected);
        } else {
          double newAngle = event.mouseRotation > 0 ? 2 : -2;

          return DraggableItem(
              itemKey: draggableItem.itemKey,
              xPosition: draggableItem.xPosition,
              yPosition: draggableItem.yPosition,
              child: draggableItem.child,
              scale: draggableItem.scale,
              rotation: draggableItem.rotation + newAngle,
              selected: draggableItem.selected);
        }
      }
      return draggableItem;
    }).toList();
    emit(state.copyWith(draggableItemList: newItems));
  }

  void _unselectAll(
      UnselectAllEvent event, Emitter<DraggableItemListState> emit) {
    final updatedItemList =
        state.draggableItemList.map((DraggableItem draggableItem) {
      return DraggableItem(
          itemKey: draggableItem.itemKey,
          xPosition: draggableItem.xPosition,
          yPosition: draggableItem.yPosition,
          child: draggableItem.child,
          scale: draggableItem.scale,
          rotation: draggableItem.rotation,
          selected: false);
    }).toList();

    emit(state.copyWith(draggableItemList: updatedItemList));
  }

  void _copyAndPasteWidgets(
      CopySelectedWidgetsEvent event, Emitter<DraggableItemListState> emit) {
    List<DraggableItem> newList = state.draggableItemList;
    List<DraggableItem> selectedList = state.draggableItemList
        .where((DraggableItem item) => item.selected)
        .toList();

    unSelectitems();

    for (DraggableItem newItem in selectedList) {
      newItem = DraggableItem(
        xPosition: newItem.xPosition + 100,
        yPosition: newItem.yPosition + 100,
        scale: newItem.scale,
        rotation: newItem.rotation,
        show: newItem.show,
        selected: newItem.show,
        child: newItem.child,
      );

      newList.add(newItem);
    }

    emit(state.copyWith(draggableItemList: newList));
  }

  void _flipItem(FlipItemEvent event, Emitter<DraggableItemListState> emit) {
    final newItems = state.draggableItemList.map((DraggableItem draggableItem) {
      if (draggableItem.selected == true) {
        return DraggableItem(
            itemKey: draggableItem.itemKey,
            xPosition: draggableItem.xPosition,
            yPosition: draggableItem.yPosition,
            child: draggableItem.child,
            scale: draggableItem.scale,
            rotation: draggableItem.rotation + 45,
            selected: draggableItem.selected);
      }
      return draggableItem;
    }).toList();

    emit(state.copyWith(draggableItemList: newItems));
  }

  @override
  Future<void> close() {
    renderStream.cancel();
    return super.close();
  }
}
