class ImageHelper {
  static String? extractFileId(String url) {
    try {
      Uri uri = Uri.parse(url);
      // Check if 'id' parameter exists
      if (uri.queryParameters.containsKey('id')) {
        return uri.queryParameters['id'];
      }

      // Handle other formats like: https://drive.google.com/file/d/<id>/view
      final regex = RegExp(r'/d/([a-zA-Z0-9_-]+)');
      final match = regex.firstMatch(uri.path);
      if (match != null) {
        return match.group(1);
      }
    } catch (e) {
      print("Invalid URL: $e");
    }
    return null;
  }

}