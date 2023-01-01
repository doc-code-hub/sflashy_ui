import 'dart:math';
import 'dart:ui';

/// Merge two string by a give animation point between 0 and 1 (aka the merge amount).
/// Example:
/// `mergeStrings(firstString, secondString, 0.35)`
String mergeStrings(
  /// First string
  String str1,

  /// Second string
  String str2,

  /// Animation point between 0 and 1
  double animationPoint,
) {
  // First string chars
  List<String> chars1 = str1.split('');
  // Second string chars
  List<String> chars2 = str2.split('');
  // Merge characters list
  List<String> merged = [];

  // Compute the actual length of the string
  // Examples
  // 0 = str1.length
  // 0.5 = (str1.length + str2.length) / 2
  // 1 = str2.length
  int actualLength =
      lerpDouble(str1.length, str2.length, animationPoint)!.round();

  Random random = Random();

  // Iterate the current length of the string
  for (int i = 0; i < actualLength; i++) {
    // Iteration char result
    String char = '';

    if (animationPoint == 0) {
      // With `aniPoint = 0` return str1
      char = chars1[i];
    } else if (animationPoint == 1) {
      // With `aniPoint = 1` return str2
      char = chars2[i];
    } else {
      // With `aniPoint > 0 && aniPoint < 1` compute probability and pick a string

      if (random.nextDouble() > animationPoint) {
        // If the random number is higher than the aniPoint
        // then first try to get the char from `str1`
        try {
          char = chars1[i];
        } catch (ex) {
          // if `str1` has not enought chars, fallback on `str2`
          char = chars2[i];
        }
      } else {
        // If the random number is lower o equal than the aniPoint
        // then first try to get the char from `str2`
        try {
          char = chars2[i];
        } catch (ex) {
          // if `str2` has not enought chars, fallback on `str1`
          char = chars1[i];
        }
      }
    }
    // Add the picked char to the final list
    merged.add(char);
  }

  // Build the final string
  return merged.join('');
}
