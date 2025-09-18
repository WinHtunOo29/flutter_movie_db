import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/features/movie_detail/routes.dart';
import 'package:flutter_movie_db/features/movie_list/domain/entities/movie_list_response_entity.dart';
import 'package:flutter_movie_db/features/movie_list/presenter/bloc/movie_list_bloc.dart';
import 'package:flutter_movie_db/features/movie_list/presenter/bloc/paginated_movie_list_bloc.dart';

class PaginatedMovieListPage extends StatefulWidget {
  final MovieListType movieListType;

  const PaginatedMovieListPage({
    super.key,
    required this.movieListType,
  });

  @override
  State<PaginatedMovieListPage> createState() => _PaginatedMovieListPageState();
}

class _PaginatedMovieListPageState extends State<PaginatedMovieListPage> {
  final ScrollController _scrollController = ScrollController();
  List<MovieEntity> _movies = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchMovies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movieListType.name),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[900],
      body: BlocListener<PaginatedMovieListBloc, PaginatedMovieListState>(
        listener: (context, state) {
          if (state is PaginatedMovieListLoaded) {
            setState(() {
              _movies = state.movies;
              _currentPage = state.currentPage + 1;
              _hasMore = !state.hasReachedMax;
              _isLoading = false;
            });
          } else if (state is PaginatedMovieListError) {
            setState(() {
              _error = state.message;
              _isLoading = false;
            });
          }
        },
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_error != null && _movies.isEmpty) {
      return _buildErrorWidget();
    }

    if (_movies.isEmpty && _isLoading) {
      return _buildLoadingWidget();
    }

    if (_movies.isEmpty) {
      return _buildNoItemsWidget();
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: _movies.length + (_isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < _movies.length) {
          return _buildMovieCard(_movies[index]);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildMovieCard(MovieEntity movie) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Colors.grey[800],
      child: InkWell(
        onTap: () => _navigateToMovieDetail(context, movie.id.toString()),
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              _buildMoviePoster(movie),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      movie.releaseDate ?? 'Unknown',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          movie.voteAverage.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      movie.overview,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[300],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoviePoster(MovieEntity movie) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        'https://image.tmdb.org/t/p/w200${movie.posterPath}',
        width: 80,
        height: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 80,
            height: 120,
            color: Colors.grey[600],
            child: const Icon(
              Icons.movie,
              color: Colors.white,
              size: 40,
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget() {
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
            _error ?? 'Something went wrong',
            style: const TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _error = null;
                _currentPage = 1;
                _movies.clear();
                _hasMore = true;
              });
              _fetchMovies();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildNoItemsWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.movie_outlined,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No movies found',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void _onScroll() {
    final scrollPosition = _scrollController.position.pixels;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    final threshold = maxScrollExtent * 0.8;
    
    if (scrollPosition >= threshold && !_isLoading && _hasMore) {
      _fetchMovies();
    }
  }

  Future<void> _fetchMovies() async {
    if (_isLoading || !_hasMore) return;
    
    setState(() {
      _isLoading = true;
      _error = null;
    });

    context.read<PaginatedMovieListBloc>().add(
      LoadPaginatedMovieListEvent(
        movieListType: widget.movieListType,
        page: _currentPage,
      ),
    );
  }

  Future<void> _onRefresh() async {
    setState(() {
      _movies.clear();
      _currentPage = 1;
      _hasMore = true;
      _error = null;
      _isLoading = true;
    });

    context.read<PaginatedMovieListBloc>().add(
      LoadPaginatedMovieListEvent(
        movieListType: widget.movieListType,
        page: 1,
      ),
    );
  }

  void _navigateToMovieDetail(BuildContext context, String movieId) {
    MovieDetailRoutes.navigateToMovieDetail(context, movieId);
  }
}