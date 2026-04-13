import 'package:equatable/equatable.dart';

class UserQuestEntity extends Equatable {
  const UserQuestEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.progressPercent,
  });

  final int id;
  final String title;
  final String imageUrl;
  final int progressPercent;

  @override
  List<Object?> get props => [id, title, imageUrl, progressPercent];
}
