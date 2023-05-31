import 'package:flutter_app_toktik/domain/datasources/video_posts_datasource.dart';
import 'package:flutter_app_toktik/domain/entities/video_post.dart';
import 'package:flutter_app_toktik/infrastructure/models/local_video_model.dart';
import 'package:flutter_app_toktik/shared/data/local_video_posts.dart';

// * La implementacion del datasource procesa la carga de los videos

class LocalVideoDataSource implements VideoPostDatasource {
  @override
  Future<List<VideoPost>> getFavoriteVideosByUser(String userID) {
    // TODO: implement getFavoriteVideosByUser
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPost>> getTrendingVideosByPage(int page) async {
    // * Delay solo para desarrollo
    await Future.delayed(const Duration(seconds: 2));

    final List<VideoPost> newVideos = videoPosts
        .map((video) => LocalVideoModel.fromJson(video).toVideoPostEntity())
        .toList();

    return newVideos;
  }
}
