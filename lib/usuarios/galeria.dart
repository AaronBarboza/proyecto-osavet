import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Directory, File, Platform;

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final List<String> _imagePaths = [
    'assets/galeria1.png',
    'assets/galeria2.png',
    'assets/galeria3.png',
    'assets/galeria4.png',
    'assets/galeria5.png',
    'assets/galeria6.png',
    'assets/galeria7.png',
    'assets/galeria8.png',
    'assets/galeria9.png',
    'assets/galeria10.png',
  ];
// Lista para almacenar rutas de imágenes locales

  @override
  Widget build(BuildContext context) {
    const linearGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF72EDF2),
        Color(0xFF5151E5),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF72EDF2),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: linearGradient,
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'Galería de Fotos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CarouselSlider(
              options: CarouselOptions(
                height: 400,
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: _imagePaths
                  .map(
                    (item) => Container(
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl: item,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Estas son fotos recuperadas de nuestra página de Facebook. ¡Disfruta de nuestra galería!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
