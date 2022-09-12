import 'package:flutter/material.dart';

class AnswerTileWidget extends StatelessWidget {
  const AnswerTileWidget({
    Key? key,
    required this.screenSize,
    required this.answers,
    required this.index,
    required this.updateIndex,
  }) : super(key: key);

  final Size screenSize;
  final Map<String, dynamic> answers;
  final int index;
  final void Function(int) updateIndex;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      style: ListTileStyle.list,
      tileColor: Colors.grey.shade500,
      onTap: () => updateIndex(index),
      dense: true,
      contentPadding:
          EdgeInsets.only(left: screenSize.width * (16 / screenSize.width)),
      minLeadingWidth: 5,
      leading: Text(
        "${(index + 1)}. ",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      title: Text(
        answers.values.toList()[index],
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}
