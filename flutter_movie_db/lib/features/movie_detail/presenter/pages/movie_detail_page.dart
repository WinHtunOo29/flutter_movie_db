import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/core/di/injector.dart';
import 'package:flutter_movie_db/features/movie_detail/presenter/bloc/movie_detail_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  final String movieId;
  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late MovieDetailBloc _movieDetailBloc;

  @override
  void initState() {
    super.initState();
    _movieDetailBloc = getIt<MovieDetailBloc>();
    _movieDetailBloc.add(LoadMovieDetailEvent(movieId: int.parse(widget.movieId)));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailBloc>(
      create: (context) => _movieDetailBloc,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: const Text('Movie Details'),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieDetailLoaded) {
              return _buildMovieDetailContent(state.movieDetail);
            } else if (state is MovieDetailError) {
              return _buildErrorContent(state);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildMovieDetailContent(movieDetail) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (movieDetail.backdropPath != null)
            _buildBackdrop(movieDetail),
  
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 46.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleAndRating(movieDetail),
                const SizedBox(height: 8),          
                if (movieDetail.originalTitle != movieDetail.title)
                  _buildOriginalTitle(movieDetail),             
                const SizedBox(height: 16),
                _buildGenres(movieDetail),
                const SizedBox(height: 16),
                _buildOverviewTitle(),
                const SizedBox(height: 8),
                _buildOverviewContent(movieDetail), 
                const SizedBox(height: 24),
                _buildDetailRow('Release Date', movieDetail.releaseDate ?? 'N/A'),
                _buildDetailRow('Runtime', movieDetail.runtime != null ? '${movieDetail.runtime} minutes' : 'N/A'),
                _buildDetailRow('Status', movieDetail.status),
                _buildDetailRow('Budget', '\$${movieDetail.budget.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'),
                _buildDetailRow('Revenue', '\$${movieDetail.revenue.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'),
                
                if (movieDetail.tagline != null && movieDetail.tagline!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _buildTagline(movieDetail),
                ],
                
                const SizedBox(height: 24),

                if (movieDetail.productionCompanies.isNotEmpty) ...[
                  _buildProductionCompaniesTitle(),
                  const SizedBox(height: 8),
                  _buildProductionCompanies(movieDetail),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  

  Widget _buildBackdrop(movieDetail) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://image.tmdb.org/t/p/w1280${movieDetail.backdropPath}',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTitleAndRating(movieDetail) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            movieDetail.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Text(
                movieDetail.voteAverage.toStringAsFixed(1),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOriginalTitle(movieDetail) {
    return Text(
      movieDetail.originalTitle,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget _buildGenres(movieDetail) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: movieDetail.genres.map<Widget>((genre) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            genre.name,
            style: TextStyle(
              color: Colors.blue[800],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildOverviewTitle() {
    return const Text(
      'Overview',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildOverviewContent(movieDetail) {
    return Text(
      movieDetail.overview,
      style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.white),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagline(movieDetail) {
    return Text(
      '"${movieDetail.tagline}"',
      style: TextStyle(
        fontSize: 16,
        fontStyle: FontStyle.italic,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildProductionCompaniesTitle() {
    return const Text(
      'Production Companies',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildProductionCompanies(movieDetail) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: movieDetail.productionCompanies.map<Widget>((company) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            company.name,
            style: const TextStyle(fontSize: 12),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildErrorContent(MovieDetailError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Error: ${state.message}',
            style: const TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
            
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}