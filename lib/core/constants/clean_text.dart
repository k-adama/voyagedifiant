import 'package:diacritic/diacritic.dart';

String cleanText(String input) {
  return removeDiacritics(input)
      .replaceAll('→', '-')
      .replaceAll('✓', 'v');
}
