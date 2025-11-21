import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String imageLink;
  const SocialButton({
    super.key,
    required this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Color(0xffF83758),
      child: CircleAvatar(
        radius: 24,
        backgroundColor: Color(0xffFCF3F6),
        child: Center(
          child: Image.asset(
              imageLink
          ),
        ),
      ),
    );
  }
}
