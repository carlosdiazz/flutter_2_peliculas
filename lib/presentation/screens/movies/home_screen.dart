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
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
    //print(movies);
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlidesShowProvider = ref.watch(moviesSlideshowProvider);
    final popularMoviesShowProvider = ref.watch(popularMoviesProvider);
    final upComingMoviesShowProvider = ref.watch(upComingMoviesProvider);

    if (moviesSlidesShowProvider.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return CustomScrollView(slivers: [
      //Sliver en el menu para que se quede fijo
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppBar(),
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            MoviesSlideShow(movies: moviesSlidesShowProvider),
            MovieHorizontalListview(
              movies: nowPlayingMovies,
              title: "En Cines",
              subTitle: "Lun, 20",
              loadNextPage: () {
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
              },
            ),
            MovieHorizontalListview(
              movies: upComingMoviesShowProvider,
              title: "Proximamanete",
              subTitle: "UpComing",
              loadNextPage: () {
                ref.read(upComingMoviesProvider.notifier).loadNextPage();
              },
            ),
            MovieHorizontalListview(
              movies: popularMoviesShowProvider,
              title: "Populares",
              //subTitle: "Lun, 20",
              loadNextPage: () {
                ref.read(popularMoviesProvider.notifier).loadNextPage();
              },
            ),
            MovieHorizontalListview(
              movies: nowPlayingMovies,
              title: "Mejores calificadas",
              subTitle: "Top",
              loadNextPage: () {
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
              },
            ),
            const SizedBox(
              height: 500,
            )
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
      }, childCount: 1))
    ]);
  }
}
