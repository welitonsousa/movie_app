enum Countries {
  BR,
  US,
  PT,
  CA,
  ES;

  String get completeName {
    if (BR == this) return "Brasil";
    if (US == this) return "Estados Unidos";
    if (PT == this) return "Portugal";
    if (CA == this) return "Canada";
    if (ES == this) return "Espanha";
    return "Brasil";
  }
}
