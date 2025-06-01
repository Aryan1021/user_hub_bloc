import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';
import '../../repositories/user_repository.dart';
import '../../models/user.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  static const int _limit = 10;
  int _skip = 0;
  String _searchQuery = '';

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<SearchUsers>(_onSearchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    try {
      if (event.isRefresh) {
        _skip = 0;
        final users = await userRepository.fetchUsers(limit: _limit, skip: _skip, search: _searchQuery);
        emit(UserLoaded(users: users, hasReachedMax: users.length < _limit));
      } else if (state is UserLoaded) {
        final currentState = state as UserLoaded;
        _skip += _limit;
        final users = await userRepository.fetchUsers(limit: _limit, skip: _skip, search: _searchQuery);
        final allUsers = List<User>.from(currentState.users)..addAll(users);
        emit(UserLoaded(users: allUsers, hasReachedMax: users.length < _limit));
      } else {
        emit(UserLoading());
        _skip = 0;
        final users = await userRepository.fetchUsers(limit: _limit, skip: _skip, search: _searchQuery);
        emit(UserLoaded(users: users, hasReachedMax: users.length < _limit));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onSearchUsers(SearchUsers event, Emitter<UserState> emit) async {
    _searchQuery = event.query;
    _skip = 0;
    emit(UserLoading());
    try {
      final users = await userRepository.fetchUsers(limit: _limit, skip: _skip, search: _searchQuery);
      emit(UserLoaded(users: users, hasReachedMax: users.length < _limit));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
