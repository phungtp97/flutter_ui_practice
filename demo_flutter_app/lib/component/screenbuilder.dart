import 'package:demo_flutter_app/ui/main/blocmain.dart';
import 'package:demo_flutter_app/ui/main/materialapp.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ScreenBuilder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [

        ],
        child: Application(Provider.of<BlocMain>(context))
    );
  }
}