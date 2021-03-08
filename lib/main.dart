import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'TTT'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List> _board;
  _MyHomePageState() {
    _setBoard();
  }
  // reset the board. empty the list.
  _setBoard() {
    _board = List<List>(3);
    for (var i = 0; i < _board.length; i++) {
      _board[i] = List(3);
      for (var j = 0; j < _board[i].length; j++) {
        _board[i][j] = '';
      }
    }
  }

  // reset() {
  //   setState(() {
  //     _setBoard();
  //   });
  // }

  String lastchar = 'o';

  //change from o to x and vise vesa
  changeTicTak(int i, int j) {
    setState(() {
      if (_board[i][j] == '') {
        if (lastchar == 'o')
          _board[i][j] = 'x';
        else
          _board[i][j] = 'o';
        lastchar = _board[i][j];
      }
    });
  }

//check if 3 o's or x's vertical horizontal or diagonal
  _checkWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    var n = _board.length - 1;
    var player = _board[x][y];
    for (int i = 0; i < _board.length; i++) {
      if (_board[x][i] == player) col++;
      if (_board[i][y] == player) row++;
      if (_board[i][i] == player) diag++;
      if (_board[i][n - i] == player) rdiag++;
    }
    if (row == n + 1 || col == n + 1 || diag == n + 1 || rdiag == n + 1) {
      print(' $player won');
      _setBoard();
    }
  }

//create button using the location  on the board(3*3);
  Widget buttonWidget(int x, int o) {
    return new Expanded(
        child: OutlineButton(
      borderSide: BorderSide(width: 4.0, color: Colors.orangeAccent),
      padding: EdgeInsets.all(24.0),
      child: Text(
        _board[x][o],
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        changeTicTak(x, o);
        _checkWinner(x, 0);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        // padding: EdgeInsets.symmetric(
                        //   vertical: 5,
                        //   horizontal: 5,
                        // ),
                        child: Text('x'),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        // padding: EdgeInsets.symmetric(
                        //   vertical: 5,
                        //   horizontal: 5,
                        // ),
                        child: Text('o'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    buttonWidget(0, 0),
                    buttonWidget(0, 1),
                    buttonWidget(0, 2),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buttonWidget(1, 0),
                    buttonWidget(1, 1),
                    buttonWidget(1, 2),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buttonWidget(2, 0),
                    buttonWidget(2, 1),
                    buttonWidget(2, 2),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              // padding: const EdgeInsets.all(14.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 14.0),
              child: RaisedButton(
                color: Colors.deepOrange,
                child: Text('Reset'),
                onPressed: () => _setBoard(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
