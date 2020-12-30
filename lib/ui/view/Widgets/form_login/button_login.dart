import 'package:attendance/constant/Constant.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/view/Widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonLogin extends StatelessWidget {
  final Function onPressed;

  ButtonLogin({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return WidgetLoadingIndicator(color: primaryColor);
        }
        return RaisedButton(
          color: primaryColor,
          textColor: textColor,
          padding: const EdgeInsets.all(16),
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
          child: Text('LOG IN'),
          onPressed: onPressed,
        );
      },
    );
  }
}
