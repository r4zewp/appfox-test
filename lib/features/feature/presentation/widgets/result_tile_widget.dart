import 'package:appfox_test/features/feature/domain/entities/test_result_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResultTile extends StatelessWidget {
  const ResultTile({Key? key, required this.result}) : super(key: key);

  final TestResultEntity result;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ],
          color: Colors.grey.shade500,
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  result.category,
                  style: TextStyle(color: Colors.grey.shade900),
                ),
                Text(
                  result.difficulty,
                  style: TextStyle(color: Colors.grey.shade900),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Correct answers: ${result.correctAnswersAmount}',
              style: TextStyle(color: Colors.grey.shade900),
            ),
            Text(
              'Wrong answers: ${result.incorrectAnswersAmount}',
              style: TextStyle(color: Colors.grey.shade900),
            ),
            Text(
              _datetimeToDate(result.date),
              style: TextStyle(color: Colors.grey.shade900),
            ),
          ],
        ),
      ),
    );
  }

  String _datetimeToDate(DateTime date) {
    return DateFormat('dd of MMMM, HH:mm').format(date);
  }
}
