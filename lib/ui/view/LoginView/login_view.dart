import 'package:attendance/constant/Constant.dart';
import 'package:attendance/ui/logic/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(30),
        child: _AuthForm(),
      ),
    );
  }
}

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: _SignInForm(),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _studentIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _autoValidate = false;

  _handleLoginButton() {
    if (_key.currentState.validate()) {
      if (_studentIdController == null || _passwordController == null) {
      } else {
        BlocProvider.of<LoginBloc>(context).add(
          LoginStudentWithStudentId(
            studentId: _studentIdController.text,
            password: _passwordController.text,
          ),
        );
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  _showErrorSnackBar(String message, Color color) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          _showErrorSnackBar('Login failed', redColor);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return Center(
              child: Container(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            );
          }

          return Card(
            elevation: 5.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Container(
              height: 350,
              width: 300,
              padding: EdgeInsets.all(20),
              child: Form(
                key: _key,
                autovalidateMode:
                    _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                          'assets/icon/calendar.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Center(
                          child: Text(
                            'Attendance App',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: 'Student ID',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        controller: _studentIdController,
                        keyboardType: TextInputType.name,
                        autocorrect: false,
                        validator: (value) {
                          if (value == null) {
                            return 'student id is required.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        obscureText: true,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null) {
                            return 'Password is required.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      RaisedButton(
                        color: primaryColor,
                        textColor: textColor,
                        padding: const EdgeInsets.all(16),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0)),
                        child: Text('LOG IN'),
                        onPressed: () => _handleLoginButton(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
