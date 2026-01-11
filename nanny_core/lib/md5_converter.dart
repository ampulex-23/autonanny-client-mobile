import 'package:crypto/crypto.dart';

class Md5Converter {
  static String convert(String text) => md5.convert(text.codeUnits).toString();
}