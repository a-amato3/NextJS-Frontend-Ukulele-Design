import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'renderer_event.dart';
part 'renderer_state.dart';

class RendererBloc extends Bloc<RendererEvent, RendererState> {
  RendererBloc() : super(RendererState.initial()) {
    on<ToggleRenderEvent>(
        (ToggleRenderEvent event, Emitter<RendererState> emit) {
      emit(state.copyWith(overlayVisibility: !state.overlayVisibility));
    });
  }
}
