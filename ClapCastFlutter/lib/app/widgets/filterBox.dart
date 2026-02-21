import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../ressources/app_color.dart';
import '../../ressources/app_dimens.dart';
import 'button.dart';

class FilterWidget extends StatelessWidget {
  final bool isActorFilter;
  final ValueChanged<bool> onActorFilterChange;
  final bool isMovieFilter;
  final ValueChanged<bool> onMovieFilterChange;

  // Filtres Acteurs
  final int genderFilter; // 0: All, 1: Female, 2: Male
  final ValueChanged<int> onGenderChange;

  // Filtres Films
  final bool isRecentFilter;
  final ValueChanged<bool> onRecentChange;

  // Filtre Global
  final bool onlyFrenchFilter;
  final ValueChanged<bool> onOnlyFrenchFilter;

  // Callback fermeture
  final VoidCallback onDismiss;

  const FilterWidget({
    super.key,
    required this.isActorFilter,
    required this.onActorFilterChange,
    required this.isMovieFilter,
    required this.onMovieFilterChange,
    required this.genderFilter,
    required this.onGenderChange,
    required this.isRecentFilter,
    required this.onRecentChange,
    required this.onlyFrenchFilter,
    required this.onOnlyFrenchFilter,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Material(
      color: Colors.transparent,
      child: Container(
        width: AppOverlaySize.filterMenuWidth,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          border: Border.all(
            color: Colors.white,
            width: AppStickBar.verytiny,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          child: _FilterWidgetContent(l10n),
        ),
      ),
    );
  }

  Widget _FilterWidgetContent(AppLocalizations l10n) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ToggleButton(
          text: l10n.actors,
          isActive: isActorFilter,
          onCheckedChange: onActorFilterChange,
        ),

        const Divider(color: Colors.white24, height: 1),

        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.topCenter,
          child: isActorFilter
              ? Column(
            children: [
              _ActorFilterContent(
                selectedGender: genderFilter,
                onGenderSelected: onGenderChange,
              ),
              const Divider(color: Colors.white24, height: 1),
            ],
          )
              : const SizedBox.shrink(),
        ),

        ToggleButton(
          text: l10n.movies,
          isActive: isMovieFilter,
          onCheckedChange: onMovieFilterChange,
        ),

        const Divider(color: Colors.white24, height: 1),

        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.topCenter,
          child: isMovieFilter
              ? Column(
            children: [
              _MovieFilterContent(
                isRecentOnly: isRecentFilter,
                onRecentChange: onRecentChange,
              ),
              const Divider(color: Colors.white24, height: 1),
            ],
          )
              : const SizedBox.shrink(),
        ),

        ToggleButton(
          text: l10n.filterOnlyFrench,
          isActive: onlyFrenchFilter,
          onCheckedChange: onOnlyFrenchFilter,
        ),
      ],
    );
  }
}

class _ActorFilterContent extends StatelessWidget {
  final int selectedGender;
  final Function(int) onGenderSelected;

  const _ActorFilterContent({
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _CustomFilterChip(
            selected: selectedGender == 0,
            text: l10n.filterAll,
            onClick: () => onGenderSelected(0),
          ),
          const SizedBox(width: 8),
          _CustomFilterChip(
            selected: selectedGender == 1,
            text: l10n.filterFemale,
            onClick: () => onGenderSelected(1),
          ),
          const SizedBox(width: 8),
          _CustomFilterChip(
            selected: selectedGender == 2,
            text: l10n.filterMale,
            onClick: () => onGenderSelected(2),
          ),
        ],
      ),
    );
  }
}

class _MovieFilterContent extends StatelessWidget {
  final bool isRecentOnly;
  final Function(bool) onRecentChange;

  const _MovieFilterContent({
    required this.isRecentOnly,
    required this.onRecentChange,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: ToggleButton(
        text: l10n.filterRecent,
        isActive: isRecentOnly,
        onCheckedChange: onRecentChange,
        scale: 0.7,
      ),
    );
  }
}

class _CustomFilterChip extends StatelessWidget {
  final bool selected;
  final String text;
  final VoidCallback onClick;

  const _CustomFilterChip({
    required this.selected,
    required this.text,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: selected ? AppColor.btnPrimary : Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: AppText.medium_12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}