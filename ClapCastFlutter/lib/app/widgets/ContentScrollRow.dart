import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../app/model/movie.dart';
import '../../app/model/person.dart';

import 'button.dart';

// ==============================================================================
// 1. WIDGET POUR LES PERSONNES
// ==============================================================================
class ContentScrollRowPeople extends StatelessWidget {
  final String rowTitle;
  final List<PersonOverview>? people;
  final Function(PersonOverview) onPersonClick;
  final Function(List<PersonOverview>) onMoreClick;

  const ContentScrollRowPeople({
    super.key,
    required this.rowTitle,
    required this.people,
    required this.onPersonClick,
    required this.onMoreClick,
  });

  @override
  Widget build(BuildContext context) {
    return _GenericContentScrollRow<PersonOverview>(
      rowTitle: rowTitle,
      dataList: people,
      onItemClick: onPersonClick,
      onMoreClick: onMoreClick,
      nameMapper: (item) => item.name ?? "Inconnu",
      imageMapper: (item) => item.profilePathImage  ?? "",
    );
  }
}

// ==============================================================================
// 2. WIDGET POUR LES FILMS
// ==============================================================================
class ContentScrollRowMovie extends StatelessWidget {
  final String rowTitle;
  final List<MovieOverview>? movies;
  final Function(MovieOverview) onMovieClick;
  final Function(List<MovieOverview>) onMoreClick;

  const ContentScrollRowMovie({
    super.key,
    required this.rowTitle,
    required this.movies,
    required this.onMovieClick,
    required this.onMoreClick,
  });

  @override
  Widget build(BuildContext context) {
    return _GenericContentScrollRow<MovieOverview>(
      rowTitle: rowTitle,
      dataList: movies,
      onItemClick: onMovieClick,
      onMoreClick: onMoreClick,
      // Dart sait que 'item' est un MovieOverview
      nameMapper: (item) => item.title ?? "Inconnu",
      imageMapper: (item) => item.posterPathImage ?? "",
    );
  }
}

// ==============================================================================
// 3. WIDGET POUR LE CASTING (DetailedScreen)
// ==============================================================================
class ContentScrollRowCast extends StatelessWidget {
  final String rowTitle;
  final List<PersonOverview>? castMembers;
  final Function(PersonOverview) onPersonClick;
  final Function(List<PersonOverview>) onMoreClick;

  const ContentScrollRowCast({
    super.key,
    required this.rowTitle,
    required this.castMembers,
    required this.onPersonClick,
    required this.onMoreClick,
  });

  @override
  Widget build(BuildContext context) {
    return _GenericContentScrollRow<PersonOverview>(
      rowTitle: rowTitle,
      dataList: castMembers,
      onItemClick: onPersonClick,
      onMoreClick: onMoreClick,
      nameMapper: (item) => item.name ?? "Inconnu",
      imageMapper: (item) => item.profilePathImage ?? "",
    );
  }
}

// ==============================================================================
// 4. MOTEUR GÉNÉRIQUE POUR LES CONTENT SCROLL ROW
// ==============================================================================
class _GenericContentScrollRow<T> extends StatelessWidget {
  final String rowTitle;
  final List<T>? dataList;
  final Function(T) onItemClick;
  final Function(List<T>) onMoreClick;

  final String Function(T) nameMapper;
  final String Function(T) imageMapper;

  const _GenericContentScrollRow({
    required this.rowTitle,
    required this.dataList,
    required this.onItemClick,
    required this.onMoreClick,
    required this.nameMapper,
    required this.imageMapper,
  });

  @override
  Widget build(BuildContext context) {
    if (dataList == null || dataList!.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12.0),

        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  rowTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => onMoreClick(dataList!),
                icon: Transform.rotate(
                  angle: math.pi,
                  child: Image.asset(
                    "assets/ic_arrow_back.png",
                    width: 24,
                    height: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),

        // --- LISTE HORIZONTALE ---
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: dataList!.length,
            itemBuilder: (context, index) {
              final item = dataList![index];

              return _AnimatedItem(
                index: index,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: MediaCardButton(
                    // On utilise les mappers pour récupérer les infos sans connaître le type exact
                    text: nameMapper(item),
                    imagePath: imageMapper(item),
                    onClick: () => onItemClick(item),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ==============================================================================
// 5. ANIMATION DES ITEMS
// ==============================================================================
class _AnimatedItem extends StatefulWidget {
  final int index;
  final Widget child;

  const _AnimatedItem({required this.index, required this.child});

  @override
  State<_AnimatedItem> createState() => _AnimatedItemState();
}

class _AnimatedItemState extends State<_AnimatedItem> with SingleTickerProviderStateMixin {
  double _scale = 0.8;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Délai en cascade pour l'animation d'apparition
    // On limite à index 10 pour ne pas attendre 10 secondes si la liste est longue
    final int safeIndex = (widget.index < 10) ? widget.index : 10;
    final int delayMs = safeIndex * 50;

    Future.delayed(Duration(milliseconds: delayMs), () {
      if (mounted) {
        setState(() {
          _scale = 1.0;
          _opacity = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 300);
    const curve = Curves.easeOut;

    return AnimatedScale(
      scale: _scale,
      duration: duration,
      curve: curve,
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: duration,
        curve: curve,
        child: widget.child,
      ),
    );
  }
}