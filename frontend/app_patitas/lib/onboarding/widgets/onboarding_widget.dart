import 'package:flutter/material.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  State<OnboardingWidget> createState() => _SplashContentState();
}

class _SplashContentState extends State<OnboardingWidget> {
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).colorScheme;
    return Column(
      children: <Widget>[
        const Spacer(),
        Text(
          "TIENDA TIANGUIS",
          style: TextStyle(
            fontSize: 32,
            color: myColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          widget.text!,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 2),
        Image.asset(
          widget.image!,
          height: 265,
          width: 235,
        ),
      ],
    );
  }
}
