import 'package:attendance/constant/Constant.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class WidgetCardInfoStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 120,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: greyColor3,
            width: 1.5,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthStudentAuthenticated) {
              return Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        state.student.studentName,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        state.student.studentId,
                        style: TextStyle(
                          color: greyColor2,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5.0),
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(55)),
                        color: greyColor3,
                      ),
                    ),
                  ),
                ],
              );
            }
            return Shimmer.fromColors(
              baseColor: baseShimerColor,
              highlightColor: highLightShimerColor,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Container(width: MediaQuery.of(context).size.width * 0.6, height: 28, color: greyColor3),
                      Container(width: MediaQuery.of(context).size.width * 0.6, height: 20, color: greyColor3),
                      SizedBox(height: 15),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5.0),
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(55)),
                        color: greyColor3,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
