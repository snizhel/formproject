import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

class FormValidator extends StatefulWidget {
  const FormValidator({Key? key}) : super(key: key);

  @override
  _FormValidatorState createState() => _FormValidatorState();
}

class _FormValidatorState extends State<FormValidator>
    with SingleTickerProviderStateMixin {
  final nameHolder = TextEditingController();
  final phoneHolder = TextEditingController();
  DateTime date = DateTime.now();
  TextEditingController dateCtl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  clearTextInput() {
    phoneHolder.clear();
    nameHolder.clear();
    dateCtl.clear();
  }

  String Name = "";
  String Phone = "";
  String DOB = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form")),
      body: Form(
        child: SingleChildScrollView(
            child: Column(
          key: _formKey,
          children: [
            TextFormField(
              controller: nameHolder,
              keyboardType: TextInputType.name,
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },
              decoration: InputDecoration(
                  // prefixIcon: Padding(
                  //   padding: EdgeInsets.only(
                  //       bottom: 5, top: 2), // add padding to adjust icon
                  //   child: Icon(Icons.account_circle),
                  // ),
                  hintText: "Input your full name",
                  icon: Icon(Icons.person),
                  labelText: "Name",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      nameHolder.clear();
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0))),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: phoneHolder,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                  // prefixIcon: Padding(
                  //   padding: EdgeInsets.only(
                  //       bottom: 5, top: 2), // add padding to adjust icon
                  //   child: Icon(Icons.contact_phone),
                  // ),
                  hintText: "Input your phone",
                  icon: Icon(Icons.phone_iphone),
                  labelText: "Phone",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      phoneHolder.clear();
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0))),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: dateCtl,
              readOnly: true,
              decoration: InputDecoration(
                  // prefixIcon: Padding(
                  //   padding: EdgeInsets.only(
                  //       bottom: 5, top: 2), // add padding to adjust icon
                  //   child: Icon(Icons.date_range),
                  // ),
                  hintText: 'Your day of birth',
                  icon: Icon(Icons.date_range),
                  labelText: 'Date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      dateCtl.clear();
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              onTap: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2220),
                  errorFormatText: 'Enter valid date',
                  errorInvalidText: 'Enter date in valid range',
                );
                if (dateCtl != null && dateCtl != date) {
                  setState(() => dateCtl.text = date.toString());
                  print(dateCtl);
                } else {
                  print(dateCtl);
                }
                // ).then((selectedDate) {
                //   setState(() {
                //     date = selectedDate;
                //   });
                // });
              },
              validator: (date) {
                if (date == null || date.isEmpty) {
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
                      onPressed: clearTextInput,
                      child: Text("Clear"))),
              SizedBox(
                width: 16,
              ),
              Expanded(
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.greenAccent),
                      onPressed: () {
                        setState(() {
                          Name = nameHolder.text;
                          Phone = phoneHolder.text;
                          DOB = dateCtl.text;
                        });
                        if (_formKey.currentState!.validate()) {
                          return;
                        }
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("New Notification"),
                        ));
                      },
                      child: Text("Get Detail")))
            ]),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(left: 120.0),
              child: Row(
                children: <Widget>[
                  Text("Hi, Your Name is :   " + Name),
                  Text("Hi, Your Phone is :   " + Phone),
                  Text("Hi, Your DOB is :   " + DOB),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
