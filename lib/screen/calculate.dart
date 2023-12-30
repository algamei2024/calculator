import 'dart:ffi';

import 'package:flutter/material.dart';

class clac extends StatefulWidget {
  static const materialRoute = "calculate";
  @override
  State<clac> createState() => _clacState();
}

class _clacState extends State<clac> {
  int index = 0;
  _buildPopupMenuItem(String menuTitle, IconData iconData) {
    index++;
    return PopupMenuItem(
        child: Row(
      children: [
        Icon(
          iconData,
          color: Colors.black,
        ),
        Text(menuTitle),
      ],
    ));
  }

  bool checkOp(op) {
    bool check = false;
    if (op == "/" || op == "-" || op == "+" || op == "X") {
      check = true;
    }
    return check;
  }

  //----دالة الاحداث
  _eventButtons(op) {
    if (op == "CLEAR") {
      if (txt == '') {
        return;
      }
      //هنا لحذف السابق
      if (checkOp(calcController.text[calcController.text.length - 1]) && txt.length>1) {
        txt = txt.substring(0, txt.length - 2);
      } else {
        txt = txt.substring(0, txt.length - 1);
      }
      calcController.text =
          calcController.text.substring(0, calcController.text.length - 1);
    } else if (op == "=") {
      // هنا ايحاد الناتج
      if (txt.length < 2 ||
          checkOp(calcController.text[calcController.text.length - 1]))
        return; //الاختبار اذا كان اخر شي ادخله اوبيراتور
      if (txt[txt.length - 1] == '.') txt += "0";
      List alltxt = txt.split(','); //الفحص اذا كان هناك عدد واحد
      String result = "";
      for (int i = 0; i < 4; i++) {
        //المرور على جميع الابوراتور
        for (int j = 1; j < alltxt.length; j++) {
          // الفحص اذا انتهت الارقام
          //المرور على جميع الارقام
          if (alltxt[j][0] == (['/', 'X', '+', '-'])[i]) {
            double? num1 = double.parse(
                alltxt[j].toString().substring(1, alltxt[j].toString().length));
            //تحويل الرقم الاول
            double num2;
            String nextOp = "u";

            if (checkOp(
                alltxt[j - 1][0])) //فحص الرقم الثاني انه عاده يوجد بعده ارقام
            {
              setState(() {});
              //اذا وجد ارقام بعده يقوم بتحويلة ومن ثم يحفظ العملية التالية
              nextOp = alltxt[j - 1][0].toString();
              num2 = double.parse(alltxt[j - 1]
                  .toString()
                  .substring(1, alltxt[j - 1].toString().length));
            } else {
              // اذا لم يكن هناك اي رقم بعد الرقم الثاني
              num2 = double.parse(alltxt[j - 1]);
            }
            if (j-1 == 0) {
              nextOp = "u";
              num2 = double.parse(alltxt[j - 1]);
            }
            switch (i) {
              // لمعرفة العملية على الارقام وتطبيقها
              case 0:
                num1 = num2 / num1;
                break;
              case 1:
                num1 = num1 * num2;
                break;
              case 2:
                num1 = num1 + num2;
                break;
              case 3:
                num1 = num2 - num1;
                break;
            }
            (nextOp != 'u')
                ? result = nextOp + num1.toString()
                : result = num1.toString();
            // الفحص اذا كان يوجد رقم بعد الرقم الثاني
            alltxt[j - 1] = result;
            alltxt.removeAt(j);
            j--;
          }
        }
      }
      calcController.text = alltxt[0];
      txt = alltxt[0];
    } else if (checkOp(op)) {
      if (txt == '' && op == '-') {
        txt += '-';
        calcController.text += '-';
      }
      // هنا الفحص إذا كان رموز كما هو موضح تحت
      if (txt != '' &&
          (!checkOp(txt[txt.length - 1])) &&
          txt[txt.length - 1] != '.') {
        txt += ("," + op);
        calcController.text += op;
      }
    } else {
      //هنا الفحص اذا كان ارقام و الفاصلة
      if (txt == "" ||
          (txt.length >= 1 &&
              txt[txt.length - 1] != '.' &&
              (!checkOp(txt[txt.length - 1]))) ||
          op != ".") {
        txt += op;
        calcController.text += op;
      }
    }
  }

//عمل ازرار الحاسبة
  _buildButtons(op) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 74, 140, 190),
          borderRadius: BorderRadius.circular(5)),
      child: Wrap(
        spacing: 1,
        runSpacing: 1,
        children: List.generate(op.length, (i) {
          return Container(
            width: (i > op.length - 3) ? 161 : 80,
            height: 80,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0))),
                onPressed: () {
                  _eventButtons(op[i]);
                },
                child: Text("${op[i]}")),
          );
        }),
      ),
    );
  }

  TextEditingController calcController = new TextEditingController();
  String txt = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator - 2'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem>[
                _buildPopupMenuItem("Share", Icons.share),
                _buildPopupMenuItem("Upload", Icons.upload),
                _buildPopupMenuItem("Exit", Icons.exit_to_app_rounded),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              enabled: false,
              style: TextStyle(color: Colors.black),
              controller: calcController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 3, color: Color.fromARGB(223, 220, 151, 12)),
                ),
              ),
            ),
          ),
          //-------
          SizedBox(height: 10,),
          _buildButtons([
            "1",
            "2",
            "3",
            "/",
            "4",
            "5",
            "6",
            "X",
            "7",
            "8",
            "9",
            "-",
            ".",
            "0",
            "00",
            "+",
            "CLEAR",
            "="
          ]),
        ],
      ),
    );
  }
}
