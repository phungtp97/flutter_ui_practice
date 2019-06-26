import 'package:demo_flutter_app/data/repoapi.dart';
import 'package:dio/dio.dart';

// ignore: slash_for_doc_comments
/**
 * created by phungtp.
 * Date: 03/06/2018.
 * Inspired: Android-boiler-plate.
 */

class AppRepo implements RepoApi {

  AppRepo(){
    print("You have me AppRepo");
  }

  @override
  String getSampleString() {
    return "Hello I'm from AppRepo";
  }

}
