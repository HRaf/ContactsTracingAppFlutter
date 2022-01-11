// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations
import 'dart:convert';
import 'dart:io';
import 'package:covid/covtest.dart';
import 'package:covid/models/covtest_model.dart';
import 'package:covid/usercertificates.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ContactsTracingApp",
      home: MyHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

//
class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String? barcodeScanRes;
  //final covtest = Covtestmodel.onlyqr("pop:$barcodeScanRes");
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Covid-19 | Contacts Tracing'),
        backgroundColor: const Color(0xff00BFA6),
      ),
      body: SingleChildScrollView(
          child: Center(
              child: Column(
        children: <Widget>[
          Image.asset("assets/images/doctors.png"),
          HealthPass(),
          SizedBox(height: 20),
          ContactTracing(),
          SizedBox(height: 20),
          News(),
          SizedBox(height: 20),
        ],
      ))),
      //Qr code scannnig
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scanBarcode();
        },
        child: FaIcon(
          FontAwesomeIcons.qrcode,
          color: Colors.white,
          size: 25.0,
        ),
        backgroundColor: Color(0xff00BFA6),
      ),
    );
  }

  //Barcode function
  Future scanBarcode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#00BFA6", "cancel", true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to scan the Qr code';
    }
    if (!mounted) return;
    setState(() => this.barcodeScanRes = barcodeScanRes);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Qr code: $barcodeScanRes"),
    ));
    final covtest = Covtestmodel.onlyqr("$barcodeScanRes");

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CovTest(
                covtestmodel: covtest,
              )),
    );
  }
}

//Healh Pass

class HealthPass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " Health pass",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          textDirection: TextDirection.ltr,
        ),
        //Card
        GestureDetector(
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserCertificates()),
                ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(22.0),
                color: Colors.white,
                width: 370,
                height: 130,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Open my wallet",
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0)),
                          SizedBox(height: 10),
                          Text("Your test and vaccination certificates",
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 15.0)),
                        ],
                      ),
                    ),
                    Image.asset("assets/images/certificates.png")
                  ],
                ),
              ),
            )),
      ],
    );
  }
}

//Contact Tracing
class ContactTracing extends StatefulWidget {
  const ContactTracing({Key? key}) : super(key: key);

  @override
  _ContactTracingState createState() => _ContactTracingState();
}

class _ContactTracingState extends State<ContactTracing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  //scan Qr code
  String? barcodeScanRes;
  Future scanBarcode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#00BFA6", "cancel", true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to scan the Qr code';
    }
    if (!mounted) return;
    setState(() => this.barcodeScanRes = barcodeScanRes);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Qr code: $barcodeScanRes"),
    ));
    final covtest = Covtestmodel.onlyqr("$barcodeScanRes");

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CovTest(
                covtestmodel: covtest,
              )),
    );
  }

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " Contact tracing",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.start,
        ),
        //Card
        GestureDetector(
            onTap: () => scanBarcode(),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(22.0),
                color: Colors.white,
                width: 370,
                height: 130,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Scan a venue QR code",
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0)),
                          SizedBox(height: 10),
                          Text("Be alerted in case of explosure in a venue",
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 15.0)),
                        ],
                      ),
                    ),
                    //Image.asset("assets/images/splash_img.png")
                    FaIcon(
                      FontAwesomeIcons.qrcode,
                      size: 60.0,
                      color: Color(0xff00BFA6),
                    )
                  ],
                ),
              ),
            ))
      ],
    );
  }
}



// News
class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " News",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.start,
        ),
        //Card
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(22.0),
              color: Colors.white,
              width: 370,
              height: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vaccination coverage (Morocco)",
                    textDirection: TextDirection.ltr,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Updated daily",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(fontSize: 15.0),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "89,8%",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

//Qr code scanning
class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
