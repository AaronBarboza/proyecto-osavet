import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with TickerProviderStateMixin {
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
        appBar: AppBar(
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: FadeTransition(
                    opacity: _animation,
                    child: const Text(
                      'Contáctanos',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Información de contacto',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Expanded(
                            // Widget Expanded para centrar el correo electrónico
                            child: Row(
                              children: [
                                Icon(Icons.email),
                                SizedBox(width: 8.0),
                                Text(
                                  'veticopet2@gmail.com',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Expanded(
                            // Widget Expanded para centrar el número de teléfono
                            child: Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(width: 8.0),
                                Text(
                                  '2735959',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: Image.asset(
                    'assets/vetecora.png',
                    height: 200.0,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Síguenos en redes sociales',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              _launchFacebook();
                            },
                            icon: const Icon(Icons.facebook, size: 30),
                          ),
                          IconButton(
                            onPressed: () {
                              _launchWhatsApp();
                            },
                            icon: const FaIcon(FontAwesomeIcons.whatsapp,
                                size: 30),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _launchWhatsApp() async {
  String message = Uri.encodeFull(
      "Hola, necesito información sobre los servicios veterinarios.");
  String url = "whatsapp://send?phone=+50685115959&text=$message";

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    // Si WhatsApp no está instalado, abrir la versión web
    String webUrl =
        "https://web.whatsapp.com/send?phone=+50685115959&text=$message";
    await launch(webUrl);
  }
}

void _launchFacebook() async {
  const facebookUrl = 'https://www.facebook.com/ticopet2?mibextid=LQQJ4d';
  if (await canLaunch(facebookUrl)) {
    await launch(facebookUrl);
  } else {
    throw 'No se pudo abrir Facebook.';
  }
}
