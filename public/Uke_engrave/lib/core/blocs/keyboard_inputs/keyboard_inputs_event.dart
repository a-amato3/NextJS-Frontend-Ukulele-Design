part of 'keyboard_inputs_bloc.dart';

abstract class KeyboardInputsEvent extends Equatable {
  const KeyboardInputsEvent();

  @override
  List<Object> get props => [];
}

class ControlPressEvent extends KeyboardInputsEvent {
  final bool pressed;

  const ControlPressEvent({
    required this.pressed,
  });

  @override
  String toString() => 'keyPressed(pressed: $pressed)';

  @override
  List<Object> get props => [pressed];
}
