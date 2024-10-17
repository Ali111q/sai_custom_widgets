import '../validator_rule.dart';

class MinIntRule extends ValidatorRule {
  final int length;
  @override
  MinIntRule(this.length, [String? errorMessage]) : super(errorMessage);

  @override
  String? isValid(String? value) {
    late int v;
    try {
      v = int.parse(value ?? '0');
      return v >= length ? null : getMessage;
    } catch (e) {
      return getMessage;
    }
  }

  @override
  Map<String, String> get defaultMessage => {
        'en': 'The number must be greater than $length',
        'ar': 'العدد يجب ان لا يكون اقل من $length',
      };
}
