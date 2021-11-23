import 'package:blog_app/core/firebaseApi.dart';
import 'package:blog_app/core/firebaseManager.dart';
import 'package:blog_app/global_resources.dart';
import 'package:blog_app/provider/loadingProvider.dart';
import 'package:blog_app/view/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
            color: Color.fromRGBO(201, 201, 201, 0.5),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: _height / 6),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: Text("Sign In",
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .merge(TextStyle(
                              fontSize: _height / 20,
                              //color: AppColors.iconTextColor,
                              fontWeight: FontWeight.bold))),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFieldWidget(
                                hintText: 'Email',
                                controller: mail,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFieldWidget(
                                hintText: 'Password',
                                controller: password,
                              ),
                              Consumer<LoadingProvider>(
                                  builder: (key, provider, child) {
                                return provider.getLoadingStatus
                                    ? Align(
                                        alignment: Alignment.bottomRight,
                                        child: SizedBox(
                                            width: _width / 5,
                                            height: _width / 5,
                                            child: CircularProgressIndicator()),
                                      )
                                    : Align(
                                        alignment: Alignment.bottomRight,
                                        child: ClipOval(
                                          child: Material(
                                            elevation: 12.0,
                                            color: primary, // button color
                                            child: InkWell(
                                              child: SizedBox(
                                                  width: _width * 0.15,
                                                  height: _width * 0.15,
                                                  child: Icon(
                                                    Icons.arrow_forward,
                                                    color: Colors.white,
                                                    size: 30,
                                                  )),
                                              onTap: () async {
                                                await signIn(provider);
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                              })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }

  void _showSnackBar(message) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      backgroundColor: Color.fromRGBO(20, 20, 20, 0.7),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(message),
        ],
      ),
      duration: Duration(seconds: 3),
    ));
  }

  signIn(LoadingProvider provider) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        provider.setLoadingStatus();
        print(mail.text);

        FirebaseManager().signIn(mail.text, password.text);
        await FirebaseApi()
            .firebaseAuth!
            .signInWithEmailAndPassword(
                email: mail.text.trim(), password: password.text.trim())
            .then((value) {
          print(1);

          Navigator.pushReplacementNamed(context, rDashboard);
        });
        provider.setLoadingStatus();
      } catch (e) {
        provider.setLoadingStatus();

        _showSnackBar("Email or Password doesn't correct");
      }
    }
  }
}
