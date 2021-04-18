//melakukan pemisahan ketika Stringlebih dari satu
List<String> splitString(String imageUrls) {
  List<String> result = imageUrls.split(';');
  print(result);
  return result;
}
