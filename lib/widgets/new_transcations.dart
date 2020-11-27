import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTranscations extends StatefulWidget {
  final Function addNew;

  NewTranscations(this.addNew);

  @override
  _NewTranscationsState createState() => _NewTranscationsState();
}

class _NewTranscationsState extends State<NewTranscations> {
  final TextEditingController expenseTitle = TextEditingController();

  final TextEditingController expenseAmount = TextEditingController();
  DateTime selectedDate;

  void onSubmit() {
    final enteredTitle = expenseTitle.text;
    final enteredAmount = expenseAmount.text;
    if (enteredTitle == null || enteredAmount == null || selectedDate == null) {
      return;
    }
    widget.addNew(expenseTitle.text, double.parse(expenseAmount.text), selectedDate);
    Navigator.of(context).pop();
  }

  void datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
          selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: expenseTitle,
              onSubmitted: (_) => onSubmit(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.number,
              controller: expenseAmount,
              onSubmitted: (_) => onSubmit(),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                Text(
                 selectedDate == null ? 'No Date Choosen' : DateFormat.yMd().format(selectedDate),
                ),
                FlatButton(
                  onPressed: datePicker,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            FlatButton(
                onPressed: onSubmit,
                child: Text(
                  'Add Transcation',
                ),
                color: Colors.lightBlue),
          ],
        ),
      ),
    );
  }
}
