import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text('LayoutApp')),
      body: Column(
        children: <Widget>[
          new TitleSection(), //Transformando o código aninhado em uma classe, e instânciando a mesma com "new"
          Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _buildButtonColumn(Colors.blue, Icons.call, 'Chamadas'),
                    _buildButtonColumn(Colors.blue, Icons.star, 'Favoritos'),
                    _buildButtonColumn(Colors.blue, Icons.share, 'Compartilhar')
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData iconData, String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconData,
          color: color,
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        )
      ],
    );
  }
}

class TitleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
          32), //Espaçamento de 32(px?) da Widget-Pai (Seção Titulo)
      child: Row(
        //Row with 3 children
        children: <Widget>[
          Expanded(
            //Expanded to fill remaining space
            child: Column(
              //Column of two children
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  //Text{1}
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Geschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  //Text{2}
                  child: Text(
                    'Kandersteg Switzerland',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                )
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('41')
        ],
      ),
    );
  }
}
