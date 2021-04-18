//melakukan pemisahan ketika image lebih dari satu
List<String> splitImage(String imageUrls) {
  List<String> result = imageUrls.split(';');
  print(result);
  return result;
}
