import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/features/movie_detail/routes.dart';
import 'package:flutter_movie_db/features/movie_list/presenter/bloc/movie_list_bloc.dart';
import 'package:flutter_movie_db/features/movie_list/routes.dart';
import 'package:go_router/go_router.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  
  @override
  void initState() {
    super.initState();
    context.read<MovieListBloc>().add(LoadMovieListsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movies',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[900],
      body: BlocBuilder<MovieListBloc, MovieListState>(
        builder: (context, state) {
          return switch (state) {
            MovieListInitial() || MovieListLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            MovieListLoaded() => _buildMovieLists(state),
            MovieListError() => _buildErrorWidget(state),
          };
        },
      ),
    );
  }

  Widget _buildMovieLists(MovieListLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<MovieListBloc>().add(RefreshMovieListsEvent());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMovieSection(
              MovieListType.nowPlaying,
              state.getNowPlayingMovieListResponseEntity,
            ),
            _buildMovieSection(
              MovieListType.popular,
              state.getPopularMovieListResponseEntity,
            ),
            _buildMovieSection(
              MovieListType.topRated,
              state.getTopRatedMovieListResponseEntity,
            ),
            _buildMovieSection(
              MovieListType.upcoming,
              state.getUpcomingMovieListResponseEntity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieSection(MovieListType movieListType, dynamic movieList) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMovieCategoryTitle(movieListType),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: _buildMovieList(movieList),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieCategoryTitle(MovieListType movieListType) {
    return Row(
      children: [
        Text(
          movieListType.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () => _navigateToPaginatedMovieList(context, movieListType),
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue[400],
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('Browse All'),
        ),
      ],
    );
  }

  Widget _buildMovieList(movieList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movieList.results?.length ?? 0,
      itemBuilder: (context, index) {
        final movie = movieList.results?[index];
        return GestureDetector(
          onTap: () {
            _navigateToMovieDetail(context, movie.id.toString());
          },
          child: SizedBox(
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMoviePoster(movie),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildMovieTitle(movie),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMoviePoster(movie) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 2/3,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(4),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(4),
            ),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${movie?.posterPath}',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMovieTitle(movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie?.title ?? 'Unknown',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          movie?.releaseDate ?? 'Unknown',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget(MovieListError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Error: ${state.message}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<MovieListBloc>().add(LoadMovieListsEvent());
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _navigateToMovieDetail(BuildContext context, String movieId) {
    MovieDetailRoutes.navigateToMovieDetail(context, movieId);
  }

  void _navigateToPaginatedMovieList(BuildContext context, MovieListType movieListType) {
    final route = switch (movieListType) {
      MovieListType.nowPlaying => MovieListRoutes.nowPlaying,
      MovieListType.popular => MovieListRoutes.popular,
      MovieListType.topRated => MovieListRoutes.topRated,
      MovieListType.upcoming => MovieListRoutes.upcoming,
    };
    context.push(route, extra: movieListType);
  }
}