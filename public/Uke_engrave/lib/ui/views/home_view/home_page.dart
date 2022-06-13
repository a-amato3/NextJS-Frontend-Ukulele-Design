import 'package:flutter/material.dart';
import 'package:uke_engraver/core/services/providers/new_provider.dart';
import 'package:uke_engraver/ui/views/home_view/components/uke_tile.dart';
import 'package:uke_engraver/ui/views/uke_edit_view/Uke_edit_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _ukeProvider = Provider.of<UkeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Uke it!'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UkeTile(
                onTap: () {
                  _ukeProvider.chooseUke(0);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)
                      => const UkeEditPage(),
                    ),
                  );
                },
              ),
              UkeTile(
                onTap: () {
                  _ukeProvider.chooseUke(1);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)
                      => const UkeEditPage(),
                    ),
                  );
                },
              ),
              UkeTile(
                onTap: () {
                  _ukeProvider.chooseUke(2);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)
                      => const UkeEditPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
