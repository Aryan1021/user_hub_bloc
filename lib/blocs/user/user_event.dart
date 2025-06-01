import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class FetchUsers extends UserEvent {
  final bool isRefresh;

  const FetchUsers({this.isRefresh = false});

  @override
  List<Object?> get props => [isRefresh];
}

class SearchUsers extends UserEvent {
  final String query;

  const SearchUsers(this.query);

  @override
  List<Object?> get props => [query];
}
