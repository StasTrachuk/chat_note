import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:home_work/models/chat.dart';
import 'package:home_work/screens/create_screen/create_screen.dart';
import 'package:home_work/screens/home_screen/home_screen.dart';
import 'package:home_work/screens/local_auth_screen/local_auth_screen.dart';
import 'package:home_work/screens/permission_request_screen/permission_request_screen.dart';
import 'package:home_work/screens/settings_screen/settings_screen.dart';
import 'package:home_work/widgets/dependency_injection.dart';
import 'package:home_work/settings/colors.dart';
import 'package:home_work/widgets/theme_inherited.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_work/blocs/home_screen_bloc/home_screen_bloc.dart';
import 'blocs/app_bloc/app_bloc.dart';
import 'blocs/app_bloc/app_state.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: AppColors.white),
  );
  setUpGetIt();
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AppCubit(),
        ),
        BlocProvider(
          create: (_) => GetIt.instance.get<HomeScreenCubit>(),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (BuildContext context, state) {
          return ThemeInherited(
            appTheme: state.theme,
            child: MaterialApp(
              initialRoute: '/permission_request',
              onGenerateRoute: (settings) => switch (settings.name) {
                '/home' => MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                '/edit_chat_screen' => MaterialPageRoute(
                    builder: (context) => CreateScreen.edit(
                      editedChat: settings.arguments as Chat,
                    ),
                  ),
                '/create_screen' => MaterialPageRoute(
                    builder: (context) => const CreateScreen.newChat(),
                  ),
                '/settings_screen' => MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                // '/local_auth_screen' => MaterialPageRoute(
                //     builder: (context) => const LocalAuthScreen(),
                //   ),
                '/permission_request' => MaterialPageRoute(
                    builder: (context) => const PermissionRequestScreen(),
                  ),
                _ => null
              },
              debugShowCheckedModeBanner: false,
              theme: state.theme.themeData,
              home: const HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
