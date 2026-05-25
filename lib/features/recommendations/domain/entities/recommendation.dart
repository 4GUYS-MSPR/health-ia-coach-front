import 'package:equatable/equatable.dart';

class Recommendation extends Equatable {
  final String text;

  const Recommendation({
    required this.text,
  });

  @override
  List<Object?> get props => [
    text,
  ];
}
