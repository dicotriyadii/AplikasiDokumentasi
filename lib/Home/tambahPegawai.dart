import 'dart:io';
import 'package:aplikasi_dokumentasi/Home/profile_view.dart';
import 'package:aplikasi_dokumentasi/Home/riwayat_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';

//page
import 'package:aplikasi_dokumentasi/home/home_view.dart';

class TambahPegawai extends StatefulWidget {
  var token;
  var hakAkses;
  var userId;
  int index;
  TambahPegawai({
    Key? key,
    required this.token,
    required this.hakAkses,
    required this.userId,
    required this.index,
  }) : super(key: key);

  @override
  State<TambahPegawai> createState() => _TambahPegawaiState(
      token: token, hakAkses: hakAkses, userId: userId, index: index);
}

class _TambahPegawaiState extends State<TambahPegawai> {
  _TambahPegawaiState(
      {Key? key,
      required this.token,
      required this.hakAkses,
      required this.userId,
      required this.index});
  final String token;
  final int index;
  final String hakAkses;
  final String userId;
  int _currentIndex = 0;
  String _currentMenu = 'Home';
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController nama = new TextEditingController();
  TextEditingController jabatan = new TextEditingController();
  TextEditingController hakAkses_ = new TextEditingController();

  // API
  Future<String> tambahPegawai() async {
    final response = await http.post(
      Uri.parse('https://wifitermurah.com/APIDokumentasi/api/TambahUser'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + token,
      },
      body: jsonEncode(<String, String>{
        'username': username.text,
        'password': password.text,
        'nama': nama.text,
        'jabatan': jabatan.text,
        'hakAkses': hakAkses_.text,
      }),
    );

    if (response.statusCode == 200) {
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
        title: 'Berhasil',
        desc: 'Selamat Personil Anda Berhasil di Tambah',
        showCloseIcon: true,
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TambahPegawai(
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
        title: 'Gagal',
        desc:
            'Mohon maaf, data Personil anda gagal di tambah, silahkan coba lagi',
        showCloseIcon: true,
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
      return "Gagal";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void _changeSelectedNavBar(int index) {
    setState(() {
      _currentIndex = index;

      if (index == 0) {
        _currentMenu = 'Home';
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
      } else if (index == 1) {
        _currentMenu = 'History';
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RiwayatPage(
                    hakAkses: hakAkses,
                    token: token,
                    userId: userId,
                    index: 1,
                  )),
        );
      } else if (index == 2) {
        _currentMenu = 'Profile';
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilePage(
                    hakAkses: hakAkses,
                    token: token,
                    userId: userId,
                    index: 2,
                  )),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //pemanggilan material
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(18, 178, 215, 1),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Route route = MaterialPageRoute(
                  builder: (context) => HomePage(
                        hakAkses: hakAkses,
                        token: token,
                        userId: userId,
                        index: 0,
                      ));
              Navigator.push(context, route);
            },
          ),
          title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Tambah Pegawai",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[],
            ),
          ),
          Container(
              child: Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Silahkan Isi Data Di Bawah Ini",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 10),
                              TextFormField(
                                controller: username,
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Masukkan Username',
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0)),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: password,
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Masukkan Password',
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0)),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: nama,
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Masukkan Nama Personil',
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0)),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: jabatan,
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Masukkan Jabatan Personil',
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0)),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: hakAkses_,
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Masukkan Hak Akses',
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            tambahPegawai();
                          },
                          child: Text('Tambah Data Pegawai'),
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(18, 178, 215, 1)),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              // SizedBox(
              //   height: 30,
              // ),
            ),
          ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(18, 178, 215, 1),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Color.fromRGBO(0, 0, 0, 1),
        onTap: _changeSelectedNavBar,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
