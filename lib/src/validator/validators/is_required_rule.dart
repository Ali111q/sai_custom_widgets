import '../validator_rule.dart';

class IsRequiredRule extends ValidatorRule {
  @override
  IsRequiredRule([super.errorMessage]);

  @override
  String? isValid(String? value) {
    return value == null || value.trim().isNotEmpty ? null : getMessage;
  }

  @override
  Map<String, String> get defaultMessage => {
        'en': 'field is required',
        'ar': 'هذا الحقل مطلوب',
      };
}
