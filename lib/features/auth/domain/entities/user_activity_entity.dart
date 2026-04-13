import 'package:equatable/equatable.dart';

class UserActivityEntity extends Equatable {
  const UserActivityEntity({
    required this.id,
    required this.title,
    required this.timeLabel,
  });

  final int id;
  final String title;
  final String timeLabel;

  @override
  List<Object?> get props => [id, title, timeLabel];
}
