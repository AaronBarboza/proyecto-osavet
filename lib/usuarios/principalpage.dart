import 'package:flutter/material.dart';
import 'package:flutter_osavet_1/usuarios/informacioncitas.dart';
import '../login.dart';
import '../usuarios/informacion.dart';
import '../usuarios/contact.dart';
import '../usuarios/galeria.dart';
import '../usuarios/recursoseventos.dart';
import '../usuarios/noticias.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Veterinaria',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const PrincipalPage(),
    );
  }
}

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF72EDF2),
            Color(0xFF5151E5),
          ],
        ),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF72EDF2),
                  Color(0xFF72EDF2),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF72EDF2),
                      Color(0xFF72EDF2),
                    ],
                  ),
                ),
                child: Text(
                  'Menú Osavet',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.info, color: Colors.black),
                title: const Text('Información',
                    style: TextStyle(color: Color.fromARGB(255, 8, 8, 8))),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InformacionPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today, color: Colors.black),
                title:
                    const Text('Citas', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InformacionCitas(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail, color: Colors.black),
                title: const Text('Contacto',
                    style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.black),
                title: const Text('Galería',
                    style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GalleryPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.event, color: Colors.black),
                title: const Text('Recursos & Eventos',
                    style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RecursosYEventosPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications, color: Colors.black),
                title: const Text('Noticias',
                    style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NoticiasPage(),
                    ),
                  );
                },
              ),
              const Divider(color: Colors.black),
              ListTile(
                leading: const Icon(Icons.login, color: Colors.black),
                title: const Text('Iniciar sesión',
                    style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const Spacer(),
            FadeTransition(
              opacity: _animation,
              child: const Text(
                'Bienvenidos',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 3,
              child: Center(
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Image.asset(
                  'assets/perro.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
