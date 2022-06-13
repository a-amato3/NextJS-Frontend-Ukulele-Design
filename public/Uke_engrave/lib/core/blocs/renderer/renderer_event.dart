// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'renderer_bloc.dart';

abstract class RendererEvent extends Equatable {
  const RendererEvent();

  @override
  List<Object> get props => [];
}

class ToggleRenderEvent extends RendererEvent {
  @override
  List<Object> get props => [];
}
