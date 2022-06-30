import 'package:flutter/material.dart';
//import 'package:estudos_app/add.dart';
//import 'package:estudos_app/call.dart';
import 'package:estudos_app/config.dart';
import 'package:estudos_app/calendar.dart';
//import 'package:estudos_app/search.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';



class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  String path = '';
  bool _imageWasPicked = false;
  File? _fotoMinisterioAtualizada;

  void _openFileExplorer() async {
    FilePickerResult? path =
      await FilePicker.platform.pickFiles(type: FileType.image);
    _newPhoto(File(path!.files.first.path!));
  }

  void _newPhoto(File perfil) {
    setState(() {
      this._fotoMinisterioAtualizada = perfil;
      _imageWasPicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Início'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 400.0,height: 30.0,),
              (!_imageWasPicked
                  ? Image.asset(
                'Images/SemFoto.png',
                height: 200,
                width: 500,
              )
                  : Image.file(_fotoMinisterioAtualizada!, height: 200, width: 500)),
              SizedBox(width: 400.0,height: 30.0,),
              SizedBox(
                width: 400.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Calendar()));
                    },
                  child: const Text('Calendário'),
                ),
              ),
              SizedBox(width: 400.0,height: 15.0,),
              SizedBox(
                width: 400.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Options()));
                    },
                  child: const Text('Chamada'),
                ),
              ),
              SizedBox(width: 400.0,height: 15.0,),
              SizedBox(
                width: 400.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Options()));
                    },
                  child: const Text('Localizar'),
                ),
              ),
              SizedBox(width: 400.0,height: 15.0,),
              SizedBox(
                width: 400.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Options()));
                    },
                  child: const Text('Dados'),
                ),
              ),
              SizedBox(width: 400.0,height: 15.0,),
              SizedBox(
                width: 400.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Options()));
                  },
                  child: const Text('Configurações'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
