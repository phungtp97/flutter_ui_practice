// Flutter code sample for material.AppBar.1

// This sample shows an [AppBar] with two simple actions. The first action
// opens a [SnackBar], while the second action navigates to a new page.
import 'package:demo_flutter_app/data/local/prefapi.dart';
import 'package:demo_flutter_app/data/remote/repo.dart';
import 'package:demo_flutter_app/data/repoapi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_flutter_app/data/local/app_pref.dart';
import 'package:demo_flutter_app/component/blocbuilder.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;

  //provide apprepo
  return runApp(MultiProvider(providers: [
    Provider<RepoApi>.value(value: AppRepo()),
    Provider<PrefsHelperApi>.value(value: AppPreferencesHelper())
  ]
      , child: BlocBuilder()
  )
  );
}
