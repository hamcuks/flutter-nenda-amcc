import 'package:flutter/material.dart';
import 'package:nenda_invfest/data/model/pendakian_model.dart';

import '../../constant.dart';

class AppDropdown extends StatefulWidget {
  final TextEditingController controller;
  final List<JalurPendakian> data;
  AppDropdown({Key? key, required this.data, required this.controller})
      : super(key: key);

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: _selectedValue,
      isExpanded: true,
      hint: Text(
        "Pilih Jalur Pendakian",
        style: NendaStyles.fontParagraph,
      ),
      underline: Container(
        width: double.infinity,
        height: 2,
        color: _selectedValue != null ? kOrange : Colors.black26,
      ),
      items: widget.data
          .map(
            (e) => DropdownMenuItem(
              child: Text(
                e.namaJalur.toString(),
                style: NendaStyles.fontParagraph,
              ),
              value: e.namaJalur.toString(),
            ),
          )
          .toList(),
      onChanged: (dynamic newValue) {
        setState(() {
          _selectedValue = newValue;
          widget.controller.text = newValue;
        });
      },
    );
  }
}
