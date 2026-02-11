import 'package:clapcastflutter/starting/domain/starting_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/widgets/ContentScrollRow.dart';
import '../../app/widgets/base_layout.dart';
import '../../app/widgets/background.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<StartingNotifier>();
    final movies = notifier.movies;
    final people = notifier.people;

    return BaseLayout(
      currentIndex: 0,
      child: AppMenuBackground(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                color: Colors.white.withOpacity(0.8),
                child: Column(
                  children: [
                    ContentScrollRowPeople(
                      rowTitle: "test",
                      people: people,
                      onPersonClick: (people) {},
                      onMoreClick: (people) {},
                    ),
                    Text(
                      "First Movie : ${movies?.isNotEmpty == true ? movies!.first.title : 'No movie data'}",
                      style: const TextStyle(color: Colors.black),
                    ),
                    Text(
                      "Actor : ${people?.isNotEmpty == true ? people!.first.name : 'No actor data'}",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}