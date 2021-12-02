import 'package:flutter/material.dart';

import '../../constant.dart';

class AppDatePicker extends StatefulWidget {
  final TextEditingController controller;
  AppDatePicker({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  String? selectedDate;

  DateTime currentDate = DateTime.now();

  void _showPicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(currentDate.year, currentDate.month + 1,
          currentDate.weekday + currentDate.day),
    );

    if (pickedDate != null || pickedDate != currentDate) {
      setState(() {
        selectedDate = pickedDate?.toLocal().toString().split(' ')[0];
        widget.controller.text = selectedDate!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => _showPicker(context),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  selectedDate != null ? '$selectedDate' : 'Pilih Tanggal Naik',
                  style: NendaStyles.fontParagraph,
                ),
                Spacer(),
                Icon(Icons.event_outlined),
              ],
            ),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: selectedDate != null ? 2 : 1,
              color: selectedDate != null ? kOrange : Colors.black26,
            )
          ],
        ),
      ),
    );
  }
}
