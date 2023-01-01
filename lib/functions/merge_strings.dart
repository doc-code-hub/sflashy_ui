import 'dart:math';
import 'dart:ui';

String mergeStrings(String str1, String str2, double aniPoint) {
  List<String> chars1 = str1.split('');
  List<String> chars2 = str2.split('');
  List<String> merged = [];
  int actualLength = lerpDouble(str1.length, str2.length, aniPoint)!.round();
  List<int> indices = [];
  for (int i = 0; i < actualLength; i++) {
    indices.add(i);
  }
  Random random = Random();
  for (int i = 0; i < indices.length; i++) {
    String char = '';
    if (aniPoint == 0) {
      char = chars1[indices[i]];
    } else if (aniPoint == 1) {
      char = chars2[indices[i]];
    } else {
      if (random.nextDouble() > aniPoint) {
        try {
          char = chars1[indices[i]];
        } catch (ex) {
          char = chars2[indices[i]];
        }
      } else {
        try {
          char = chars2[indices[i]];
        } catch (ex) {
          char = chars1[indices[i]];
        }
      }
    }
    merged.add(char);
  }
  return merged.join('');
}
