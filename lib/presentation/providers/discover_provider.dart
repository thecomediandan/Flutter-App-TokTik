import 'package:flutter/material.dart';
import 'package:flutter_app_toktik/domain/repositories/video_posts_repository.dart';
// import 'package:flutter_app_toktik/infrastructure/models/local_video_model.dart';
// import 'package:flutter_app_toktik/shared/data/local_video_posts.dart';

import '../../domain/entities/video_post.dart';

/**
 * 1. UI
 * 2. Presentacion
 * 3. Casos de uso (Lógica de negocio)
 * 4. Repositorios y Datasources
 * %. Información regresa al UI
 */ ///

// * Un provider solo se limita a renderizar Widgets o no deberia tener otras responsabilidades

// * ChangeNotifier se implementa de un listenable
class DiscoverProvider extends ChangeNotifier {
  // ? Repository (Permite lanzar las peticiones respectivas aqui puede ir el DataSource), DataSource (Fuente de la data, local, internet o JSON local)
  final VideoPostRepository videosRepository;

  DiscoverProvider({required this.videosRepository});

  bool initialLoading = true; // ? Con esto sabemos si ya cargamos los videos
  // Lista de videos en formato de objetos del archivo video_post.dart
  List<VideoPost> videos = [];

  // Un método async siempre resuleve un Future, en este caso devolvemos un future vacío
  Future<void> loadNextPage() async {
    // Esperamos 2 segundos para ejecutar lo siguiente, esto para simular un retardo de tráfico de internet
    await Future.delayed(const Duration(seconds: 2));

    // * Simulamos que obtenemos un JSON con el archivo local_video_posts.dart, videoPosts es un objeto List<Map<String, dynamic>> una lista de Maps.
    // Luego mapeamos esta lista de maps para convertir cada map en un VideoPost pero a través de una clase que transforma este Map a un objeto VideoPost, a través de un transformador 'fromJson' (puede ser fromJsonMap), y un método que devuelve un VideoPost con datos extrídos del Map en formato JSON
    // el método 'map' recorre la Lista de Maps llamada videoPosts del archivo local_video_posts.dart, esto nos devuelve un 'Iterable' al cual convertimos a una lista normal con 'toList()'
    // final List<VideoPost> newVideos = videoPosts
    //     .map(
    //       (video) => LocalVideoModel.fromJson(video).toVideoPostEntity(),
    //     )
    //     .toList();
    // ? Las anteriores línea solo funciona sin los conceptos de Datasource y Repository

    final newVideos = await videosRepository.getTrendingVideosByPage(1);

    // * Agregamos los valores convertidos a la propiedad 'videos'
    videos.addAll(newVideos);
    initialLoading = false;

    // * Notificamos a quienes escuchan objetos instanciados de esta clase que se han realizado cambios
    notifyListeners();
  }
}
