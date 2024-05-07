import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
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
  void initState() {
    super.initState();
    _loadLocalImages();
  }

  Future<void> _loadLocalImages() async {
    // Suponiendo que tus imágenes están en la carpeta 'assets/images'
    final directory = Directory('assets/images');
    final files = directory.listSync().whereType<File>().toList();

    for (final file in files) {
      setState(() {
        _imagePaths.add(file.path); // Agrega la ruta de cada imagen a la lista
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: CarouselSlider(
          options: CarouselOptions(
            height: 400, // Altura del slider
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          items: _imagePaths
              .map((item) => Container(
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
                  ))
              .toList(),
        ),
      ),
    );
  }
}
