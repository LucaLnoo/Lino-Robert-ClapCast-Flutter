import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../../ressources/app_color.dart';
import '../../ressources/app_dimens.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.0,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColor.btnPrimary,
            Colors.black,
          ],
          stops: [0.0, 0.4, 1.0],
        ),
      ),
      child: Center(
        child: Image.asset(
          Assets.assetsIcLogo,
          width: 95.0,
          height: 95.0,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class SectionBar extends StatelessWidget {
  final String sectionName;
  final VoidCallback? onBackClick;

  const SectionBar({
    super.key,
    required this.sectionName,
    this.onBackClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40.0,
      color: Colors.black,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onBackClick,
              icon: Image.asset(
                Assets.assetsIcArrowBack,
                color: Colors.white,
                width: 24,
                height: 24,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),

            const Spacer(flex: 1),

            Text(
              sectionName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),

            const Spacer(flex: 1),

            const SizedBox(width: 48.0, height: 48.0),
          ],
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatefulWidget {
  final String query;
  final ValueChanged<String> onQueryChange;
  final VoidCallback onSearchClick;

  // TODO Ajouter les callbacks pour les filtres (isActorFilter, etc.)

  const SearchBarWidget({
    super.key,
    required this.query,
    required this.onQueryChange,
    required this.onSearchClick,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool showFilter = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppMargin.medium,
          vertical: AppMargin.small
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 55.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(AppRadius.large),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(text: widget.query)
                            ..selection = TextSelection.fromPosition(
                                TextPosition(offset: widget.query.length)),
                          onChanged: widget.onQueryChange,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Rechercher...", // TODO Utiliser localization stringResource
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                          cursorColor: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: widget.onSearchClick,
                        icon: Image.asset(
                          Assets.assetsIcSearch,
                          color: AppColor.appContrast,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8.0),

              GestureDetector(
                onTap: () {
                  setState(() {
                    showFilter = !showFilter;
                  });
                },
                child: Container(
                  width: 45.0,
                  height: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.assetsIcFilter,
                        color: AppColor.appContrast,
                        width: 24,
                        height: 24,
                      ),
                      Text(
                        "Filtres", // TODO Utiliser localization
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColor.appContrast,
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          if (showFilter)
          // TODO Integrer FilterWidget ici et passer les parametres
            Container(height: 50, color: Colors.transparent)
        ],
      ),
    );
  }
}

class NavigationBarHeader extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const NavigationBarHeader({
    super.key,
    this.selectedIndex = 0,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = ["Acteurs", "Films"]; // TODO Utiliser localization

    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 48.0,
            child: Row(
              children: List.generate(tabs.length, (index) {
                return Expanded(
                  child: InkWell(
                    onTap: () => onTabSelected(index),
                    child: Center(
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          color: const Color(0xFFF4E1D2),
                          fontSize: 16.0,
                          fontWeight: selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          SizedBox(
            height: 3.0,
            child: Stack(
              children: [
                Container(color: const Color(0xFF2E2E2E)),

                AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  alignment: Alignment(selectedIndex == 0 ? -1.0 : 1.0, 0.0),
                  child: FractionallySizedBox(
                    widthFactor: 1 / tabs.length,
                    child: Container(
                      color: const Color(0xFFF4E1D2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}