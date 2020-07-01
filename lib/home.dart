import 'dart:developer';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vibration/vibration.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _data = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.blue[100].withAlpha(50),
          child: Column(
            children: [
              kAppBar(),
              kBigButton(),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      (_data != "")
                          ? QrImage(
                              data: _data,
                              padding: EdgeInsets.all(16),
                            )
                          : Container(),
                      (_data != "") ? Text(_data) : Container(),
                      Spacer(),
                      kButton(title: "Scan QR", icon: MaterialCommunityIcons.qrcode_scan),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  scanQRCode() async {
    var options = ScanOptions(
      strings: {
        "cancel": "Cancel",
      },
      android: AndroidOptions(
        useAutoFocus: true,
      ),
    );

    var result = await BarcodeScanner.scan(options: options);

    if ((await Vibration.hasVibrator()) && (result.rawContent != "")) {
      Vibration.vibrate();
      log(result.rawContent);

      setState(() {
        _data = result.rawContent;
      });
    }
  }

  Widget kAppBar() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/logo.png",
            width: 48,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            "ไทยจะนะ",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).primaryColor),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.menu, color: Theme.of(context).primaryColor),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  kButton({String title, IconData icon}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        child: Container(
          height: 66,
          decoration: BoxDecoration(
            color: Colors.purple,
            gradient: new LinearGradient(
              colors: [Colors.green[700], Colors.green],
            ),
            //gradient: flutterGradient.FlutterGradients.grassShampoo(),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 36,
                color: Colors.white,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        onTap: () {
          scanQRCode();
        },
      ),
    );
  }

  kBigButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 110.0,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 1), // changes position of shadow
            )
          ],
        ),
        child: Row(
          children: [
            ClipOval(
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.blue[100].withAlpha(80),
                child: Icon(
                  Icons.search,
                  size: 28,
                ),
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search for place",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 200,
                  height: 40,
                  child: Text(
                    "You can search for place with certificate",
                    overflow: TextOverflow.visible,
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                )
              ],
            ),
            Spacer(),
            Icon(
              Icons.navigate_next,
              size: 40.0,
            )
          ],
        ),
      ),
    );
  }
}
