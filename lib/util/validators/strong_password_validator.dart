bool isStrongPassword(String password) {
  String p = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(password);
}
