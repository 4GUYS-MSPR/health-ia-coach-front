enum PublicationType {
  image(1, 'Photo'),
  video(2, 'Vidéo');

  final int value;  
  final String label;

  const PublicationType(this.value, this.label);

  static PublicationType fromValue(int value) {
    return PublicationType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => PublicationType.image,
    );
  }
}