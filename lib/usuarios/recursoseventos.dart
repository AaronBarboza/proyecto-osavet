import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class RecursosYEventosPage extends StatefulWidget {
  const RecursosYEventosPage({super.key});

  @override
  _RecursosYEventosPageState createState() => _RecursosYEventosPageState();
}

class RecursoItem {
  final String titulo;
  final String descripcion;
  final String imageUrl;
  final String enlace;

  RecursoItem({
    required this.titulo,
    required this.descripcion,
    required this.imageUrl,
    required this.enlace,
  });
}

class _RecursosYEventosPageState extends State<RecursosYEventosPage> {
  final List<RecursoItem> recursos = [
    RecursoItem(
      titulo: 'Rutina de ejercicios: aprende a ejercitarte junto a tu mascota',
      descripcion:
          'Aprende cómo mantenerte en forma mientras disfrutas de la compañía de tu mascota.',
      imageUrl: 'assets/recurso1.png',
      enlace:
          'https://elcomercio.pe/casa-y-mas/rutina-de-ejercicios-aprende-como-ejercitarte-junto-a-tu-mascota-perro-gato-rmmn-emcc-noticia/',
    ),
    RecursoItem(
      titulo: 'Cómo educar a un cachorro: los mejores consejos',
      descripcion:
          'Aprende las técnicas más efectivas para entrenar a tu cachorro de manera positiva y amorosa.',
      imageUrl: 'assets/recurso2.png',
      enlace:
          'https://www.purina.es/articulos/comportamiento-y-entrenamiento/como-educar-a-un-cachorro',
    ),
    RecursoItem(
      titulo: 'Consejos para el cuidado de tu mascota',
      descripcion:
          'Descubre todo lo que necesitas saber para mantener a tu mascota feliz y saludable.',
      imageUrl: 'assets/recurso3.png',
      enlace:
          'https://aratiendas.com/blog/hogar/10-consejos-para-el-cuidado-y-bienestar-de-tu-mascota/',
    ),
    RecursoItem(
      titulo: 'Cómo viajar con tu mascota en avión',
      descripcion:
          'Consejos útiles para que tu mascota viaje segura y cómoda en un vuelo.',
      imageUrl: 'assets/recurso4.png', // Cambiando a asset
      enlace:
          'https://cms.volaris.com/es/informacion-util/servicios-opcionales/viaja-con-tu-mascota/',
    ),
    RecursoItem(
      titulo: 'Alimentación saludable para perros y gatos',
      descripcion:
          'Aprende a elegir los alimentos adecuados para mantener una dieta balanceada y nutritiva para tu mascota.',
      imageUrl: 'assets/recurso5.png', // Cambiando a asset
      enlace:
          'https://unamglobal.unam.mx/global_revista/guia-para-la-alimentacion-de-perros-y-gatos/',
    ),
  ];

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
                const Center(
                  child: Text(
                    'Recursos',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8.0),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 300.0,
                            autoPlay: true,
                            enlargeCenterPage: true,
                          ),
                          items: recursos.map((recurso) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () {
                                    launchUrl(Uri.parse(recurso.enlace));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            recurso.imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            recurso.titulo,
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Text(recurso.descripcion),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/veterinarios.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Center(
                  child: Text(
                    'Eventos',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10.0),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('eventos')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('Cargando...');
                            }

                            return CarouselSlider(
                              options: CarouselOptions(
                                height: 200.0,
                                autoPlay: true,
                                enlargeCenterPage: true,
                              ),
                              items: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data() as Map<String, dynamic>;
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              data['titulo'],
                                              style: const TextStyle(
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 4.0),
                                            Text(
                                              data['descripcion'],
                                              style: const TextStyle(
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 4.0),
                                            Text(
                                              data['fecha'],
                                              style: const TextStyle(
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 4.0),
                                            Text(
                                              data['hora'],
                                              style: const TextStyle(
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
