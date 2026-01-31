import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class VerticalSpace extends StatelessWidget {
  final double space;
  const VerticalSpace({super.key ,required this.space});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(height: space.h,);
  }
}

class HorizontalSpace extends StatelessWidget {
  final double space;
  const HorizontalSpace({super.key ,required this.space});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(width: space.w,);
  }
}
