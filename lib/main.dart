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
      body: ParentTapBoxC(),
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
  final ValueChanged<bool>
      onChanged; //Este atributo armazena o método void _changeValue(bool newValue)
  //da classe _TapBoxBState

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
//Fim do TapBoxB

//Inicio TapBoxC. O Widget-filho gerencia parte de seu estado, enquanto o Widget pai gerencia outro
class ParentTapBoxC extends StatefulWidget {
  @override
  _ParentTapBoxCState createState() => _ParentTapBoxCState();
}

class _ParentTapBoxCState extends State<ParentTapBoxC> {
  bool active = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: TapBoxC(
            isActive: this.active,
            handleTapBoxChange: _handleTapBoxChange,
          ),
          width: 400,
          height: 400,
        ),
        Text(
          'Parent: $active',
          style: TextStyle(fontSize: 50),
        )
      ],
    );
  }

  void _handleTapBoxChange(bool newValue) {
    setState(() {
      this.active = newValue;
    });
  }
}

class TapBoxC extends StatefulWidget {
  final bool isActive;
  final ValueChanged<bool> handleTapBoxChange;

  TapBoxC(
      {this.isActive,
      @required this.handleTapBoxChange}); //Adicionando valores das variáveis

  @override
  _TapBoxCState createState() =>
      _TapBoxCState(); //Não é necessário passar as variáveis como parâmetro, pois as mesmas são acessadas pelo Widget-Filho
}

class _TapBoxCState extends State<TapBoxC> {
  bool _highlight = false;
  String locateTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Center(
          child: Text(
            widget.isActive
                ? 'Son: true,  $locateTap'
                : 'Son: false $locateTap',
            style: TextStyle(color: Colors.red, fontSize: 60),
          ),
        ),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: this._highlight
              ? Border.all(
                  color: Colors.teal,
                  width: 10,
                )
              : null,
          color: widget.isActive ? Colors.lightGreen[500] : Colors.grey[300],
        ),
      ),
      onTap: this.handleTapBox,
      onTapCancel: this.handleTapBoxCancel,
      onTapUp: this.handleTapUpBox,
      onTapDown: this.handleTapDownBox,
    );
  }

  void handleTapBox() { //Quando um GestureDetector é pressionado e solto
    setState(() {
      widget.handleTapBoxChange(!widget.isActive);
     this.locateTap = 'Tap';
     //print('Tap');
     this._highlight = !this._highlight;
    });
  }

  void handleTapBoxCancel() { //O toque é 'deslizado' para fora do GestureDetector
    setState(() {
      this.locateTap = 'TapBoxCancel';
      //print('TapCancel');
      this._highlight = false;
    });
  }

  void handleTapUpBox(TapUpDetails tapUpDetails) { //Quando o GestureDetetor é solto
    setState(() {
      this.locateTap = 'TapUp';
      this._highlight = false;
    });
  }

  void handleTapDownBox(TapDownDetails tapDownDetails) { //Quando o GestureDetector é pressionado
    setState(() {
      //widget.handleTapBoxChange(!widget.isActive);
      this.locateTap = 'TapDown';
      this._highlight = true;
    });
  }
}
//Fim TapBoxC
