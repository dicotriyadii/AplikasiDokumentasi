import 'dart:io';
import 'package:aplikasi_dokumentasi/Home/profile_view.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//page
import 'package:aplikasi_dokumentasi/home/home_view.dart';

class RiwayatPage extends StatefulWidget {
  var token;
  var hakAkses;
  var userId;
  int index;
  RiwayatPage({
    Key? key,
    required this.token,
    required this.hakAkses,
    required this.userId,
    required this.index,
  }) : super(key: key);

  @override
  State<RiwayatPage> createState() => _RiwayatPageState(
      token: token, hakAkses: hakAkses, userId: userId, index: index);
}

class _RiwayatPageState extends State<RiwayatPage> {
  _RiwayatPageState(
      {Key? key,
      required this.token,
      required this.hakAkses,
      required this.userId,
      required this.index});
  final String token;
  final int index;
  final String hakAkses;
  final String userId;
  int _currentIndex = 1;
  String _currentMenu = 'Riwayat';
  List? data = [];
  // API
  Future<String> dataDokumentasi() async {
    final response = await http.get(
      Uri.parse(
          'https://wifitermurah.com/APIDokumentasi/api/TampilDokumentasiUserSelesai/' +
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

  @override
  void initState() {
    super.initState();
    this.dataDokumentasi();
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
                  "Riwayat Dokumentasi",
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
                                  "Dokumentasi Sudah Di ACC",
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
                                          data?[index]['data'][0]
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
                                                    Text(data?[index]['data'][0]
                                                        ['noDokumen']),
                                                  ]),
                                                ),
                                                Container(
                                                  child: Row(children: <Widget>[
                                                    Text('Tanggal : '),
                                                    Text(data?[index]['data'][0]
                                                        ['tanggal']),
                                                  ]),
                                                ),
                                                Container(
                                                  child: Row(children: <Widget>[
                                                    Text('Lokasi : '),
                                                    Text(data?[index]['data'][0]
                                                        ['lokasi']),
                                                  ]),
                                                ),
                                                Container(
                                                  child: Row(children: <Widget>[
                                                    Text('Status : '),
                                                    Text(data?[index]['data'][0]
                                                        ['status']),
                                                  ]),
                                                ),
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
}
