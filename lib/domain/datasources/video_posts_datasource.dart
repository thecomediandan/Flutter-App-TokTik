import 'package:flutter_app_toktik/domain/entities/video_post.dart';

// * El origen de datos, de donde vamos a tomar los datos
// * Una abstract class es para generar una plantilla de una clase para luego implementarlo

abstract class VideoPostDatasource {
  Future<List<VideoPost>> getTrendingVideosByPage(int page);
  Future<List<VideoPost>> getFavoriteVideosByUser(String userID);
}
