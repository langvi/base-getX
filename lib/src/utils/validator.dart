import 'package:validators/validators.dart';

bool isEmailInvalid(String email) => !isEmail(email);
// validate so dien thoai o VN
bool isPhoneVietNamValid(String value) {
  late RegExp rex;
  if (value.length > 2 && value.substring(0, 2) == '84') {
    rex = RegExp(r'(84|0[3|5|7|8|9])+([0-9]{9})\b');
  } else {
    rex = RegExp(r'(84|0[3|5|7|8|9])+([0-9]{8})\b');
  }
  String? result = rex.firstMatch(value)?.input;
  return result != null;
}

bool isSamePassword(String password, String rePassword) {
  return password == rePassword;
}
