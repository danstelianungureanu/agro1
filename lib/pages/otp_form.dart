// ignore_for_file: camel_case_types

import 'package:agro1/pages/localization.dart';
import 'package:flutter/material.dart';
import 'package:otp_input_editor/otp_input_editor.dart';

class otpForm extends StatefulWidget {
  const otpForm({super.key});

  @override
  State<otpForm> createState() => _otpFormState();
}

class _otpFormState extends State<otpForm> {
  String _otpData = "";

  OtpInputController? _otpInputController;
  bool _showOtp = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ..._getOtpText,
              _getOtpEditor,
              _spacer,
              _clearOtpButton,
              _hideOrShowButton,
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  checkOtpAndNavigate();
                },
                child: const Text(
                  "Valideaza OTP",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox get _spacer {
    return const SizedBox(
      height: 20,
    );
  }

  Row get _hideOrShowButton {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              setState(() {
                _showOtp = !_showOtp;
              });
            },
            child: Row(
              children: _showOtp
                  ? [
                      const Icon(Icons.visibility_off),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text("Hide"),
                      )
                    ]
                  : [
                      const Icon(Icons.visibility),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text("Show"),
                      )
                    ],
            )),
      ],
    );
  }

  Row get _clearOtpButton {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            if (_otpInputController != null) {
              _otpInputController!.clear();
              _otpData = _otpInputController?.otp ?? "";
              setState(() {});
            }
          },
          child: const Text(
            "Clear OTP",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 17,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  OtpInputEditor get _getOtpEditor {
    return OtpInputEditor(
      obscureText: !_showOtp,
      otpLength: 6,
      onOtpChanged: (value) {
        // ignore: avoid_print
        print(value);
        setState(() {
          _otpData = value;
        });
      },
      onInitialization: (OtpInputController otpInputController) {
        setState(() {
          _otpInputController = otpInputController;
        });
      },
      invalid: false,
      otpTextFieldBackgroundColor: Colors.white,
      cursorHeight: 25,
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 2.0,
          spreadRadius: 1.0,
        ),
      ],
      fieldWidth: 40.0,
      fieldHeight: 60.0,
      cursorWidth: 1.5,
      textInputStyle: const TextStyle(
        fontSize: 20.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      boxDecoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF3CBEAA),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(14.0),
      ),
    );
  }

  AppBar get _appBar {
    return AppBar(
      title: const Text(
        "Inapoi",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  List<Widget> get _getOtpText {
    return [
      const Text(
        "Cod Introdus:",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        _otpData,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 30,
      ),
    ];
  }

  void checkOtpAndNavigate() {
    // Verificare valoare OTP
    if (_otpData == "123456") {
      // ignore: avoid_print
      print("Valoare corectă!");
      // Înlocuiți "valoarea corecta" cu valoarea corectă așteptată
      // Navigare către o altă pagină dacă valoarea este corectă
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const localization()),
      );
    } else {
      // Dacă valoarea nu este corectă, puteți afișa un mesaj sau luați o altă acțiune.
      // ignore: avoid_print
      print("Valoare incorectă!");
    }
  }
}
