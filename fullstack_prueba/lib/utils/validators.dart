class Validators {
  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName es requerido";
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return "La fecha de nacimiento es requerida";
    }
    try {
      final date = DateTime.parse(value);
      if (date.isAfter(DateTime.now())) {
        return "La fecha no puede ser en el futuro";
      }
    } catch (_) {
      return "Formato de fecha inválido (YYYY-MM-DD)";
    }
    return null;
  }
}
