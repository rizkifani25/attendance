import 'package:attendance/constant/Constant.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/view/Widgets/form_login/button_login.dart';
import 'package:attendance/ui/view/Widgets/form_login/login_as.dart';
import 'package:attendance/ui/view/Widgets/loading_indicator.dart';
import 'package:attendance/ui/view/Widgets/notification_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormLogin extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _lecturerEmailController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _passwordController = TextEditingController();

  _handleLoginLecturerButton({@required BuildContext parentContext}) {
    BlocProvider.of<LoginBloc>(parentContext).add(
      LoginLecturerWithLecturerEmail(
        lecturerEmail: _lecturerEmailController.text,
        password: _passwordController.text,
      ),
    );
  }

  _handleLoginStudentButton({@required BuildContext parentContext}) {
    BlocProvider.of<LoginBloc>(parentContext).add(
      LoginStudentWithStudentId(
        studentId: _studentIdController.text,
        password: _passwordController.text,
      ),
    );
  }

  _handleLoginAsLecturerButton({@required BuildContext parentContext}) {
    BlocProvider.of<PageBloc>(parentContext).add(RenderSelectedPage(pageState: 'loginLecturer'));
  }

  _handleLoginAsStudentButton({@required BuildContext parentContext}) {
    BlocProvider.of<PageBloc>(parentContext).add(RenderSelectedPage(pageState: 'loginStudent'));
  }

  InputDecoration inputDecorationStyle({@required String hintText}) {
    return InputDecoration(
      filled: true,
      isDense: true,
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
    );
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
      child: Card(
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
                          decoration: inputDecorationStyle(hintText: 'Student ID'),
                          controller: _studentIdController,
                          keyboardType: TextInputType.name,
                          autocorrect: false,
                          onTap: () {
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          },
                        );
                      } else {
                        return TextFormField(
                          decoration: inputDecorationStyle(hintText: 'Lecturer Email'),
                          controller: _lecturerEmailController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          onTap: () {
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          },
                        );
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    decoration: inputDecorationStyle(hintText: 'Password'),
                    obscureText: true,
                    controller: _passwordController,
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  BlocBuilder<PageBloc, PageState>(
                    builder: (context, state) {
                      if (state is LecturerLoginViewState) return ButtonLogin(onPressed: () => _handleLoginLecturerButton(parentContext: context));
                      if (state is StudentLoginViewState) return ButtonLogin(onPressed: () => _handleLoginStudentButton(parentContext: context));
                      return WidgetLoadingIndicator(color: primaryColor);
                    },
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<PageBloc, PageState>(
                    builder: (context, state) {
                      if (state is LecturerLoginViewState) return LoginAs(text: 'Login as a student', onTap: () => _handleLoginAsStudentButton(parentContext: context));
                      if (state is StudentLoginViewState) return LoginAs(text: 'Login as a lecturer', onTap: () => _handleLoginAsLecturerButton(parentContext: context));
                      return WidgetLoadingIndicator(color: primaryColor);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
