// ignore_for_file: avoid_print, unused_element, use_build_context_synchronously

import 'package:agro1/components/square_tile.dart';
import 'package:agro1/pages/otp_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SecondPage());
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromRGBO(32, 55, 69, 0),
      ),
      home: Scaffold(
        body: ListView(
          children: const [
            LoginSignup(),
          ],
        ),
      ),
    );
  }
}

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginSignupState createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  final TextEditingController _phoneController = TextEditingController();
  bool isPhoneNumberEntered = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                // color: Colors.amber,
              ),
              child: const SizedBox(
                height: 20,
                child: SquareTile(
                  imagePath: 'lib/images/verum_LOGO.png',
                ),
              ),
            ),
            const SizedBox(height: 0),
            const Text(
              'Bine ați venit !',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Karla',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              width: 286,
              child: Text(
                'Începeți prin introducerea numărului dvs. de telefon mobil. Vei primi un cod de verificare',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFC7DAE5),
                  fontSize: 16,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 358,
              height: 82,
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: const Color(0xFF477A9A),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF3CBEAA)),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: SizedBox(
                height: 48,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 19,
                            child: SizedBox(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: Text(
                                      '+373',
                                      style: TextStyle(
                                        color: Color(0xFFABC7D8),
                                        fontSize: 16,
                                        fontFamily: 'Karla',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '|',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Karla',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Câmpul de introducere pentru numărul de telefon
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                                LengthLimitingTextInputFormatter(8),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  isPhoneNumberEntered = value.isNotEmpty;
                                });
                              },
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Karla',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                              decoration: const InputDecoration(
                                hintText: ' ',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 130),
            Visibility(
              visible: isPhoneNumberEntered,
              child: Container(
                width: 358,
                height: 82,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: ShapeDecoration(
                  color: const Color(0xFF3CBEAA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x51000000),
                      blurRadius: 16,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Color(0x663CBEAA),
                      blurRadius: 13,
                      offset: Offset(0, 6),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: InkWell(
                  onTap: () async {
                    String phoneNumber = '+373${_phoneController.text}';
                    print('Numarul de telefon introdus: $phoneNumber');
                    await _verifyPhoneNumber(phoneNumber);
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Începe',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Karla',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _verifyPhoneNumber(String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
    } catch (e) {
      print('Error initializing Firebase: $e');
    }
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatizat când codul este verificat instantaneu
        await auth.signInWithCredential(credential);
        print(
            'Numărul de telefon a fost verificat și utilizatorul a fost autentificat.');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SecondPage(),
          ),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Eroare de verificare a numărului de telefon: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        print('Codul de verificare a fost trimis cu succes.');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const otpForm(),
          ),
        );

        // Aici puteți continua cu afișarea unei noi pagini sau a unui dialog pentru introducerea codului.
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Timeout pentru auto-recuperare a codului de verificare.');
      },
    );
  }
}
