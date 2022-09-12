import 'package:flutter/material.dart';

class ChoiceTileWidget extends StatefulWidget {
  const ChoiceTileWidget({
    Key? key,
    required this.content,
    required this.title,
    required this.updateValue,
  }) : super(key: key);

  final String title;
  final Map<dynamic, String> content;
  final void Function(String) updateValue;

  @override
  State<ChoiceTileWidget> createState() => _ChoiceTileWidgetState();
}

class _ChoiceTileWidgetState extends State<ChoiceTileWidget> {
  String firstDropdownValue = "notChosen";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey.shade500,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 2),
              spreadRadius: 2.0,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    DropdownButtonHideUnderline(
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          border: Border.all(color: Colors.white),
                        ),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            dropdownColor: Colors.grey.shade500,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            isExpanded: false,
                            isDense: true,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            value: firstDropdownValue,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.white,
                            ),
                            onChanged: (value) {
                              widget.updateValue(value as String);
                              setState(() => firstDropdownValue = value);
                            },
                            items: widget.content.values
                                .map(
                                  (item) => DropdownMenuItem(
                                    value: widget.content.keys.firstWhere(
                                        (element) =>
                                            widget.content[element] == item),
                                    child: Text(
                                      item,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
