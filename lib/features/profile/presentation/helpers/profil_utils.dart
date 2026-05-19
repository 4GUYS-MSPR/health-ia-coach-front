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

int convertGenderToInt(String? value) {
  switch (value) {
    case 'MALE':
      return 6;
    case 'FEMALE':
      return 5;
    case 'NOT SPECIFIED':
      return 8;
    default:
      return 0;
  }
}

int convertLevelToInt(String? value) {
  switch (value) {
    case 'BEGINNER':
      return 1;
    case 'INTERMEDIATE':
      return 2;
    case 'EXPERT':
      return 3;
    default:
      return 0;
  }
}

int convertSubscriptionToInt(String? value) {
  switch (value) {
    case 'FREE':
      return 1;
    case 'PREMIUM':
      return 2;
    case 'PREMIUM PLUS':
      return 4;
    default:
      return 0;
  }
}

int convertHeight(double? value) {
  if (value == null) return 0;
  int convertedValue = (value * 10).round();
  return convertedValue;
}
