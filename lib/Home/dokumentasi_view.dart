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

class DokumentasiPage extends StatefulWidget {
  var token;
  var hakAkses;
  var userId;
  int index;
  DokumentasiPage({
    Key? key,
    required this.token,
    required this.hakAkses,
    required this.userId,
    required this.index,
  }) : super(key: key);

  @override
  State<DokumentasiPage> createState() => _DokumentasiPageState(
      token: token, hakAkses: hakAkses, userId: userId, index: index);
}

class _DokumentasiPageState extends State<DokumentasiPage> {
  _DokumentasiPageState(
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
  String _currentMenu = 'Home';
  final ImagePicker picker = ImagePicker();
  TextEditingController noDokumen = new TextEditingController();
  TextEditingController namaDokumen = new TextEditingController();
  TextEditingController lokasi = new TextEditingController();
  XFile? image;
  List? data = [];
  DateTime _tanggalLahir = DateTime.now();
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

  void tanggalLahir() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _tanggalLahir = value;
      });
    });
  }

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
    });
  }

  Future<String> tambahDokumentasi() async {
    final response = await http.post(
      Uri.parse(
          'https://wifitermurah.com/APIDokumentasi/api/TambahDokumentasi'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + token,
      },
      body: jsonEncode(<String, String>{
        'noDokumen': noDokumen.text,
        'namaDokumen': namaDokumen.text,
        'tanggal': "${_tanggalLahir.toLocal()}",
        'lokasi': lokasi.text,
        'personil': userId,
        'kasubdit': "6",
        'direktur': "7",
        'status': "pending"
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
        desc: 'Selamat Dokumen Anda Berhasil di Tambah',
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
        title: 'Gagal',
        desc: 'Mohon maaf, data anda gagal di tambah, silahkan coba lagi',
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

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                      // sendImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                      // sendImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
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
                  "Formulir Dokumentasi",
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
              padding: EdgeInsets.all(10),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Formulir Permohonan Dokumentasi",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            image != null
                                ? Container(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.file(
                                              //to show image, you type like this.
                                              File(image!.path),
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 400,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  )
                                : Text(
                                    "No Image",
                                    style: TextStyle(fontSize: 20),
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                myAlert();
                              },
                              child: Text('Upload Photo'),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(18, 178, 215, 1)),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Color.fromRGBO(
                                                      18, 178, 215, 1)),
                                              child: Text(
                                                "Silahkan Pilih Tanggal",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                tanggalLahir();
                                              },
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              child: Text(
                                                  "${_tanggalLahir.toLocal()}"
                                                      .split(' ')[0]),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: noDokumen,
                                    keyboardType: TextInputType.text,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Masukkan Nomor Dokumen',
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0)),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: namaDokumen,
                                    keyboardType: TextInputType.text,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Masukkan Nama Dokumen',
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0)),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: lokasi,
                                    keyboardType: TextInputType.text,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Masukkan Lokasi',
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
                                tambahDokumentasi();
                              },
                              child: Text('Kirim Permohonan Dokumentasi'),
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
