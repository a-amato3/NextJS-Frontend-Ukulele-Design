import 'package:flutter/material.dart';
import 'package:uke_engraver/ui/layout/constants.dart';
    
class UkeTile extends StatelessWidget {
  final Function? onTap;
  const UkeTile({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
       onTap:() {
         onTap!();
       },

          child: SizedBox(
            height: 300,
            width: 300,
            child: Material(
              elevation: 2,
              color: kTileColor,
              borderRadius: BorderRadius.circular(10),
              child: ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadius: BorderRadius.circular(10.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset('uke_1.png'),
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}
