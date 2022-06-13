// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'renderer_bloc.dart';

class RendererState extends Equatable {
  final bool overlayVisibility;

  const RendererState({required this.overlayVisibility});

  factory RendererState.initial() {
    return const RendererState(overlayVisibility: false);
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [overlayVisibility];

  RendererState copyWith({
    bool? overlayVisibility,
  }) {
    return RendererState(
      overlayVisibility: overlayVisibility ?? this.overlayVisibility,
    );
  }
}
