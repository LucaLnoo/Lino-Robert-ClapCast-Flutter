import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../generated/assets.dart';
import '../../ressources/app_color.dart';
import '../../ressources/app_dimens.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppHeaderSize.logoContainerHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColor.btnPrimary,
            Colors.black,
            Colors.black
          ],
          stops: [0.0, 0.4, 1.0],
        ),
      ),
      child: Center(
        child: Image.asset(
          Assets.assetsIcLogo,
          width: AppHeaderSize.logoImageSize,
          height: AppHeaderSize.logoImageSize,
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
      height: AppHeaderSize.sectionBarHeight,
      color: Colors.black,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppMargin.small),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onBackClick,
              icon: Image.asset(
                Assets.assetsIcArrowBack,
                color: Colors.white,
                width: AppIconSize.medium,
                height: AppIconSize.medium,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),

            const Spacer(flex: 1),

            Text(
              sectionName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontSize: AppText.headerTitle,
              ),
            ),

            const Spacer(flex: 1),

            const SizedBox(width: AppIconSize.xxxlarge, height: AppIconSize.xxxlarge),
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

  final ValueChanged<bool> onFilterToggle;
  final bool isFilterOpen;

  const SearchBarWidget({
    super.key,
    required this.query,
    required this.onQueryChange,
    required this.onSearchClick,
    required this.onFilterToggle,
    required this.isFilterOpen,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.query);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SearchBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.query != _controller.text) {
      _controller.text = widget.query;
      _controller.selection = TextSelection.fromPosition(TextPosition(offset: widget.query.length));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppMargin.medium, vertical: AppMargin.small),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: AppHeaderSize.searchBarHeight,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(AppRadius.large),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: widget.onQueryChange,
                      onSubmitted: (_) => widget.onSearchClick(),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: l10n.searchHint,
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
                      ),
                      cursorColor: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onSearchClick,
                    icon: Image.asset(
                      Assets.assetsIcSearch,
                      color: AppColor.appContrast,
                      width: AppIconSize.medium,
                      height: AppIconSize.medium,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: AppMargin.small),

          GestureDetector(
            onTap: () {
              widget.onFilterToggle(!widget.isFilterOpen);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppMargin.tiny),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.assetsIcFilter,
                    color: AppColor.appContrast,
                    width: AppIconSize.medium,
                    height: AppIconSize.medium,
                  ),
                  const SizedBox(height: AppMargin.veryTiny),
                  Text(
                    l10n.filter,
                    style: const TextStyle(
                        color: AppColor.appContrast,
                        fontSize: AppText.filterLabel,
                        fontWeight: FontWeight.normal
                    ),
                  )
                ],
              ),
            ),
          ),
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
    final l10n = AppLocalizations.of(context)!;
    final tabs = [l10n.actors, l10n.movies];

    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: AppHeaderSize.tabBarHeight,
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
                          fontSize: AppText.medium,
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
            height: AppStickBar.small,
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