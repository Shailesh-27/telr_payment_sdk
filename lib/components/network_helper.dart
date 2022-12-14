import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class NetworkHelper {
  NetworkHelper();

  final xmlFile =
      '''<?xml version="1.0" encoding="UTF-8"?>
  <mobile>
  <store>15996</store>
  <key>pQ6nP-7rHt@5WRFv</key>
  <device>
  <type>Android</type>
  <id>37fb44a2ec8202a3</id>
  </device>
  <app>
  <name>Telr</name>
  <version>1.1.6</version>
  <user>2</user>
  <id>123</id>
  </app>
  <tran>
  <test>1</test>
  <type>auth</type>
  <class>paypage</class>
  <cartid>3030432970552669998</cartid>
  <description>Test for Mobile API order</description>
  <currency>aed</currency>
  <amount>1</amount>
  <language>en</language>
  <firstref>null</firstref>
  <ref></ref>
  </tran>
  <billing>
  <name>
  <title />
  <first>Div</first>
  <last>V</last >
  </name>
  <address>
  <line1>Dubai</line1>
  <city>Dubai</city>
  <region />
  <country>AE</country>
  </address>
  <phone>551188269</phone>
  <email>divya.thampi@telr.com</email>
  </billing>
  </mobile>''';

  Future pay(XmlDocument xml) async {
    String url = 'https://secure.telr.com/gateway/mobile.xml';
    var data = {xml};

    var body = xml.toString();
    // print('body = $body');

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/xml",
      },
    );
    print("Status Code = ${response.statusCode}");
    print("Response body : ${response.body}");
    // print("Response body = ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 400) {
      return response.body;
    } else {
      return 'failed';
    }
  }

  Future completed(XmlDocument xml) async {
    print("called");
    String url = 'https://secure.telr.com/gateway/mobile_complete.xml';
    var data = {xml};

    var body = xml.toString();
    // print('body = $body');

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/xml",
      },
    );
    print("Status Code  = ${response.statusCode}");
    print("Response body==1111 : ${response.body}");
    // print("Response body = ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 400) {
      return response.body;
    } else {
      return 'failed';
    }
  }
}
