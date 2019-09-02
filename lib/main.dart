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
      buildContext; //Variavel final de buildContext não pode ser alterada
  HomePage({this.buildContext}); //Construtor com parâmetro nomeado
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TapBox')),
      body: ParentTapBoxB(),
    );
  }
}

//O Widget TapBoxA gerencia seu próprio estado
class TapBoxA extends StatefulWidget {
  @override
  _TapBoxAState createState() => _TapBoxAState();
}

class _TapBoxAState extends State<TapBoxA> {
  bool _value = true;
  int _count = 1;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //Permite colocar qualquer Widget como um "botão"
      onTap: changeState,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            _value ? 'Ativado $_count' : 'Desativado $_count',
            style: TextStyle(
                fontSize: 32.0, color: _value ? Colors.yellow : Colors.white),
          ),
          decoration: BoxDecoration(color: _value ? Colors.blue : Colors.red),
        ),
      ),
    );
  }

  void changeState() {
    setState(() {});
    this._value = !_value;
    this._count += (_value ? 1 : -1);
  }
}
//Fim do Widget TapBoxAState

//O Widget ParentTapBoxB (StatefulWidget) gerencia o estado o Widget-filho
//TapBoxB(StatelessWidget).
class ParentTapBoxB extends StatefulWidget {
  @override
  _ParentTapBoxBState createState() => _ParentTapBoxBState();
}

class _ParentTapBoxBState extends State<ParentTapBoxB> {
  bool _value = true;

  void _changeValue(bool newValue) {
    setState(() {
      //Implicitamente invoca o método (Widget build(BuildContext context))
      this._value = !this._value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      child: TapBoxB(
          //As chamadas a este método (build) criará novas instâncias de TapBoxB
          active: this._value,
          onChanged:
              _changeValue), //Passando o método "onChanged" como parâmetro
      //Parametros nomeados possuem obrigatoriamente a estrutura "variavel: valor"
      decoration:
          BoxDecoration(color: this._value ? Colors.green : Colors.yellow),
    );
  }
}

class TapBoxB extends StatelessWidget {
  final bool
      active; //Variaveis finais só podem ser inicializadas com parâmetros nomeados
  final ValueChanged<bool> onChanged;

  TapBoxB(
      {Key key,
      this.active,
      @required this.onChanged}) //@required: O parâmetro torna-se obrigatório
      : super(key: key); //Parametro nomeado, para inicializar variáveis finais

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Center(
          child: Text(this.active ? 'Active' : 'Desactive'),
        ),
        decoration:
            BoxDecoration(color: this.active ? Colors.blue : Colors.red),
        width: 200,
        height: 200,
      ),
      onTap: setOnChanged,
    );
  }

  void setOnChanged() {
    this.onChanged(!this.active);
  }
}
