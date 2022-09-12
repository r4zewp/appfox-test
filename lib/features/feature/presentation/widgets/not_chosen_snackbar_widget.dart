import 'package:appfox_test/features/feature/common/constants.dart';
import 'package:flutter/material.dart';

SnackBar buildSnackbar({required double contentWidth, required String title}) {
  return SnackBar(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    width: contentWidth,
    behavior: SnackBarBehavior.floating,
    content: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
