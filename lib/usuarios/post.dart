import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

final linearGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF72EDF2),
    Color(0xFF5151E5),
  ],
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Publicaciones de Facebook',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> publicaciones = [];

  @override
  void initState() {
    super.initState();
    obtenerPublicaciones();
  }

  Future<void> obtenerPublicaciones() async {
    const url = 'https://www.facebook.com/ticopet2';
    final response = await http.get(Uri.parse(url));
    final document = parser.parse(response.body);

    final publicacionesElementos = document.querySelectorAll('div._5pbx.userContent');

    publicaciones = publicacionesElementos.map((elemento) {
      final textoPublicacion = elemento.querySelector('p')?.text ?? '';
      return textoPublicacion;
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: linearGradient,
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: publicaciones.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(16.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(publicaciones[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}