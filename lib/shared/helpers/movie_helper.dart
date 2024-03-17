class MovieHelper {
  static String formatDuration(String durationString) {
    if (durationString.isEmpty) return 'N/A';
    String cleanedString = durationString.replaceAll("PT", "");
    int minutes = int.parse(cleanedString.replaceAll("M", ""));
    int hours = minutes ~/ 60;
    minutes = minutes % 60;
    if (hours == 0) return '${minutes}m';
    return '${hours}h ${minutes}m';
  }
}
