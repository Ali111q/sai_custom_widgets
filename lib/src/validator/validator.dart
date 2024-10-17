import 'validator_rule.dart';

class Validator {
  Validator._();

  static String? validate(String? value, List<ValidatorRule> rules) {
    for (var rule in rules) {
      var msg = rule.isValid(value);
      if (msg != null) {
        return msg;
      }
    }
    return null;
  }
}
