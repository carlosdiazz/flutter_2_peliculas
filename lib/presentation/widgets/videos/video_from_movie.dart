import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Propio
import 'package:flutter_2_cinema_app/domain/entities/video.dart';
import 'package:flutter_2_cinema_app/presentation/providers/providers.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final FutureProviderFamily<List<Video>, int> videosFromMovieProvider =
    FutureProvider.family((ref, int movieId) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getYoutubeVideosById(movieId: movieId);
});

class VideosFromMovie extends ConsumerWidget {
  const VideosFromMovie({super.key, required this.movieId});
  final int movieId;

  @override
  Widget build(BuildContext context, ref) {
    final moviesFromVideo = ref.watch(videosFromMovieProvider(movieId));

    return moviesFromVideo.when(
        data: (data) => _Videoslist(videos: data),
        error: (_, __) =>
            const Center(child: Text('No se pudo cargar películas similares')),
        loading: () =>
            const Center(child: CircularProgressIndicator(strokeWidth: 2)));
  }
}

class _Videoslist extends StatelessWidget {
  const _Videoslist({required this.videos});
  final List<Video> videos;

  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //*Solo titulo Video
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Videos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        //* Mostrar solo el primer video
        _YoutubeVideoPlayerState(
            name: videos.first.name, youtubeId: videos.first.youtubekey),

        ////* Si se desean mostrar todos los videos
        //...videos
        //    .map((video) => _YoutubeVideoPlayerState(
        //        youtubeId: videos.first.youtubekey, name: video.name))
        //    .toList()
      ],
    );
  }
}

class _YoutubeVideoPlayerState extends StatefulWidget {
  const _YoutubeVideoPlayerState({required this.name, required this.youtubeId});
  final String youtubeId;
  final String name;

  @override
  State<_YoutubeVideoPlayerState> createState() =>
      __YoutubeVideoPlayerStateState();
}

class __YoutubeVideoPlayerStateState extends State<_YoutubeVideoPlayerState> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
        hideThumbnail: true,
        showLiveFullscreenButton: false,
        mute: false,
        autoPlay: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [Text(widget.name), YoutubePlayer(controller: _controller)],
      ),
    );
  }
}
