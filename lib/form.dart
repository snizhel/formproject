import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

class FormValidator extends StatefulWidget {
  const FormValidator({Key? key}) : super(key: key);

  @override
  _FormValidatorState createState() => _FormValidatorState();
}

class _FormValidatorState extends State<FormValidator>
    with SingleTickerProviderStateMixin {
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form")),
      body: Form(
        child: SingleChildScrollView(
            child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hintText: "Input your full name",
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0))),
            ),
            SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "Input your phone",
                  labelText: "Phone",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0))),
            ),
            SizedBox(height: 16),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                  hintText: date.toString(),
                  labelText: 'Date',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              onTap: () async {
                await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2220),
                ).then((selectedDate) {
                  setState(() {
                    date = selectedDate;
                  });
                });
              },
              validator: (selectedDate) {
                if (selectedDate == null || selectedDate.isEmpty) {
                  return 'Please enter date.';
                }
                return "enter time";
              },
            ),
            SizedBox(height: 16),
            Row(children: [
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {},
                      child: Text("Clear"))),
              SizedBox(
                width: 16,
              ),
              Expanded(
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.greenAccent),
                      onPressed: () {},
                      child: Text("Get Detail")))
            ])
          ],
        )),
      ),
    );
  }
}
