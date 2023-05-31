import 'package:flutter_app_toktik/domain/entities/video_post.dart';

class LocalVideoModel {
  final String name;
  final String videoURL;
  final int likes;
  final int views;

  LocalVideoModel(
      {required this.name,
      required this.videoURL,
      this.likes = 0,
      this.views = 0});

  // * Constructores de fábrica (factory), generalmente usan un return y no hacen referencia 'this', pero como usamos una función anónima de una línea no es necesario un return, también es usado típicamente con 'fromJson' para extraer datos de un JSON a un objeto. No crea una instancia, sin embargo devuelve una, o tal vez una existente
  factory LocalVideoModel.fromJson(Map<String, dynamic> json) =>
      LocalVideoModel(
          name: json['name'] ?? 'No Name',
          videoURL: json['videoURL'],
          likes: json['likes'] ?? 0,
          views: json['views'] ?? 0);

  // * Este método nos devuelve un objeto del tipo VideoPost con los datos de esta clase LocalVideoModel
  VideoPost toVideoPostEntity() =>
      VideoPost(caption: name, videoURL: videoURL, likes: likes, views: views);
}
