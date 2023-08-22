import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Propio
import 'package:flutter_2_cinema_app/domain/entities/movie.dart';
import 'package:flutter_2_cinema_app/presentation/providers/providers.dart';
import 'package:flutter_2_cinema_app/presentation/widgets/widggets.dart';

class MovieScreen extends ConsumerStatefulWidget {
  const MovieScreen({super.key, required this.movieId});

  final String movieId;

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieDetailsProvider.notifier).loadMovie(movieId: widget.movieId);
    ref
        .read(actorsByMovieProvider.notifier)
        .loadActors(movieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(movieDetailsProvider);
    final Movie? movie = movies[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //* Aqui esta la imagen de atras de fondo
          _CustomSliverAppBar(movie: movie),

          //* Aqui estara lo que falta de la pantalla
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(movie: movie),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //*Poster, titulo y descripcion
        _PosterAndTitle(movie: movie, size: size, textStyle: textStyle),

        //* Muestros los Generos de la peliculas
        Generos(movie: movie),

        //* Muestro actores de la pelicula
        _ActorsByMovie(
          movieId: movie.id.toString(),
        ),

        //* Peliculas similares
        SimilarMovies(movieId: movie.id),

        //* Video Trailer
        VideosFromMovie(movieId: movie.id),

        //Espacio Final abajo
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({
    required this.movie,
    required this.size,
    required this.textStyle,
  });

  final Movie movie;
  final Size size;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //?Imagen del Pposter
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadiusDirectional.circular(20),
              child: Image.network(
                movie.posterPath,
                width: size.width * 0.3,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: (size.width - 60) * 0.7,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                movie.title,
                style: textStyle.titleLarge,
              ),
              Text(movie.overview)
            ]),
          )
        ],
      ),
    );
  }
}

class Generos extends StatelessWidget {
  const Generos({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        children: [
          ...movie.genreIds.map((e) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(e),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ))
        ],
      ),
    );
  }
}

final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  const _CustomSliverAppBar({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context, ref) {
    final size = MediaQuery.of(context).size;
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () async {
              //await ref
              //    .read(localStorageRepositoryProvider)
              //    .toggleFavorite(movie);
              await ref
                  .read(favoriteMoviesProvider.notifier)
                  .toggleFavorite(movie);
              ref.invalidate(isFavoriteProvider(movie.id));
              //Esto invalida el estado del mprovider y lo vuleve a el estado original
            },
            icon: isFavoriteFuture.when(
              data: (isFavorite) => isFavorite
                  ? const Icon(
                      Icons.favorite_rounded,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_border_outlined,
                    ),
              error: (error, stackTrace) => throw UnimplementedError(),
              loading: () => const CircularProgressIndicator(),
            )
            //Icon(Icons.favorite_border_outlined),

            )
      ],
      //floating: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        //title: Text(movie.title),
        background: Stack(children: [
          //?Imagen de fondo
          SizedBox.expand(
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) return const SizedBox();

                return FadeIn(child: child);
              },
            ),
          ),

          //? Fondo transparente para el titulo
          const _CustomGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.8, 1.0],
              colors: [Colors.transparent, Colors.black87]),

          //? Fondo transparente para el Corazon
          const _CustomGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            stops: [0.0, 0.2],
            colors: [
              Colors.black87,
              Colors.transparent,
            ],
          ),

          //?Fondo transparente para la flecha
          const _CustomGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.3],
              colors: [Colors.black87, Colors.transparent]),
        ]),
      ),
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  const _ActorsByMovie({required this.movieId});

  final String movieId;

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    final actors = actorsByMovie[movieId];

    if (actors == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: actors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //?Actor Photo
                FadeInRight(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                        placeholder: const AssetImage("assets/loader.gif"),
                        image: NetworkImage(actor.profilePath),
                        height: 180,
                        width: 135,
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                //?Nombre Actor
                Text(
                  actor.name,
                  maxLines: 2,
                ),
                Text(
                  actor.character ?? "",
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  const _CustomGradient(
      {required this.begin,
      required this.end,
      required this.stops,
      required this.colors});

  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: begin, end: end, stops: stops, colors: colors)),
      ),
    );
  }
}
