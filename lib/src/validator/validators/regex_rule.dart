import '../validator_rule.dart';

class RegexRule extends ValidatorRule {
  final String pattern;

  @override
  RegexRule(this.pattern, [String? errorMessage]) : super(errorMessage);

  @override
  String? isValid(String? value) {
    return value == null || RegExp(pattern).hasMatch(value) ? null : getMessage;
  }

  @override
  Map<String, String> get defaultMessage => {
        'en': 'invalid input',
        'ar': 'ادخال خاطئ',
      };
}
