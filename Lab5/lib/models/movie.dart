class Trailer {
  final String title;
  final String url;

  Trailer({required this.title, required this.url});
}

class Movie {
  final int id;
  final String title;
  final String posterUrl;
  final String overview;
  final List<String> genres;
  final double rating;
  final List<Trailer> trailers;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.trailers,
  });
}

class MovieData {
  static List<Movie> getMovies() {
    return [
      Movie(
        id: 1,
        title: 'Dune: Part Two',
        posterUrl:
            'https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg',
        overview:
            'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
        genres: ['Sci-Fi', 'Adventure', 'Drama'],
        rating: 8.6,
        trailers: [
          Trailer(
            title: 'Official Trailer #1',
            url: 'https://www.youtube.com/watch?v=Way9Dexny3w',
          ),
          Trailer(
            title: 'IMAX Sneak Peek',
            url: 'https://www.youtube.com/watch?v=U2Qp5pL3ovA',
          ),
        ],
      ),
      Movie(
        id: 2,
        title: 'Deadpool & Wolverine',
        posterUrl:
            'https://image.tmdb.org/t/p/original/8cdWjvZonExUUQq0j4TJwit2fQq.jpg',
        overview:
            'The multiverse gets messy when Wade Wilson teams up with Wolverine for a not-so-family-friendly mission.',
        genres: ['Action', 'Comedy'],
        rating: 8.3,
        trailers: [
          Trailer(
            title: 'Red Band Trailer',
            url: 'https://www.youtube.com/watch?v=73_1biulkYk',
          ),
          Trailer(
            title: 'Behind the Scenes',
            url: 'https://www.youtube.com/watch?v=Idh8n5XuYIA',
          ),
        ],
      ),
    ];
  }
}
