import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nanny_core/nanny_core.dart';

class TextMasks {
  static MaskTextInputFormatter phoneMask() => MaskTextInputFormatter(
        mask: '+ 7 (###) ###-##-##',
        filter: {'#': RegExp(r'[0-9]')},
      );

  static MaskTextInputFormatter digitsMask(int max) {
    String mask = "";
    for (int i = 0; i < max; i++) {
      mask += '#';
    }
    return MaskTextInputFormatter(
      mask: mask,
      filter: {'#': RegExp(r'[0-9]')},
    );
  }
}

class NannyUpperFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

class NannyDateFormatter extends TextInputFormatter {
  NannyDateFormatter({required this.checkYear});

  String _text = "";
  String get text => _text;

  final bool checkYear;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    _text = newValue.text;
    if (_text.contains('.')) _text = _text.replaceAll('.', '');
    int length = _text.length;

    if (length > 4) {
      _text =
          "${_text.substring(0, 2)}.${_text.substring(2, 4)}.${_text.substring(4)}";
    } else if (length > 2) {
      _text = "${_text.substring(0, 2)}.${_text.substring(2)}";
    }

    if (text.isEmpty) return newValue;

    var parts = NannyUtils.retreiveDateParts(_text);

    switch (parts.length) {
      case 1:
        if (parts.first > 31) return oldValue;
        break;

      case 2:
        if (parts[1] > 12) return oldValue;
        break;

      case 3:
        if (checkYear && parts[2] > DateTime.now().year) return oldValue;
        break;
    }

    return TextEditingValue(text: _text);
  }
}
