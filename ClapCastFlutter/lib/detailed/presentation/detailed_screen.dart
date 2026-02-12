import 'package:clapcastflutter/app/model/movie.dart';
import 'package:clapcastflutter/app/model/person.dart';
import 'package:clapcastflutter/app/widgets/ContentScrollRow.dart';
import 'package:clapcastflutter/app/widgets/header.dart';
import 'package:clapcastflutter/app/widgets/imageApi.dart';
import 'package:clapcastflutter/ressources/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/widgets/background.dart';
import '../../app/widgets/base_layout.dart';
import '../../app/widgets/qr_code.dart';
import '../../search/presentation/category_screen.dart';
import '../domain/detailed_notifier.dart';

class DetailedScreen extends StatefulWidget {
  final bool isAPerson;
  final int contentId;

  const DetailedScreen({
    super.key,
    this.isAPerson = false,
    this.contentId = 27205,
  });

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = context.read<DetailedNotifier>();
      if (widget.isAPerson) {
        notifier.fetchPersonDetails(widget.contentId);
      } else {
        notifier.fetchMovieDetails(widget.contentId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<DetailedNotifier>();

    return BaseLayout(
      currentIndex: 0,
      child: AppMenuBackground(
        child: _buildBody(notifier),
      ),
    );
  }

  Widget _buildBody(DetailedNotifier notifier) {
    if (widget.isAPerson && notifier.person == null) {
      return const Center(
          child: CircularProgressIndicator(color: AppColor.white));
    }
    if (!widget.isAPerson && notifier.movie == null) {
      return const Center(
          child: CircularProgressIndicator(color: AppColor.white));
    }

    return SafeArea(
      child: widget.isAPerson
          ? _buildActorContent(notifier.person!)
          : _buildMovieContent(notifier.movie!),
    );
  }

  Widget _buildActorContent(PersonDetails person) {
    final List<MovieOverview>? moviesList = person.knownForMovies?.cast.map((movie) {
      return MovieOverview(
        id: movie.id,
        title: movie.title,
        posterPathImage: movie.posterPathImage,
        popularityRate: movie.popularityRate,
        releaseDate: movie.releaseDate,
        score: movie.score,
      );
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          SectionBar(
              sectionName: person.name ?? "Unknown",
              onBackClick: () => Navigator.pop(context)
          ),
          _buildImage(person.profilePathImage),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              person.biography ?? "No biography",
              style: const TextStyle(
                color: AppColor.white,
                fontSize: 14.0,
                height: 1.5,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          ContentScrollRowMovie(
            rowTitle: "Known for:",
            movies: moviesList,
            onMovieClick: (movie) => _navigateToDetail(movie.id, false),
            onMoreClick: (movies) => _navigateToCategory("Distribution", people: [], movies: movies),
          ),
          const SizedBox(height: 16),
          QrCodeClapCast(url: "https://www.themoviedb.org/person/${person.id}"),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildMovieContent(MovieDetails movie) {
    final List<PersonOverview>? castList = movie.distribution?.cast.map((castMember) {
      return PersonOverview(
        id: castMember.personId,
        name: castMember.actorName,
        profilePathImage: castMember.profilePathImage,
        popularityRate: castMember.popularityRate,
      );
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          SectionBar(
              sectionName: movie.title ?? "Unknown",
              onBackClick: () => Navigator.pop(context)
          ),
          _buildImage(movie.posterPathImage),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              movie.overview ?? "No description",
              style: const TextStyle(
                color: AppColor.white,
                fontSize: 14.0,
                height: 1.5,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          ContentScrollRowCast(
            rowTitle: "Distribution",
            castMembers: castList,
            onPersonClick: (person) => _navigateToDetail(person.id, true),
            onMoreClick: (people) => _navigateToCategory("Distribution", people: people, movies: []),
          ),
          const SizedBox(height: 16),
          QrCodeClapCast(url: "https://www.themoviedb.org/movie/${movie.id}"),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildImage(String? path) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),

      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: ImageApi(
              imagePath: path ?? "",
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(int id, bool isPerson) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailedScreen(
          contentId: id,
          isAPerson: isPerson,
        ),
      ),
    );
  }

  void _navigateToCategory(String title, {required List<PersonOverview> people, required List<MovieOverview> movies}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(
          categoryTitle: title,
          people: people,
          movies: movies,
        ),
      ),
    );
  }
}