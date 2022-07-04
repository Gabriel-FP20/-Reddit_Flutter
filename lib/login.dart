import 'package:flutter/material.dart';
import 'package:estudos_app/start.dart';
import 'QRCode.dart';
import 'VoiceSpeech.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isButtonActive = true;
  late TextEditingController subredditController;
  String subreddit = '';

  @override
  void initState() {
    super.initState();
    subredditController = TextEditingController(text: "FlutterDev");
    subredditController.addListener(() {
      final isButtonActive = subredditController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    subredditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reddit Search'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 400.0,
                height: 200.0,
              ),
              TextField(
                controller: subredditController,
                autofocus: true,
                style: new TextStyle(color: Colors.black, fontSize: 20),
                decoration: InputDecoration(
                  hintText: "SubReddit",
                  labelText: "SubReddit",
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.red,
                    child: IconButton(
                        color: Colors.black,
                        padding: const EdgeInsets.all(4),
                        iconSize: 30,
                        icon: const Icon(Icons.mic),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VoiceSpeech(),
                          ));
                        }),
                  ),
                  SizedBox(width: 20.0),
                  SizedBox(
                    width: 100.0,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: isButtonActive
                          ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Start(
                                            subreddit: subredditController.text,
                                          )));
                            }
                          : null,
                      child: const Text('Search'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.red,
                    child: IconButton(
                        color: Colors.black,
                        padding: const EdgeInsets.all(4),
                        iconSize: 30,
                        icon: const Icon(Icons.qr_code),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => QRCode(),
                          ));
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
