import 'package:flutter/material.dart';

MyApp myApp =
    new MyApp(); //Guardando referencia da classe para acessa-la posteriormente

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LayoutApp',
      home: HomePage(
          buildContext:
              context), //Estou passando o context do build como parametro para o HomePage
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  final BuildContext
      buildContext; //Variavel final de cntexto, não pode ser alterada
  HomePage({this.buildContext}); //Definição de construtor por parâmetro nomeado
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TapBox')),
      body: TapBox(),
    );
  }
}

class TapBox extends StatefulWidget {
  @override
  _TapBoxState createState() => _TapBoxState();
}

class _TapBoxState extends State<TapBox> {
  bool _value = true;
  int _count = 1;
  @override
  Widget build(BuildContext context) {
    return GestureDetector( //Permite colocar qualquer Widget como um "botão"
      onTap: changeState,
      child: Center(child:Text(_value ? 'Ativado $_count' : 'Desativado $_count')),
    );
  }

  void changeState() {
    setState(() {});
    this._value = !_value;
    this._count += (_value ? 1 : -1);
  }
}
