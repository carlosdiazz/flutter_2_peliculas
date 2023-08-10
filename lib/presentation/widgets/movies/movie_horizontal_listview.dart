import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2_cinema_app/config/helpers/human_formats.dart';
import 'package:flutter_2_cinema_app/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListview extends StatefulWidget {
  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadNextPage});
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            FadeInLeft(
              child: _Title(
                title: widget.title,
                subTitle: widget.subTitle,
              ),
            ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
              child: ListView.builder(
            controller: scrollController,
            itemCount: widget.movies.length,
            scrollDirection: Axis.horizontal,
            //physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return FadeInRight(
                  child: _SlideMovie(movie: widget.movies[index]));
            },
          ))
        ],
      ),
    );
  }
}

class _SlideMovie extends StatelessWidget {
  const _SlideMovie({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //* Esto es la Imagen
        SizedBox(
          width: 150,
          //TODOOOO
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
              width: 150,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () => context.push('/movie/${movie.id}'),
                  child: FadeIn(child: child),
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),

        //* Esto es el titulo
        SizedBox(
          width: 150,
          child: Text(
            movie.title,
            maxLines: 1,
            style: textStyle.titleSmall,
          ),
        ),

        //* Raiting
        SizedBox(
          width: 150,
          child: Row(
            children: [
              Icon(
                Icons.star_half_outlined,
                color: Colors.yellow.shade800,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                "${movie.voteAverage}",
                style: textStyle.bodyMedium,
              ),
              const Spacer(),

              Text(
                  HumanFormats.number(
                    movie.popularity,
                  ),
                  style: textStyle.bodySmall),

              //Text(
              //  '${movie.popularity}',
              //  style: textStyle.bodySmall,
              //)
            ],
          ),
        )
      ]),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({this.title, this.subTitle});

  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
              onPressed: () {},
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              child: Text(subTitle!),
            )
        ],
      ),
    );
  }
}
