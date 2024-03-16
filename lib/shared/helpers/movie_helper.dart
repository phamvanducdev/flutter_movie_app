class MovieHelper {
  static Duration? parseDuration(String durationString) {
    if (durationString.isEmpty) return null;

    // Removing the "PT" prefix from the duration string
    String cleanedString = durationString.replaceAll("PT", "");

    // Extracting the minutes part
    int minutes = int.parse(cleanedString.replaceAll("M", ""));

    return Duration(minutes: minutes);
  }

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
