import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../ressources/app_color.dart';
import 'imageApi.dart';
import 'button.dart';

class ContentScrollRowPeople extends StatelessWidget {
  final String rowTitle;
  final List<dynamic>? people;
  final Function(dynamic) onPersonClick;
  final Function(List<dynamic>) onMoreClick;

  const ContentScrollRowPeople({
    super.key,
    required this.rowTitle,
    required this.people,
    required this.onPersonClick,
    required this.onMoreClick,
  });

  @override
  Widget build(BuildContext context) {
    return _GenericContentScrollRow<dynamic>(
      rowTitle: rowTitle,
      dataList: people,
      onItemClick: onPersonClick,
      onMoreClick: onMoreClick,
      nameMapper: (item) {
        // TODO: API - Décommenter quand le modèle PersonOverview aura 'name'
        // return item.name ?? "Inconnu";
        return "Nom Acteur (TODO)";
      },
      imageMapper: (item) {
        // TODO: API - Décommenter quand le modèle aura 'profilePath'
        // return item.profilePath ?? "";
        return "";
      },
    );
  }
}

class ContentScrollRowMovie extends StatelessWidget {
  final String rowTitle;
  final List<dynamic>? movies;
  final Function(dynamic) onMovieClick;
  final Function(List<dynamic>) onMoreClick;

  const ContentScrollRowMovie({
    super.key,
    required this.rowTitle,
    required this.movies,
    required this.onMovieClick,
    required this.onMoreClick,
  });

  @override
  Widget build(BuildContext context) {
    return _GenericContentScrollRow<dynamic>(
      rowTitle: rowTitle,
      dataList: movies,
      onItemClick: onMovieClick,
      onMoreClick: onMoreClick,
      nameMapper: (item) {
        return item.title ?? "Inconnu";
      },
      imageMapper: (item) {
        // TODO: API - Décommenter quand le modèle MovieOverview aura 'posterPath'
        // return item.posterPath ?? "";

        return ""; // TEMP: évite le crash lors des tests
      },
    );
  }
}

class ContentScrollRowCast extends StatelessWidget {
  final String rowTitle;
  final List<dynamic>? castMembers;
  final Function(dynamic) onPersonClick;
  final Function(List<dynamic>) onMoreClick;

  const ContentScrollRowCast({
    super.key,
    required this.rowTitle,
    required this.castMembers,
    required this.onPersonClick,
    required this.onMoreClick,
  });

  @override
  Widget build(BuildContext context) {
    return _GenericContentScrollRow<dynamic>(
      rowTitle: rowTitle,
      dataList: castMembers,
      onItemClick: onPersonClick,
      onMoreClick: onMoreClick,
      nameMapper: (item) {
        // TODO: API - Connecter au champ 'actorName'
        return "Nom Acteur (TODO)";
      },
      imageMapper: (item) {
        // TODO: API - Connecter au champ 'profilePath'
        return "";
      },
    );
  }
}

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
                    color: Colors.white,
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
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 190.0,
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
    final int delayMs = (widget.index % 4) * 50;

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
