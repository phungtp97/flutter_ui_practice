package com.lecle.demo_flutter_app

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
  }

  fun createCognitoUser(){
    /*val user: CognitoUserPool = CognitoUserPool(
            applicationContext,
            BuildConfig.USER_POOL_ID,
            BuildConfig.CLIENT_ID,
            BuildConfig.CLIENT_SECRET,
            Regions.AP_SOUTHEAST_1
    )*/



  }
}
