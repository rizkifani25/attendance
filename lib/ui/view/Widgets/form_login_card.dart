import 'package:attendance/constant/Constant.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/view/Widgets/loading_indicator.dart';
import 'package:attendance/ui/view/Widgets/notification_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetFormLogin extends StatefulWidget {
  @override
  _WidgetFormLoginState createState() => _WidgetFormLoginState();
}

class _WidgetFormLoginState extends State<WidgetFormLogin> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _lecturerEmailController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _autoValidate = false;

  _handleLoginLecturerButton() {
    if (_key.currentState.validate()) {
      if (_lecturerEmailController == null || _passwordController == null) {
      } else {
        BlocProvider.of<LoginBloc>(context).add(
          LoginLecturerWithLecturerEmail(
            lecturerEmail: _lecturerEmailController.text,
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

  _handleLoginStudentButton() {
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

  _handleLoginAsLecturerButton() {
    BlocProvider.of<PageBloc>(context).add(RenderSelectedPage(pageState: 'loginLecturer'));
  }

  _handleLoginAsStudentButton() {
    BlocProvider.of<PageBloc>(context).add(RenderSelectedPage(pageState: 'loginStudent'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          WidgetNotificationSnackbar().render(
            context: context,
            color: redColor,
            message: state.message,
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return WidgetLoadingIndicator(color: primaryColor);
          }
          return Card(
            elevation: 5.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Container(
              height: 400,
              width: 300,
              padding: EdgeInsets.all(20),
              child: Form(
                key: _key,
                autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
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
                      BlocBuilder<PageBloc, PageState>(
                        builder: (context, state) {
                          if (state is StudentLoginViewState) {
                            return TextFormField(
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
                                  return 'Student id is required.';
                                }
                                return null;
                              },
                            );
                          } else {
                            return TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                isDense: true,
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: 'Lecturer Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                              controller: _lecturerEmailController,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              validator: (value) {
                                if (value == null) {
                                  return 'Email is required.';
                                }
                                return null;
                              },
                            );
                          }
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
                      SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<PageBloc, PageState>(
                        builder: (context, state) {
                          if (state is LecturerLoginViewState) {
                            return RaisedButton(
                              color: primaryColor,
                              textColor: textColor,
                              padding: const EdgeInsets.all(16),
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                              child: Text('LOG IN'),
                              onPressed: () => _handleLoginLecturerButton(),
                            );
                          }
                          if (state is StudentLoginViewState) {
                            return RaisedButton(
                              color: primaryColor,
                              textColor: textColor,
                              padding: const EdgeInsets.all(16),
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                              child: Text('LOG IN'),
                              onPressed: () => _handleLoginStudentButton(),
                            );
                          }
                          return WidgetLoadingIndicator(color: primaryColor);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<PageBloc, PageState>(
                        builder: (context, state) {
                          if (state is LecturerLoginViewState) {
                            return Center(
                              child: InkWell(
                                child: Text(
                                  'Login as a Student',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: blueColor,
                                  ),
                                ),
                                onTap: () {
                                  _handleLoginAsStudentButton();
                                },
                              ),
                            );
                          }
                          if (state is StudentLoginViewState) {
                            return Center(
                              child: InkWell(
                                child: Text(
                                  'Login as a Lecturer',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: blueColor,
                                  ),
                                ),
                                onTap: () {
                                  _handleLoginAsLecturerButton();
                                },
                              ),
                            );
                          }
                          return WidgetLoadingIndicator(color: primaryColor);
                        },
                      ),
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
