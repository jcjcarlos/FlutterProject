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
      //appBar: AppBar(title: Text('LayoutApp')),
      body: ListView(
        children: <Widget>[
          Image.asset(
            'images/lake.jpg',
            width: 600,
            height: 240,
            fit: BoxFit.cover,
            ),
          new TitleSection(), //Transformando o código aninhado em uma classe, e instânciando a mesma com "new"
          new ButtonSection(),
          Container(
            padding: EdgeInsets.all(32),
            child: Text(
              'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
              'Alps. Situated 1,578 meters above sea level, it is one of the '
              'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
              'half-hour walk through pastures and pine forest, leads you to the '
              'lake, which warms to 20 degrees Celsius in the summer. Activities '
              'enjoyed here include rowing, and riding the summer toboggan run.',
              softWrap: true,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildButtonColumn(Colors.blue, Icons.call, 'Chamadas'),
              _buildButtonColumn(Colors.blue, Icons.star, 'Favoritos'),
              _buildButtonColumn(Colors.blue, Icons.share, 'Compartilhar'),
            ],
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
