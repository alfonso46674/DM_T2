import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi segunda app',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Para el manejo de los snackbars
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  //booleano para saber si esta presionado el boton like
  bool isPressedLike = false;

  // booleano para saber si esta presionado el boton de dislike
  bool isPressedDislike = false;

  // contador de likes/dislikes
  int counter = 0;


//Dialogos a usar
//Dialogo para mostrar fecha y hora
  _showDateDialog(BuildContext context) {
    //Fecha y hora
    DateTime fecha_y_hora = new DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Likes impares"),
          content: Text("$fecha_y_hora"),
          actions: [
            MaterialButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

//Dialogo para mostrar informacion
  _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Likes pares"),
          content: Text("El contador de likes es par"),
          actions: [
            MaterialButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

//SnackBars a usar
  _llamadaSnackBar() {
    final snackBar = new SnackBar(content: new Text('33 3669 3434'));
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _rutaSnackBar() {
    final snackBar = new SnackBar(content: new Text('Seguir estas direcciones...'));
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _correoSnackBar() {
    final snackBar = new SnackBar(content: new Text('contacto@iteso.mx'));
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // para los snackbars
      appBar: AppBar(
        title: Text('Info del ITESO'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/iteso.jpg"),
            //Image.network("https://pbs.twimg.com/media/DburBCaVQAAM_2g.jpg"),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              child: Row(
                children: [
                  // textos
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ITESO, Universidad Jesuita de Guadalajara",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("San Pedro Tlaquepaque"),
                      ],
                    ),
                  ),

                  //Icono para mostrar el dialogo en funcion de los likes
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      // condicional en funcion de la divisibilidad entre dos de los likes, se usan funciones diferentes en cada caso
                      if (counter % 2 == 0) {
                        // likes par
                        _showInfoDialog(context);
                      } else {
                        // likes impar
                        _showDateDialog(context);
                      }
                    },
                  ),

                  IconButton(
                    icon: Icon(
                      Icons.thumb_up,
                      color: isPressedLike ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () {
                      //TODO: hacer lo necesario para incrementar y cambiar colores
                      isPressedLike = !isPressedLike;
                      counter++;
                      setState(() {});
                    },
                  ),

                  IconButton(
                    icon: Icon(
                      Icons.thumb_down,
                      color: isPressedDislike ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      //TODO: hacer lo necesario para decrementar y cambiar colores
                      isPressedDislike = !isPressedDislike;
                      counter--;
                      setState(() {});
                    },
                  ),
                  
                  Text("$counter"),

                  SizedBox(
                    width: 8,
                  )
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //botones
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconButton(
                        icon: new Icon(Icons.mail),
                        iconSize: 64,
                        onPressed: _correoSnackBar,
                      ),
                      Text("Correo"),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconButton(
                        icon: new Icon(Icons.call),
                        iconSize: 64,
                        onPressed: _llamadaSnackBar,
                      ),
                      Text("Llamar"),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconButton(
                        icon: new Icon(Icons.directions),
                        iconSize: 64,
                        onPressed: _rutaSnackBar,
                      ),
                      Text("Ruta"),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                  "Fundada en el año de 1957 por el ingeniero José Fernández del Valle y Ancira, entre otros, la universidad ha tenido una larga trayectoria. A continuación se presenta la historia de la institución en periodos de décadas"),
            ),
          ],
        ),
      ),
    );
  }
}
