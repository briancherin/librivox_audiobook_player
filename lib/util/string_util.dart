
class StringUtil {
  static String getTimestampFromSeconds(double totalSeconds) {
    if (totalSeconds != null) {
      int totalSecondsRounded = (totalSeconds ~/ 1);
      int seconds = totalSecondsRounded % 60;
      int minutes = ((totalSecondsRounded - seconds) ~/ 60) % 60;
      int hours = (totalSecondsRounded - seconds - (minutes * 60)) ~/ 3600;

      return "${padNumber(hours)}:${padNumber(minutes)}:${padNumber(seconds)}";
    }
    return "?";
  }

  static String padNumber(int num) {
    return num < 10 ? "0$num" : "$num";
  }

}