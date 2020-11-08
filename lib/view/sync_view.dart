import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart' as google;
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/tasks_view/tasks.dart';

class SyncView extends StatefulWidget {
  @override
  _SyncViewState createState() => _SyncViewState();
}

class _SyncViewState extends State<SyncView> {
  google.GoogleSignIn googleSignIn;
  final String clientID =
      "7425334217-eckkm2ram44cjnokt0hd7n1tv2e63msc.apps.googleusercontent.com";
  @override
  void initState() {
    super.initState();
    googleSignIn = google.GoogleSignIn(clientId: clientID, scopes: []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: Style.linearGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                color: const Color(0xfff25454),
                onPressed: () async {
                  final signedIn = await googleSignIn.signIn();
                  print(signedIn);
                  //final auth = await signedIn.authentication;
                  //print(auth.idToken);
                },
                child: Text("Syncronize with Google", style: Style.textStyle1),
              ),
              RaisedButton(
                color: const Color(0xfff25454),
                onPressed: () async {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (ctx) => TaskView()));
                },
                child: Text("Goto Tasks", style: Style.textStyle1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
