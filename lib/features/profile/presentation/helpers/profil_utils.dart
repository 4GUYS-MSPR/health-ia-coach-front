
String getGenderDisplayLabel(String? rawValue) {
  if (rawValue == null) return '';

  switch (rawValue.toUpperCase()) { 
    case 'MALE':
      return 'Homme';
    case 'FEMALE':
      return 'Femme';
    case 'NOT SPECIFIED':
      return 'Non précisé';
    default:
      return rawValue; 
  }
}

String getLevelDisplayLabel(String? rawValue) {
  if (rawValue == null) return '';

  switch (rawValue.toUpperCase()) { 
    case 'BEGINNER':
      return 'Débutant';
    case 'INTERMEDIATE':
      return 'Intermédiare';
    case 'EXPERT':
      return 'Confirmé';
    default:
      return rawValue; 
  }
}

String getSubscriptionDisplayLabel(String? rawValue) {
  if (rawValue == null) return '';

  switch (rawValue.toUpperCase()) { 
    case 'FREE':
      return 'Gratuit';
    case 'PREMIUM':
      return 'Premium';
    case 'PREMIUM PLUS':
      return 'Premium +';
    default:
      return rawValue; 
  }
}

int convertHeight(double? value){
  if (value == null) return 0; 
  int convertedValue = (value * 10).round();
  return convertedValue;
}