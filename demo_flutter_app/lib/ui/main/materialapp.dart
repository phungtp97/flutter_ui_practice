import 'dart:async';

import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blocmain.dart';
import 'package:flare_flutter/flare_actor.dart';

/// This is the stateless widget that the main application instantiates.
// ignore: must_be_immutable
class Application extends StatelessWidget {
  Application(this.bloc);

  static const String _title = 'Flutter Code Sample';
  BlocMain bloc;

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<BlocMain>(context);
    var size;
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xffAC5CB3),
          textSelectionColor: Color(0xffAC5CB3),
        ),
        home: Scaffold(
            body: StreamBuilder(
          stream: bloc.stateObservable,
          builder: (context, snapShot) {
            size = MediaQuery.of(context).size;
            return Container(
                alignment: Alignment.topLeft,
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/red_wave.jpg"),
                  fit: BoxFit.fill,
                )),
                child: Stack(children: [
                  ClipPath(
                    child: Container(
                      height: 200,
                      width: 200,
                      color: Colors.white,
                      alignment: Alignment(-0.2, -0.2),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 40,
                            color: Color(0xffBC2F2F)),
                      ),
                    ),
                    clipper: BottomWaveClipper(),
                  ),
                  ButtonAuth(bloc),
                  Align(
                    alignment: Alignment(-1.0, -0.1),
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      onPressed: () {
                        print("onClick SignIn");
                        bloc.changeState(false);
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          " SignIn",
                          style: TextStyle(
                              color: snapShot.hasData
                                  ? snapShot.data ? Colors.black : Colors.white
                                  : Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-1.0, 0.1),
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      onPressed: () {
                        bloc.changeState(true);
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          " SignUp",
                          style: TextStyle(
                              color: snapShot.hasData
                                  ? snapShot.data ? Colors.white : Colors.black
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(1, 0),
                    heightFactor: 20.0,
                    child: AnimatedContainer(
                      height:
                          snapShot.hasData ? snapShot.data ? 440 : 340 : 340,
                      duration: Duration(milliseconds: 200),
                      width: size.width - 100,
                      decoration: new BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 10.0,
                              spreadRadius: 5.0,
                            )
                          ],
                          gradient: LinearGradient(
                              colors: [Color(0xff6A7798), Color(0xff95ABE0)],
                              begin: const FractionalOffset(-0.5, 0.0),
                              end: const FractionalOffset(0.5, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(20.0))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: snapShot.hasData
                            ? snapShot.data ? signInList() : signUpList(true)
                            : signInList(),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 1.0),
                    child: Stack(
                      alignment: Alignment(0, 1.0),
                      children: <Widget>[
                        Container(
                            height: 125.5,
                            width: 147.5,
                            child: StreamBuilder(
                                stream: bloc.isOpenObservable,
                                builder: (context, snapShot) {
                                  return FlareActor(
                                    'assets/multi_option_btn.flr',
                                    animation: snapShot.hasData
                                        ? snapShot.data
                                            ? "activate"
                                            : "deactivate"
                                        : "activate",
                                    fit: BoxFit.fill,
                                  );
                                })),
                        Container(
                            height: 70,
                            width: 50,
                            color: Colors.transparent,
                            child: FlatButton(
                              onPressed: () {
                                bloc.changeOpen();
                                print("isClick");
                              },
                              splashColor: Colors.transparent,
                            ))
                      ],
                    ),
                  )
                ]));
          },
        )));
  }

  List<Widget> signUpList(bool isOpen) {
    return <Widget>[
      textFieldBuilder(Icons.email, "Type your email"),
      SizedBox(
        height: 8,
      ),
      textFieldBuilder(Icons.lock, "Type your password"),
      Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
              height: 80,
              width: 80,
              child: FlareActor(
                'assets/success_check.flr',
                animation: isOpen ? 'Untitled' : 'Untitled',
                fit: BoxFit.cover,
              ))
        ],
      )
    ];
  }

  List<Widget> signInList() {
    waitAnimation();
    bool isOpen = false;
    return <Widget>[
      textFieldBuilder(Icons.account_circle, "Type your name"),
      SizedBox(
        height: 8,
      ),
      textFieldBuilder(Icons.smartphone, "Type your phone number"),
      SizedBox(
        height: 8,
      ),
      textFieldBuilder(Icons.email, "Type your email"),
      SizedBox(
        height: 8,
      ),
      textFieldBuilder(Icons.lock, "Type your password"),
      SizedBox(
        height: 8,
      ),
      textFieldBuilder(Icons.repeat, "Type one more time"),
      Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
              height: 40,
              width: 40,
              child: FlareActor(
                'assets/success_check.flr',
                animation: isOpen ? 'Untitled' : 'Untitled',
                fit: BoxFit.cover,
              ))
        ],
      )
    ];
  }

  Future<bool> waitAnimation() async {
    Timer(const Duration(milliseconds: 300), () {
      return true;
    });
  }

  Widget textFieldBuilder(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: new BoxDecoration(
            color: Color(0x40ffffff),
            borderRadius: new BorderRadius.all(Radius.circular(20.0))),
        child: TextField(
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            prefixIcon: Icon(icon),
            border: InputBorder.none,
            hintText: text,
          ),
        ),
      ),
    );
  }
}

class ButtonAuth extends StatelessWidget {
  ButtonAuth(this.bloc);

  final BlocMain bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.stateObservable,
      builder: (context, snapShot) {
        return AnimatedContainer(
          width: double.infinity,
          height: double.infinity,
          duration: Duration(milliseconds: 200),
          alignment: Alignment(
              -1.0, snapShot.hasData ? snapShot.data ? 0.1 : -0.1 : -0.1),
          child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 80,
              decoration: new BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 20.0,
                      spreadRadius: 5.0,
                    )
                  ],
                  gradient: LinearGradient(
                      colors: [Color(0xff8775D1), Color(0xffAC5CB3)],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.5, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  borderRadius: new BorderRadius.only(
                      bottomRight: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0))),
              child: Container()),
        );
      },
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 1.2, size.height);
    var firstEndPoint = Offset(size.width, 0);
    path.quadraticBezierTo(
        firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, 0);
    path.quadraticBezierTo(0, 0, 0, 0);

    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
