import 'package:flutter/material.dart';

class StudentPermissionForm extends StatelessWidget {
  final _studentPermissionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Permission',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      controller: _studentPermissionController,
      keyboardType: TextInputType.text,
      autocorrect: false,
    );
  }
}
