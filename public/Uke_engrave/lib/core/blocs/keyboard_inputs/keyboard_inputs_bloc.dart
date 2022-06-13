import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'keyboard_inputs_event.dart';
part 'keyboard_inputs_state.dart';

class KeyboardInputsBloc
    extends Bloc<KeyboardInputsEvent, KeyboardInputsState> {
  KeyboardInputsBloc() : super(KeyboardInputsState.initial()) {
    on<ControlPressEvent>(_controlPress);
  }

  void _controlPress(
      ControlPressEvent event, Emitter<KeyboardInputsState> emit) {
    final keyPressed = event.pressed;
    emit(state.copyWith(controlPressed: keyPressed));
  }
}
