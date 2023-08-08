import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Propio
import 'package:flutter_2_cinema_app/presentation/providers/providers.dart';
import 'package:flutter_2_cinema_app/presentation/widgets/widggets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    //print(movies);
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlidesshowProvider = ref.watch(moviesSlideshowProvider);

    if (moviesSlidesshowProvider.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        const CustomAppBar(),
        MoviesSlideShow(movies: moviesSlidesshowProvider),
        MovieHorizontalListview(
          movies: nowPlayingMovies,
          title: "En Cines",
          subTitle: "Lun, 20",
          loadNextPage: () {
            ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
          },
        ),
        //Expanded(
        //    child: ListView.builder(
        //  itemCount: nowPlayingMovies.length,
        //  itemBuilder: (context, index) {
        //    final movie = nowPlayingMovies[index];
        //    return ListTile(title: Text(movie.title));
        //  },
        //))
      ],
    );
  }
}
