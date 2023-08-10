import 'package:flutter/material.dart';
import 'package:flutter_2_cinema_app/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter_2_cinema_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie_creation_outlined,
                color: colors.primary,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "CinemaPeli",
                style: titleStyle,
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    final movieRepository = ref.read(movieRepositoryProvider);

                    showSearch(
                        context: context,
                        delegate: SearchMovieDelegate(
                            searchMovies: ((query) =>
                                movieRepository.searchMovies(query: query))));
                  },
                  icon: const Icon(Icons.search_outlined))
            ],
          ),
        ),
      ),
    );
  }
}
