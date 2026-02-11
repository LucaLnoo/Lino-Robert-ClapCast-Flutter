import 'package:clapcastflutter/app/model/movie.dart';
import 'package:clapcastflutter/app/model/person.dart';
import 'package:clapcastflutter/app/widgets/header.dart';
import 'package:clapcastflutter/ressources/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/widgets/background.dart';
import '../../app/widgets/base_layout.dart';
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
      return const Center(child: CircularProgressIndicator(color: AppColor.white));
    }
    if (!widget.isAPerson && notifier.movie == null) {
      return const Center(child: CircularProgressIndicator(color: AppColor.white));
    }

    return SafeArea(
      child:
      Column(
        children: [
          if(widget.isAPerson)
            _buildActorContent(notifier.person!)
          else
            _buildMovieContent(notifier.movie!)
        ],
      )
    );
  }

  Widget _buildActorContent(PersonDetails person) {
    return SectionBar(sectionName: person.name ?? "Unknown");
  }

  Widget _buildMovieContent(MovieDetails movie) {
    return SectionBar(sectionName: movie.title ?? "Unknown");
  }
}