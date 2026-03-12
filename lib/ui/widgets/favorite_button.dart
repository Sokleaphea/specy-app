import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:specy_app/ui/view_model/favorite_view_model.dart';

class FavoriteButton extends StatefulWidget {
  final int speciesId;
  final double size;
  const FavoriteButton({
    super.key,
    required this.speciesId,
    required this.size,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    final favoriteVm = context.watch<FavoriteViewModel>();
    final isFavorite = favoriteVm.favoriteSpecies.contains(widget.speciesId);
    return GestureDetector(
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
        color: isFavorite ? Colors.red : Colors.black,
        size: widget.size,
      ),
      onTap: () => favoriteVm.toggleFavorite(widget.speciesId),
    );
  }
}
