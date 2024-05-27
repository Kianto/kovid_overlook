abstract class DataNumberConverter {
  static String convert(num number) {
    String res = number.toStringAsFixed(0);

    int index = res.length;
    while (index > 3) {
      index -= 3;
      res = res.substring(0, index) + ' ' + res.substring(index);
    }

    return res;
  }
}
