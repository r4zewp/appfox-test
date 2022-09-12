import 'package:appfox_test/features/feature/core/router/page_routes.dart';
import 'package:appfox_test/features/feature/presentation/bloc/app/app_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildLoadingAlert(BuildContext context) {
  return BlocConsumer<AppBloc, AppState>(
    listener: (context, state) async {
      if (state is AppResultsSaved) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(PageRoutes.home, (route) => false);
      }
      if (state is AppResultsUploadingFinished) {}
    },
    builder: (context, state) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.grey.shade600,
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CupertinoActivityIndicator(
              color: Colors.white,
            ),
            SizedBox(height: 16),
            Text(
              "Saving results",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
