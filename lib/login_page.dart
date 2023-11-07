import 'dart:io';
import 'package:flutter/material.dart';
import 'package:aplikasi_dokumentasi/home/home_view.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //inisialisasi variable
  var token = "";
  var hakAkses = "";
  var userId = "";
  List? data;
  bool? statusLogin = false;
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool passwordVisible = false;
  //function
  // Lihat Password
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void setIntoSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    await prefs.setString("hakAkses", hakAkses);
    await prefs.setString("userId", userId);
  }

  //Login Warga
  Future<String> Login(String username, String password) async {
    final response = await http.post(
      // Uri.parse('http://localhost/kantor/ManagementDesa/API/LoginWarga'),
      Uri.parse('https://wifitermurah.com/APIDokumentasi/api/Login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        var resBody = json.decode(response.body);
        data = resBody;
      });
      setIntoSharedPreferences();
      hakAkses = data?[0]['hakAkses'];
      userId = data?[0]['userId'];
      token = data?[0]['token'];
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        borderSide: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
        width: 280,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Login Berhasil',
        desc: 'Selamat Datang di Aplikasi Dokumentasi Polda Sumatera Utara',
        showCloseIcon: true,
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      hakAkses: hakAkses,
                      token: token,
                      userId: userId,
                      index: 0,
                    )),
          );
        },
      ).show();
      return "Success!";
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        borderSide: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
        width: 280,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Login Gagal',
        desc: 'Username Atau Password salah, Silahkan coba lagi',
        showCloseIcon: true,
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
      ).show();
      return "Gagal";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bgLogin.jpg'),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                SizedBox(height: 350),
                TextFormField(
                  controller: username,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Masukkan Username',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  obscureText: !passwordVisible,
                  controller: password,
                  keyboardType: TextInputType.visiblePassword,
                  autofocus: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      splashRadius: 1,
                      icon: Icon(passwordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: togglePassword,
                    ),
                    hintText: 'Masukkan Password',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color.fromRGBO(18, 178, 215, 1), // Background color
                    ),
                    child: Text(
                      "Masuk",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Login(username.text, password.text);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
