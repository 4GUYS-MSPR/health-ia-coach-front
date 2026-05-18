
String getGenderDisplayLabel(String? rawValue) {
  if (rawValue == null) return '';

  switch (rawValue.toUpperCase()) { 
    case 'MALE':
      return 'Homme';
    case 'FEMALE':
      return 'Femme';
    case 'PREMIUMPLUS':
      return 'Premium Plus';
    default:
      return rawValue; 
  }
}

int convertHeight(double? value){
  if (value == null) return 0; 
  int convertedValue = (value * 10).round();
  return convertedValue;
}