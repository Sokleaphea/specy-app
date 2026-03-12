import 'package:flutter/material.dart';
import 'package:specy_app/ui/widgets/favorite_button.dart';

class SpeciesTile extends StatelessWidget {
  final int id;
  final String scientificName;
  final String commonName;
  final String countryName;
  final String countryEmoji;
  final String image;
  final VoidCallback? onSpeciesTap;
  final VoidCallback? onCountryTap;
  const SpeciesTile({
    super.key,
    required this.id,
    required this.scientificName,
    required this.commonName,
    required this.countryName,
    required this.countryEmoji,
    required this.image,
    this.onSpeciesTap,
    this.onCountryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(110, 227, 226, 226),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: Colors.grey
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('# $id', style: TextStyle(fontSize: 14)),
                GestureDetector(
                  onTap: onSpeciesTap,
                  child: Text(
                    commonName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                SizedBox(height: 4),
                Text(scientificName, style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(countryEmoji, style: TextStyle(fontSize: 14)),
                    Expanded(
                      child: GestureDetector(
                        onTap: onCountryTap,
                        child: Text(
                          countryName,
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topRight,
              children: [
                GestureDetector(
                  onTap: onSpeciesTap,
                  child: ClipOval(
                    child: Image.network(
                      image,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: -10,
                  right: 1,
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: FavoriteButton(speciesId: id, size: 25),
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
