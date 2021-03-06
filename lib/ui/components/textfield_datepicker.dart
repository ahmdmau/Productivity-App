import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextFieldDatePicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateFormat dateFormat;
  final FocusNode focusNode;
  final String labelText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;

  TextFieldDatePicker({
    Key? key,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    required this.focusNode,
    required this.dateFormat,
    required this.lastDate,
    required this.firstDate,
    this.initialDate,
    required this.onDateChanged,
  })   : assert(initialDate != null),
        assert(firstDate != null),
        assert(lastDate != null),
        assert(!initialDate!.isBefore(firstDate!),
            'initialDate must be on or after firstDate'),
        assert(!initialDate!.isAfter(lastDate!),
            'initialDate must be on or before lastDate'),
        assert(!firstDate!.isAfter(lastDate!),
            'lastDate must be on or after firstDate'),
        assert(onDateChanged != null, 'onDateChanged must not be null'),
        super(key: key);
  @override
  _TextFieldDatePickerState createState() => _TextFieldDatePickerState();
}

class _TextFieldDatePickerState extends State<TextFieldDatePicker> {
  TextEditingController? _controllerDate;
  DateFormat? _dateFormat;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    if (widget.dateFormat != null) {
      _dateFormat = widget.dateFormat;
    } else {
      _dateFormat = DateFormat("EEEE, d MMMM yyyy", "id_ID");
    }

    _selectedDate = widget.initialDate;

    _controllerDate = TextEditingController();
    _controllerDate?.text = _dateFormat!.format(_selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      controller: _controllerDate,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
      ),
      onTap: () => _selectDate(context),
      readOnly: true,
    );
  }

  @override
  void dispose() {
    _controllerDate?.dispose();
    super.dispose();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: widget.firstDate!,
      lastDate: widget.lastDate!,
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      _controllerDate?.text = _dateFormat!.format(_selectedDate!);
      widget.onDateChanged(_selectedDate!);
    }

    widget.focusNode.nextFocus();
  }
}
