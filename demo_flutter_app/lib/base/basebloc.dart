import 'package:demo_flutter_app/data/local/app_pref.dart';
import 'package:demo_flutter_app/data/local/prefapi.dart';
import 'package:demo_flutter_app/data/remote/repo.dart';
import 'package:demo_flutter_app/data/repoapi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: slash_for_doc_comments
/**
 * created by phungtp.
 * Date: 03/06/2018.
 * Inspired: Android-boiler-plate.
 */

Type _typeOf<T>() => T;

abstract class BlocBase {

  BlocBase(AppRepo appRepo
      , AppPreferencesHelper appPreferencesHelper
      );

  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final Widget child;
  final T bloc;
  static RepoApi _repoApi;
  static PrefsHelperApi _prefsHelperApi;
  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>(_repoApi, _prefsHelperApi);

  static AppRepo repoApi(BuildContext context){
    _repoApi = Provider.of<RepoApi>(context);
    return _repoApi;
  }

  static AppPreferencesHelper appPreferencesHelper(BuildContext context){
    _prefsHelperApi = Provider.of<PrefsHelperApi>(context);
    return _prefsHelperApi;
  }

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited<T> provider =
        context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.bloc;
  }
}



class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {
  @override
  void dispose() {
    widget.bloc?.dispose();
    super.dispose();
  }
  RepoApi repoApi;
  PrefsHelperApi _prefsHelperApi;


  _BlocProviderState(this.repoApi, this._prefsHelperApi);

  @override
  Widget build(BuildContext context) {

    return new _BlocProviderInherited<T>(
      bloc: widget.bloc,
      child: widget.child,
      repoApi: repoApi,
      prefsHelperApi: _prefsHelperApi,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
    @required this.repoApi,
    @required this.prefsHelperApi
  }) : super(key: key, child: child);

  final T bloc;
  final RepoApi repoApi;
  final PrefsHelperApi prefsHelperApi;
  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}