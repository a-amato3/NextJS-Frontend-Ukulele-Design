import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uke_engraver/core/blocs/draggable_item_list/draggable_item_list_bloc.dart';
import 'package:uke_engraver/core/blocs/keyboard_inputs/keyboard_inputs_bloc.dart';
import 'package:uke_engraver/core/blocs/renderer/renderer_bloc.dart';
import 'package:uke_engraver/ui/views/home_view/components/uke_tile.dart';
import 'package:uke_engraver/ui/views/home_view/home_page.dart';
import 'package:uke_engraver/ui/views/uke_edit_view/Uke_edit_page.dart';
import 'locator.dart';
import 'package:uke_engraver/core/services/providers/new_provider.dart';
import 'package:uke_engraver/ui/layout/constants.dart';

void main() {
  runApp(const HomeScreen());
  // setupLocator();
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => RendererBloc()),
        ),
        BlocProvider(
          create: ((context) => KeyboardInputsBloc()),
        ),
        BlocProvider(
          create: ((context) => DraggableItemListBloc(
              keyboardInputsBloc: BlocProvider.of<KeyboardInputsBloc>(context),
              rendererBloc: BlocProvider.of<RendererBloc>(context))),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Uke it!',
        theme: ThemeData(
          primarySwatch: kPrimaryThemeColor,
        ),
        home: const UkeEditPage(),
      ),
    );
  }
}
