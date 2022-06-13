part of 'keyboard_inputs_bloc.dart';

class KeyboardInputsState extends Equatable {
  final bool controlPressed;
  const KeyboardInputsState({
    required this.controlPressed,
  });

  factory KeyboardInputsState.initial() {
    return const KeyboardInputsState(controlPressed: false);
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [controlPressed];

  KeyboardInputsState copyWith({
    bool? controlPressed,
  }) {
    return KeyboardInputsState(
      controlPressed: controlPressed ?? this.controlPressed,
    );
  }
}
