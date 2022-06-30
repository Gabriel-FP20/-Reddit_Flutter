import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final intervalo_provider = StateProvider((_) => 0);
final qtd_materias_dia = StateProvider((_) => 0);
final data_final = StateProvider((_) => 0);

List<Widget> _cardList = [];

class Options extends ConsumerStatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}


void _addCardWidget() {
  setState(() {
    _cardList.add(_card());
  });
}

void setState(Null Function() param0) {
}


Widget _card() {
  return Container(
    height: 80,
    margin: EdgeInsets.only(top: 5,left: 8,right: 8),
    decoration: new BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color:Colors.orangeAccent[100],
    ),
    child: TextField(
      autofocus: true,
      style: new TextStyle(color: Colors.black, fontSize: 20),
      decoration: InputDecoration(
        hintText: "Digite seu Login",
        labelText: "Login",
      ),
    ),
  );
  }



  class _OptionsState extends ConsumerState<Options> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 100),
                child: TextField(
                  autofocus: true,
                  style: new TextStyle(color: Colors.black, fontSize: 20),
                  onChanged: (text) {
                    ref.read(intervalo_provider.notifier).state = int.parse(text);
                  },
                  decoration: InputDecoration(
                    hintText: " ",
                    labelText: "Intervalo para Revisão",
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              Divider(),
              SizedBox(
                  width: 200.0,
                  height: 50.0,
                  child: ListView.builder(
                      itemCount: _cardList.length,
                      itemBuilder: (context,index){
                        return _cardList[index];
                      })
              ),
              Divider(),
              SizedBox(
                width: 200.0,
                height: 50.0,
                child: FloatingActionButton.extended(
                  onPressed: _addCardWidget,
                  tooltip: 'Add',
                  label: const Text('Adicionar Matéria'),
                  icon: const Icon(Icons.add),
                  ),
                ),
                ],
                  ),
                ),
              ),
          );
  }
}
