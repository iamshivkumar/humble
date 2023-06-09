import 'package:email_validator/email_validator.dart';


class Validators {
  static String? required(String? v) =>
      v == null || v.isEmpty ? "Required" : null;

  
  static String? password(String? v) => required(v)?? (v!.length < 6 ? "Password must be at least 6 characters" : null);

  static String? email(String? v) =>
      required(v) ??
      (!EmailValidator.validate(v!) ? "Enter valid email" : null);

  static String? intAmount(String? v) =>
      required(v) ?? (int.tryParse(v!) == null ? "Enter valid amount!" : null);

  static String? intAmountExcept0(String? v) =>
      required(v) ??
      (int.tryParse(v!) == null || int.parse(v) == 0
          ? "Enter valid amount!"
          : null);

  static String? phone(String? v) =>
      required(v) ?? (v!.length != 10 ? "Enter valid phone number" : null);
}
