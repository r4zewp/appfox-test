import 'package:flutter/material.dart';

class SubmitButtonWidget extends StatefulWidget {
  const SubmitButtonWidget({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;

  @override
  State<SubmitButtonWidget> createState() => _SubmitButtonWidgetState();
}

class _SubmitButtonWidgetState extends State<SubmitButtonWidget> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height * 0.05,
      width: screenSize.width * 0.75,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade500,
          splashFactory: NoSplash.splashFactory,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        child: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
