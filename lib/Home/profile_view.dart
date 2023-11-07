import 'dart:io';
import 'package:aplikasi_dokumentasi/Home/riwayat_view.dart';
import 'package:aplikasi_dokumentasi/login_page.dart';
import 'package:aplikasi_dokumentasi/Home/listPegawai.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//page
import 'package:aplikasi_dokumentasi/home/home_view.dart';

class ProfilePage extends StatefulWidget {
  var token;
  var hakAkses;
  var userId;
  int index;
  ProfilePage({
    Key? key,
    required this.token,
    required this.hakAkses,
    required this.userId,
    required this.index,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState(
      token: token, hakAkses: hakAkses, userId: userId, index: index);
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState(
      {Key? key,
      required this.token,
      required this.hakAkses,
      required this.userId,
      required this.index});
  final String token;
  final int index;
  final String hakAkses;
  final String userId;
  String nama = "";
  String jabatan = "";
  int _currentIndex = 2;
  String _currentMenu = 'Profile';
  List? data = [];
  // API
  Future<String> dataProfil() async {
    final response = await http.get(
      Uri.parse(
          'https://wifitermurah.com/APIDokumentasi/api/TampilUserDetail/' +
              userId),
      headers: {
        'Authorization': "Bearer " + token,
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        var resBody = json.decode(response.body);
        data = resBody;
        nama = data?[0]['data'][0]['nama'];
        jabatan = data?[0]['data'][0]['jabatan'];
      });
    } else {
      setState(() {
        var resBody = json.decode(response.body);
      });
    }
    return "Succses !";
  }

  @override
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

  final gambar = Container(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image.asset(
        "assets/images/LogoPolda.png",
        width: 200,
        height: 200,
      ),
    ],
  ));
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
                  "Profile",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          children: <Widget>[
            gambar,
            Card(
              child: ListTile(
                contentPadding: EdgeInsets.all(15),
                title: Text(
                  "Data Pengguna",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('nama : ' + nama),
                                Text('jabatan : ' + jabatan),
                                Text('Hak Akses : ' + hakAkses),
                              ]),
                        ),
                      ]),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (hakAkses == 'admin')
              Container(
                width: 790,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListPegawai(
                                hakAkses: hakAkses,
                                token: token,
                                userId: userId,
                                index: 2,
                              )),
                    );
                  },
                  child: Text(
                    'Tambah Pegawai',
                    style: TextStyle(
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            Container(
              width: 790,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffF18265),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text(
                  'Keluar',
                  style: TextStyle(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ],
        ),
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

  void initState() {
    super.initState();
    this.dataProfil();
  }
}
