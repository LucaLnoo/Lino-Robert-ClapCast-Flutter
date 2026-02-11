import 'package:flutter/material.dart';
import '../../ressources/app_color.dart';
import 'imageApi.dart';

class MediaCardButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onClick;

  const MediaCardButton({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    // 1. On définit une largeur fixe pour toute la carte
    return SizedBox(
      width: 120.0,
      // Pas de height fixe ici pour éviter les dépassements si le texte est long,
      // on laisse la Column gérer la hauteur verticale.
      child: Column(
        mainAxisSize: MainAxisSize.min, // Prend le minimum de place nécessaire
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // 2. L'image (Partie cliquable principale)
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12.0),
            clipBehavior: Clip.hardEdge, // Coupe l'image si elle dépasse les bords arrondis
            child: InkWell(
              onTap: onClick,
              child: SizedBox(
                height: 160.0, // HAUTEUR FIXE pour l'image
                width: double.infinity, // Prend toute la largeur du parent (120.0)
                child: ImageApi(
                  imagePath: imagePath,
                  width: 500, // Résolution de l'image demandée à l'API
                  // Assure-toi que ton widget ImageApi gère bien le BoxFit.cover
                  // Si ImageApi est juste un wrapper, il doit remplir ce SizedBox
                ),
              ),
            ),
          ),

          const SizedBox(height: 8.0), // Espace entre image et texte

          // 3. Le Texte (Partie descriptive)
          // On le sort du InkWell pour que le clic sur le texte soit optionnel,
          // ou on peut englober tout le widget dans un GestureDetector si tu préfères.
          GestureDetector(
            onTap: onClick,
            child: Text(
              text,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13.0, // Un peu plus petit pour bien tenir
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ToggleButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final ValueChanged<bool> onCheckedChange;
  final double scale;

  const ToggleButton({
    super.key,
    required this.text,
    required this.isActive,
    required this.onCheckedChange,
    this.scale = 0.7,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onCheckedChange(!isActive),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: AppColor.appContrast,
                  fontSize: 16.0,
                ),
              ),

              Transform.scale(
                scale: scale,
                child: Switch(
                  value: isActive,
                  onChanged: onCheckedChange,
                  activeColor: AppColor.btnPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}