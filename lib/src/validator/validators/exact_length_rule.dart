import '../validator_rule.dart';

class ExactLengthRule extends ValidatorRule {
  final int length;
  @override
  ExactLengthRule(this.length, [String? errorMessage]) : super(errorMessage);

  @override
  String? isValid(String? value) {
    return value == null || value.length == length ? null : getMessage;
  }

  @override
  Map<String, String> get defaultMessage => {
        'en': 'field length must be equal to $length',
        'ar': 'يجب أن يكون طول الحقل مساويًا لـ $length',
      };
}
