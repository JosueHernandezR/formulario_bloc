//Definir si es un numero o no

bool isNumeric(String s) {
  if (s.isEmpty) return false;
  final n = num.parse(s);

  return (n == null) ? false : true;
}
