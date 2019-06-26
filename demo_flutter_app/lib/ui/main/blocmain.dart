import 'package:demo_flutter_app/data/local/prefapi.dart';
import 'package:demo_flutter_app/data/repoapi.dart';
import 'package:demo_flutter_app/utils/constants/apiendpoint.dart';
import 'package:rxdart/rxdart.dart';
import 'package:demo_flutter_app/base/basebloc.dart';

class BlocMain extends BlocBase{
  RepoApi repoApi;
  bool isOpen = false;
  PrefsHelperApi prefsHelper;
  BlocMain(this.repoApi, this.prefsHelper) : super(repoApi, prefsHelper){
    _resultStream = new PublishSubject(onListen: () {}, onCancel: () {});
    _stateStream = new PublishSubject(onListen: (){}, onCancel: () {});
    _isOpenStream = new PublishSubject(onListen: (){}, onCancel: (){});
    _stateStream.add(false);
  }
  //rx result
  PublishSubject<String> _resultStream;
  Observable<String> get resultObservable => _resultStream.stream;

  PublishSubject<bool> _isOpenStream;
  Observable<bool> get isOpenObservable => _isOpenStream.stream;

  //state
  PublishSubject<bool> _stateStream;
  Observable<bool> get stateObservable => _stateStream.stream;


  bool state = false;
  @override
  void dispose() {
    _resultStream.close();
    _stateStream.close();
  }

  void getResultString(){
    Future.delayed(Duration(milliseconds: 2000
    ), () {
      _resultStream.sink.add(repoApi.getSampleString());
    });
  }
  void changeState(bool newState){
    _stateStream.sink.add(newState);
  }

  void changeOpen(){
    isOpen = !isOpen;
    _isOpenStream.sink.add(isOpen);
  }

  /*demoCognito() async{
    final userPool = new CognitoUserPool(
        ApiEndPoint.USER_POOL_ID, ApiEndPoint.CLIENT_ID);
    final cognitoUser = new CognitoUser(
        'phungta@orgos.net', userPool);
    final authDetails = new AuthenticationDetails(
        username: 'phungta@orgos.net', password: 'test01');

    CognitoUserSession session;
    try {
      session = await cognitoUser.authenticateUser(authDetails);
    } on CognitoUserException catch (e) {
    } catch (e) {
      print(e);
    }
  }*/

}