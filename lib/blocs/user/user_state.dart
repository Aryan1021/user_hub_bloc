import 'package:equatable/equatable.dart';
import '../../models/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  final bool hasReachedMax;

  const UserLoaded({required this.users, required this.hasReachedMax});

  UserLoaded copyWith({List<User>? users, bool? hasReachedMax}) {
    return UserLoaded(
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [users, hasReachedMax];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
