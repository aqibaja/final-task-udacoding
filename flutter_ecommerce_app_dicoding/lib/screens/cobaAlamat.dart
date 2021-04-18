import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class ExampleForm extends StatefulWidget {
  @override
  _ExampleFormState createState() => _ExampleFormState();
}

class _ExampleFormState extends State<ExampleForm> {
  String _myActivity;
  String _myActivityResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivityResult = _myActivity;
      });
    }
  }

  List provinsi = [
    {
      "display": "Running",
      "value": "Running",
    },
    {
      "display": "Climbing",
      "value": "Climbing",
    },
    {
      "display": "Walking",
      "value": "Walking",
    },
    {
      "display": "Swimming",
      "value": "Swimming",
    },
    {
      "display": "Soccer Practice",
      "value": "Soccer Practice",
    },
    {
      "display": "Baseball Practice",
      "value": "Baseball Practice",
    },
    {
      "display": "Football Practice",
      "value": "Football Practice",
    },
    {
      "display": "Running1",
      "value": "Runnin1g",
    },
    {
      "display": "Cl111imbing",
      "value": "Cli1mbing",
    },
    {
      "display": "Waasdasdadslk1ing",
      "value": "Walk1asdasding",
    },
    {
      "display": "S1wimmasdasding",
      "value": "Swi1mmasdasding",
    },
    {
      "display": "So1ccer Practice",
      "value": "Socc1er Practice",
    },
    {
      "display": "Bas1eball Practice",
      "value": "Baseb1all Practice",
    },
    {
      "display": "Fo1o1tball Practice",
      "value": "Foo1tb1all Practice",
    },
    {
      "display": "R1unning",
      "value": "Ru1nning",
    },
    {
      "display": "C1limbing",
      "value": "Cli1mbing",
    },
    {
      "display": "W1aqwdqwdlking",
      "value": "Wal1kasdasdasing",
    },
    {
      "display": "Swiasdasd1mming",
      "value": "Swi1asdasdmming",
    },
    {
      "display": "Socc111er Practice",
      "value": "Soccer P1ractice",
    },
    {
      "display": "Baseba1ll Practice",
      "value": "Baseball Pr1actice",
    },
    {
      "display": "Footba1ll Practice",
      "value": "Footba1ll Practice",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Formfield Example'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: DropDownFormField(
                    titleText: 'Provinsi',
                    hintText: 'Pilih provinsi',
                    value: _myActivity,
                    onSaved: (value) {
                      setState(() {
                        _myActivity = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _myActivity = value;
                      });
                    },
                    dataSource: provinsi,
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  child: Text('Save'),
                  onPressed: _saveForm,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(_myActivity),
              )
            ],
          ),
        ),
      ),
    );
  }
}
