import '../validator_rule.dart';

class MinLengthRule extends ValidatorRule {
  final int length;
  @override
  MinLengthRule(this.length, [String? errorMessage]) : super(errorMessage);

  @override
  String? isValid(String? value) {
    return value == null || value.length >= length ? null : getMessage;
  }

  @override
  Map<String, String> get defaultMessage => {
        'en': 'field length must be equal or greater than $length',
        'ar': 'يجب أن يكون طول الحقل مساوي او اكثر من $length',
      };
}
