bool isAge18AndUp(DateTime birthDate) {
  return DateTime.now().difference(birthDate).inDays / 365.floor() >= 18;
}