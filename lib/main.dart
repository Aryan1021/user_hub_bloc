import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/user/user_bloc.dart';
import 'repositories/user_repository.dart';
import 'screens/user_list_screen.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'User Hub BLoC',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          home: RepositoryProvider(
            create: (_) => UserRepository(),
            child: BlocProvider(
              create: (context) => UserBloc(userRepository: context.read<UserRepository>()),
              child: const UserListScreen(),
            ),
          ),
        );
      },
    );
  }
}
