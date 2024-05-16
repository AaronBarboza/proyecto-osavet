import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoticiasPage extends StatefulWidget {
  const NoticiasPage({Key? key}) : super(key: key);

  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
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
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/noticias.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Noticias',
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10.0),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('noticias')
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
                                    height: 300.0,
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
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(
                                                    height:
                                                        15.0), // Aumentamos el espacio
                                                Text(
                                                  data['descripcion'],
                                                  style: const TextStyle(
                                                      fontSize: 20.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(
                                                    height:
                                                        15.0), // Aumentamos el espacio
                                                Text(
                                                  data['fecha'],
                                                  style: const TextStyle(
                                                      fontSize: 20.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  data['hora'],
                                                  style: const TextStyle(
                                                      fontSize: 20.0),
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
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/noticias2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
