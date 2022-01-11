// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:covid/main.dart';
import 'package:covid/models/covtest_model.dart';
import 'package:covid/objectbox.g.dart';
import 'package:covid/usercertificates.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CovTest extends StatelessWidget {
  final Covtestmodel covtestmodel;
  CovTest({required this.covtestmodel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Add a certificate'),
          backgroundColor: const Color(0xff00BFA6),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(children: [
            //Row1
            Row(
              children: [
                //Dropdown
                CertificateType(),
                SizedBox(
                  width: 18.0,
                ),
                // ignore: unnecessary_string_interpolations
                BarcodeWidget(
                  data: "${covtestmodel.qrcode}",
                  barcode: Barcode.qrCode(),
                  width: 150.0,
                  height: 130,
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            CertificatesDetails(),
          ]),
        ));
  }
}

// Dropdown certificates
class CertificateType extends StatefulWidget {
  const CertificateType({Key? key}) : super(key: key);

  @override
  _CertificateTypeState createState() => _CertificateTypeState();
}

class _CertificateTypeState extends State<CertificateType>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String dropdownvalue = 'PCR';

  // List of items in our dropdown menu
  var items = [
    'PCR',
    'Pass sanitaire',
    'Autre',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      // Initial Value
      value: dropdownvalue,

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
      },
    );
  }
}

//
// Certficates Details
class CertificatesDetails extends StatefulWidget {
  const CertificatesDetails({Key? key}) : super(key: key);

  @override
  _CertificatesDetailsState createState() => _CertificatesDetailsState();
}

class _CertificatesDetailsState extends State<CertificatesDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isSwitched = false;
  String posneg = "Negatif";
  Store? _store;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    getApplicationDocumentsDirectory().then((Directory dir) {
      _store = Store(getObjectBoxModel(), directory: dir.path + '/objectbox');
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _store?.close();
  }

  Future addCertificates() async {
    if (_store == null) return;
    final box = _store!.box<Covtestmodel>();
    box.put(Covtestmodel(name: 'zineb', qrcode: 'eee', dateTime: '2022-10-10'));
    Covtestmodel ctm = box.get(1)!;
    String? nm = ctm.name;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Certificate inserted ! $nm"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
                hintText: 'Enter Your Name',
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SwitchListTile(
              title: Text(posneg),
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                  posneg = "Positif";
                });
              },
              activeTrackColor: Colors.red,
              activeColor: Colors.red,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff00BFA6),
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              ),
              child: Text('Add Certificate'),
              onPressed: () {
                addCertificates();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHome()),
                );
              },
            )
          ],
        ));
  }
}
