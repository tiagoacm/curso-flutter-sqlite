import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'screens/dashboard.dart';

void main() => runApp(BytebankApp());

/*void main(){
  runApp(BytebankApp());
  salvar(Contato(0,'Tiago', 21)).then((id){
    buscarTodos().then((listaContatos)=>debugPrint(listaContatos.toString()));
  });
}*/

class BytebankApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700] ,
          textTheme: ButtonTextTheme.primary,
        )
      ),

      home: MyHomePage(),
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
  @override
  Widget build(BuildContext context) {
    return _introScreen();
  }
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 3,
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xff595959),
            Color(0xff50b100)
          ],
        ),
        navigateAfterSeconds: Dashboard(),
        loaderColor: Colors.transparent,
      ),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("imagem/logo.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ],
  );
}

