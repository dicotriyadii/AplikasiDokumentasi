import 'dart:io';
import 'package:aplikasi_dokumentasi/Home/dokumentasi_view.dart';
import 'package:aplikasi_dokumentasi/Home/profile_view.dart';
import 'package:aplikasi_dokumentasi/Home/riwayat_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// page
import 'package:aplikasi_dokumentasi/login_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class HomePage extends StatefulWidget {
  var token;
  var hakAkses;
  var userId;
  int index;
  HomePage({
    Key? key,
    required this.token,
    required this.hakAkses,
    required this.userId,
    required this.index,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState(
      token: token, hakAkses: hakAkses, userId: userId, index: index);
}

class _HomePageState extends State<HomePage> {
  _HomePageState(
      {Key? key,
      required this.token,
      required this.hakAkses,
      required this.userId,
      required this.index});
  //inisialisasi variabel
  final String token;
  final int index;
  final String hakAkses;
  final String userId;
  int _currentIndex = 0;
  String _currentMenu = 'Home';
  List? data = [];

  // API
  Future<String> dataDokumentasi() async {
    final response = await http.get(
      Uri.parse(
          'https://wifitermurah.com/APIDokumentasi/api/TampilDokumentasiUserPending/' +
              userId +
              '/' +
              hakAkses),
      headers: {
        'Authorization': "Bearer " + token,
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        var resBody = json.decode(response.body);
        data = resBody;
      });
    } else {
      setState(() {
        var resBody = json.decode(response.body);
      });
    }
    return "Succses !";
  }

  Future<String> validasiAdmin($idDokumen) async {
    final response = await http.put(
      Uri.parse(
          'https://wifitermurah.com/APIDokumentasi/api/ValidasiDokumentasi/' +
              $idDokumen +
              '/kasubdit'),
      headers: {
        'Authorization': "Bearer " + token,
      },
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
        desc: 'Disposisi Berhasil',
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
        desc: 'Disposisi Gagal',
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
    }
    return "Succses !";
  }

  Future<String> validasiKasubdit($idDokumen) async {
    final response = await http.put(
      Uri.parse(
          'https://wifitermurah.com/APIDokumentasi/api/ValidasiDokumentasi/' +
              $idDokumen +
              '/direktur'),
      headers: {
        'Authorization': "Bearer " + token,
      },
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
        desc: 'Dokumen disetujui',
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
        desc: 'Disposisi Gagal',
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
    }
    return "Succses !";
  }

  Future<String> validasiSelesai($idDokumen) async {
    final response = await http.put(
      Uri.parse(
          'https://wifitermurah.com/APIDokumentasi/api/ValidasiDokumentasi/' +
              $idDokumen +
              '/selesai'),
      headers: {
        'Authorization': "Bearer " + token,
      },
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
        desc: 'Dokumen sudah di setujui',
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
        desc: 'Disposisi Gagal',
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
    }
    return "Succses !";
  }

  //metod ini akan dijalankna saat diklik
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
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Color.fromRGBO(18, 178, 215, 1),
          leading: Container(
            padding: EdgeInsets.only(top: 5, left: 15, bottom: 5),
            child: Image.asset(
              'assets/images/LogoPolda.png',
              width: 100,
              height: 100,
            ),
          ),
          actions: [
            if (hakAkses == "personil")
              Container(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                    icon: Icon(
                      Icons.add_box,
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      size: 35,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DokumentasiPage(
                                  hakAkses: hakAkses,
                                  token: token,
                                  userId: userId,
                                  index: 0,
                                )),
                      );
                    }),
              )
          ],
          title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Selamat Datang di \nDokumentasi Polda Sumut",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )),
      body: ListView.builder(
        itemCount: data == null ? 0 : data?.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                data?[index]['data'].length != 0
                    ? Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Dokumentasi Belum Di ACC",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  for (int i = 0;
                                      i < data?[index]['data'].length;
                                      i++)
                                    Card(
                                      child: ListTile(
                                        leading: Image.asset(
                                          'assets/images/iconDocument.png',
                                          width: 45,
                                          height: 45,
                                        ),
                                        contentPadding: EdgeInsets.all(15),
                                        title: Text(
                                          data?[index]['data'][i]
                                              ['namaDokumen'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Container(
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  child: Row(children: <Widget>[
                                                    Text('Nomor : '),
                                                    Text(data?[index]['data'][i]
                                                        ['noDokumen']),
                                                  ]),
                                                ),
                                                Container(
                                                  child: Row(children: <Widget>[
                                                    Text('Tanggal : '),
                                                    Text(data?[index]['data'][i]
                                                        ['tanggal']),
                                                  ]),
                                                ),
                                                Container(
                                                  child: Row(children: <Widget>[
                                                    Text('Lokasi : '),
                                                    Text(data?[index]['data'][i]
                                                        ['lokasi']),
                                                  ]),
                                                ),
                                                Container(
                                                  child: Row(children: <Widget>[
                                                    Text('Status : '),
                                                    Text(data?[index]['data'][i]
                                                        ['status']),
                                                  ]),
                                                ),
                                                if (hakAkses == "admin")
                                                  Container(
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Color.fromRGBO(
                                                            18,
                                                            178,
                                                            215,
                                                            1), // Background color
                                                      ),
                                                      child: Text(
                                                        "Disposisi Atasan",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onPressed: () {
                                                        validasiAdmin(
                                                            data?[index]['data']
                                                                [i]['id']);
                                                      },
                                                    ),
                                                  ),
                                                if (hakAkses == "kasubdit")
                                                  Container(
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Color.fromRGBO(
                                                            18,
                                                            178,
                                                            215,
                                                            1), // Background color
                                                      ),
                                                      child: Text(
                                                        "Menyetujui Dokumen",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onPressed: () {
                                                        validasiKasubdit(
                                                            data?[index]['data']
                                                                [i]['id']);
                                                      },
                                                    ),
                                                  ),
                                                if (hakAkses == "direktur")
                                                  Container(
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Color.fromRGBO(
                                                            18,
                                                            178,
                                                            215,
                                                            1), // Background color
                                                      ),
                                                      child: Text(
                                                        "Menyetujui Dokumen",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onPressed: () {
                                                        validasiSelesai(
                                                            data?[index]['data']
                                                                [i]['id']);
                                                      },
                                                    ),
                                                  )
                                              ]),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(left: 5, top: 120),
                        child: Center(
                            child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/noData.png',
                              width: 250,
                              height: 250,
                            ),
                            Text(
                              'Tidak Ada Data yang ditemukan',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )
                          ],
                        )))
              ],
            ),
          );
        },
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

  Widget box(String title, Color backgroundcolor) {
    return Container(
        margin: EdgeInsets.all(10),
        width: 80,
        color: backgroundcolor,
        alignment: Alignment.center,
        child:
            Text(title, style: TextStyle(color: Colors.white, fontSize: 20)));
  }

  void initState() {
    super.initState();
    this.dataDokumentasi();
  }
}
