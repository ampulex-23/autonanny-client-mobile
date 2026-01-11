class CardChecker {
  static bool validateLuhnCard(String input) {
    if (input.isEmpty) {
      return false;
    }

    if (input.length < 16) { // No need to even proceed with the validation if it's less than 8 characters
      return false;
    }

    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(input[length - i - 1]);

      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) return true;
    return false;
  }

  static bool validateExpDate(String exp) {
    var splitedExp = exp.split('/');
    if(splitedExp.length < 2) return false;

    String year = DateTime.now().year.toString();
    int checkYear = int.parse(year[0] + year[1] + splitedExp[1]);

    if(checkYear < DateTime.now().year) return false;
    return true;
  }
}