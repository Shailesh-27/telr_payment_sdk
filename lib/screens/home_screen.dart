// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sdk/components/network_helper.dart';
// import 'package:sdk/screens/webview_screen.dart';
// import 'package:xml/xml.dart';
// import 'package:flutter_dialogs/flutter_dialogs.dart';
// import 'dart:math';
//
// class HomeScreen extends StatefulWidget {
//   static const String id = 'home_screen';
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final _amount = TextEditingController();
//   final _language = TextEditingController();
//   final _currency = TextEditingController();
//   var _url = '';
//   var random = new Random();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//
//
//   }
//
//
//   void alertShow(String text) {
//     showPlatformDialog(
//       context: context,
//       builder: (_) => BasicDialogAlert(
//         title: Text('$text', style: TextStyle(fontSize: 15),),
//         // content: Text('$text Please try again.'),
//         actions: <Widget>[
//           BasicDialogAction(
//               title: Text('Ok'),
//               onPressed: () {
//                 setState(() {
//                   // _showLoader = false;
//                 });
//                 Navigator.pop(context);
//               }),
//         ],
//       ),
//     );
//   }
//
//   void pay(XmlDocument xml)async{
//
//     NetworkHelper _networkHelper = NetworkHelper();
//     var response =  await _networkHelper.pay(xml);
//     print(response);
//    if(response == 'failed' || response == null){
//      // failed
//      alertShow('Failed');
//    }
//    else
//      {
//        final doc = XmlDocument.parse(response);
//         final url = doc.findAllElements('start').map((node) => node.text);
//         final code = doc.findAllElements('code').map((node) => node.text);
//         print(url);
//         _url = url.toString();
//         String _code = code.toString();
//         if(_url.length>2){
//             _url =  _url.replaceAll('(', '');
//              _url = _url.replaceAll(')', '');
//              _code = _code.replaceAll('(', '');
//             _code = _code.replaceAll(')', '');
//               _launchURL(_url,_code);
//         }
//         print(_url);
//         final message = doc.findAllElements('message').map((node) => node.text);
//         print('Message =  $message');
//         if(message.toString().length>2){
//           String msg = message.toString();
//           msg = msg.replaceAll('(', '');
//           msg = msg.replaceAll(')', '');
//           alertShow(msg);
//         }
//      }
//   }
//
//   void _launchURL(String url, String code) async {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (BuildContext context) => WebViewScreen(
//               url : url,
//               code: code,
//             )));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//           body: SafeArea(
//             child: GestureDetector(
//                 onTap: () {
//                   FocusScope.of(context).requestFocus(new FocusNode());
//                 },
//               child: SingleChildScrollView(
//                 child: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('Fill Amount:'),
//               RaisedButton(onPressed: (){
//                 Navigator.pop(context);
//               },
//               child: Text('Close'),)
//             ],
//           ),
//                     SizedBox(height: 10,),
//                     TextField(
//                       controller: _amount,
//                       textAlign: TextAlign.center,
//                       onChanged: (String val) {
//                         setState(() {
//                           if (val == '') {
//                             // _amountError = true;
//                           } else {
//                             // _amountError = false;
//                           }
//                         });
//                       },
//                       style: TextStyle(fontSize: 13,color: Colors.red),
//                       //  keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                           hintText: "Enter Amount",
//                           errorStyle: TextStyle(fontSize: 10),
//                           // errorText: _amountError
//                           //     ? 'Please enter amount'
//                           //     : null
//                             ),
//                     ),
//           SizedBox(height: 10,),
//           TextField(
//                 controller: _language,
//                 textAlign: TextAlign.center,
//                 onChanged: (String val) {
//                   setState(() {
//                     if (val == '') {
//                       // _amountError = true;
//                     } else {
//                       // _amountError = false;
//                     }
//                   });
//                 },
//                 style: TextStyle(fontSize: 13),
//                 //  keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   hintText: "Enter currency language",
//                   errorStyle: TextStyle(fontSize: 10),
//                   // errorText: _amountError
//                   //     ? 'Please enter amount'
//                   //     : null
//                 ),
//           ),
//           SizedBox(height: 10,),
//           TextField(
//                 controller: _currency,
//                 textAlign: TextAlign.center,
//                 onChanged: (String val) {
//                   setState(() {
//                     if (val == '') {
//                       // _amountError = true;
//                     } else {
//                       // _amountError = false;
//                     }
//                   });
//                 },
//                 style: TextStyle(fontSize: 13),
//                 //  keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   hintText: "Enter currency",
//                   errorStyle: TextStyle(fontSize: 10),
//                   // errorText: _amountError
//                   //     ? 'Please enter amount'
//                   //     : null
//                 ),
//           ),
//           SizedBox(height: 10,),
//           CupertinoButton(
//                   child: Container(
//                     height: 50,
//                     // color: Color(0xff006E4F),
//                     color: Colors.grey,
//                     child: Center(
//                         child: Text(
//                           'PAY',
//                           style: TextStyle(color: Colors.black, fontSize: 12),
//                         )),
//                   ),
//                   onPressed: () {
//                     final builder = XmlBuilder();
//                     builder.processing('xml', 'version="1.0"');
//                     builder.element('mobile', nest: () {
//                         builder.element('store', nest: (){
//                           builder.text('15996');
//                         });
//                         builder.element('key', nest: (){
//                           builder.text('pQ6nP-7rHt@5WRFv');
//                         });
//
//                         builder.element('device', nest: (){
//                           builder.element('type', nest: (){
//                             builder.text('iOS');
//                           });
//                           builder.element('id', nest: (){
//                             builder.text('37fb44a2ec8202a3');
//                           });
//                         });
//
//                         // app
//                         builder.element('app', nest: (){
//                           builder.element('name', nest: (){
//                             builder.text('Telr');
//                           });
//                           builder.element('version', nest: (){
//                             builder.text('1.1.6');
//                           });
//                           builder.element('user', nest: (){
//                             builder.text('2');
//                           });
//                           builder.element('id', nest: (){
//                             builder.text('123');
//                           });
//                         });
//
//                         //tran
//                         builder.element('tran', nest: (){
//                           builder.element('test', nest: (){
//                             builder.text('1');
//                           });
//                           builder.element('type', nest: (){
//                             builder.text('auth');
//                           });
//                           builder.element('class', nest: (){
//                             builder.text('paypage');
//                           });
//                           builder.element('cartid', nest: (){
//                             builder.text(100000000 + random.nextInt(999999999));
//                           });
//                           builder.element('description', nest: (){
//                             builder.text('Test for Mobile API order');
//                           });
//                           builder.element('currency', nest: (){
//                             builder.text(_currency.text);
//                           });
//                           builder.element('amount', nest: (){
//                             builder.text(_amount.text);
//                           });
//                           builder.element('language', nest: (){
//                             builder.text(_language.text);
//                           });
//                           builder.element('firstref', nest: (){
//                             builder.text('first');
//                           });
//                           builder.element('ref', nest: (){
//                             builder.text('null');
//                           });
//
//                         });
//
//                         //billing
//                         builder.element('billing', nest: (){
//                           // name
//                           builder.element('name', nest: (){
//                             builder.element('title', nest: (){
//                               builder.text('');
//                             });
//                             builder.element('first', nest: (){
//                               builder.text('Div');
//                             });
//                             builder.element('last', nest: (){
//                               builder.text('V');
//                             });
//                           });
//                           // address
//                           builder.element('address', nest: (){
//                             builder.element('line1', nest: (){
//                               builder.text('Dubai');
//                             });
//                             builder.element('city', nest: (){
//                               builder.text('Dubai');
//                             });
//                             builder.element('region', nest: (){
//                               builder.text('');
//                             });
//                             builder.element('country', nest: (){
//                               builder.text('AE');
//                             });
//                           });
//
//                           builder.element('phone', nest: (){
//                             builder.text('551188269');
//                           });
//                           builder.element('email', nest: (){
//                             builder.text('divya.thampi@telr.com');
//                           });
//                         });
//                     });
//
//                     final bookshelfXml = builder.buildDocument();
//
//                     // print(bookshelfXml);
//                     pay(bookshelfXml);
//
//
//                   })
//         ],
//       ),
//                   ),
//                 ),
//               ),
//             ),
//           )),
//     );
//   }
// }
