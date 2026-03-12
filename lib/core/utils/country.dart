import 'package:country_codes/country_codes.dart';

String getCountryName(String code) {
  try {
    final country = CountryCodes.countryCodes().firstWhere(
      (c) => c.alpha2Code == code.toUpperCase(),
    );
    return country.name!;
  } catch (e) {
    return code;
  }
}

String getCountryEmoji(String isoCode) {
  final flagOffset = 0x1F1E6;
  final asciiOffset = 65;
  final code = isoCode.toUpperCase();
  if (code.length != 2) return '';
  final firstChar = String.fromCharCode(
    flagOffset + code.codeUnitAt(0) - asciiOffset,
  );
  final secondChar = String.fromCharCode(
    flagOffset + code.codeUnitAt(1) - asciiOffset,
  );
  return '$firstChar$secondChar';
}

String getSpeciesImage(int id) {
  return "https://aes.shenlu.me/_next/image?url=/images/$id.jpg&w=256&q=75";
}
