import 'package:demo_flutter_app/component/screenbuilder.dart';
import 'package:demo_flutter_app/data/local/prefapi.dart';
import 'package:demo_flutter_app/data/repoapi.dart';
import 'package:demo_flutter_app/ui/main/blocmain.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BlocBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RepoApi repoApi = Provider.of<RepoApi>(context);
    PrefsHelperApi prefsApi = Provider.of<PrefsHelperApi>(context);

    return MultiProvider(providers: [
      Provider<BlocMain>.value(value: BlocMain(repoApi, prefsApi)),
    ], child: ScreenBuilder());
  }
}
