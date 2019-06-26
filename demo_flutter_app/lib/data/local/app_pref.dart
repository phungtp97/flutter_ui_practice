import 'package:demo_flutter_app/data/local/prefapi.dart';

class AppPreferencesHelper implements PrefsHelperApi{
  @override
  String getResultString() {
    return "Hello, I'm from AppPreferencesHelper";
  }


}