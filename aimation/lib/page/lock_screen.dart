import 'dart:async';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';
import 'package:aimation/main.dart';

class LockView extends StatefulWidget {
  static String passcode = _LockViewState.passcode;
  @override
  _LockViewState createState() => _LockViewState();
}

class _LockViewState extends State<LockView> {
  LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _canCheckBio = false;
  bool res;
  String _authorizedOrNot = "not authorized";
  List<BiometricType> _availableBioTypes = List<BiometricType>();

  static String passcode;
  String temp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("authorization"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: <Widget>[
            Text(
              "tap on the icon",
              style: TextStyle(fontSize: 20, fontFamily: "Hind"),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 45,
              width: 45,
              child: 
            FlatButton(
              onPressed: _authorizeNow,
              child: Icon(Icons.fingerprint, size: 45,
                  color: _canCheckBio == true ? Colors.green : Colors.red),
            ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch
        ));
  }

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    setState(() {
      res = canCheckBiometric;
      _canCheckBio = true;
    });
  }

  Future<void> _getListOfBioTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _availableBioTypes = listOfBiometrics;
    });
  }

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;

    try {
      isAuthorized = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Please authenticate",
        useErrorDialogs: false,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) {
      return;
    }
    setState(() {
      print("mounted, isAutzorized : $isAuthorized");
      if (isAuthorized == true) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage(
                  title: '',
                )));
      }
    });
  }
}
