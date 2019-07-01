bool isPHPhone(String phone) {
  String p = r'^(09|\+639)\d{9}$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(phone);
}
