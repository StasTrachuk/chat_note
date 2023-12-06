import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_work/blocs/app_bloc/app_bloc.dart';
import 'package:home_work/blocs/settings_screen_bloc/settings_cubit.dart';
import 'package:home_work/screens/settings_screen/settings_item.dart';
import 'package:home_work/settings/context_theme.dart';
import 'package:home_work/settings/themes.dart';
import 'package:home_work/widgets/loader.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('General'),
      ),
      body: BlocProvider(
        create: (context) => GetIt.instance.get<SettingsScreenCubit>(),
        child: BlocBuilder<SettingsScreenCubit, SettingsState>(
          builder: (context, state) {
            return switch (state) {
              SettingsInitial() => const SizedBox(),
              SettingsLoading() => const Loader(),
              SettingsLoaded(
                :final messageSetting,
                :final dateSetting,
                :final authSetting,
              ) =>
                ListView(
                  padding: const EdgeInsets.all(10),
                  children: [
                    SettingsItem(
                      value: dateSetting,
                      text: 'Date on center',
                      onToggle: (value) => context
                          .read<SettingsScreenCubit>()
                          .setDateSetting(value),
                    ),
                    const SizedBox(height: 5),
                    SettingsItem(
                      value: messageSetting,
                      text: 'Messages on right',
                      onToggle: (value) => context
                          .read<SettingsScreenCubit>()
                          .setMessageSetting(value),
                    ),
                    const SizedBox(height: 5),
                    SettingsItem(
                      value: context.theme == darkTheme,
                      text: 'Dark theme',
                      onToggle: (value) => context.read<AppCubit>().setTheme(),
                    ),
                    const SizedBox(height: 5),
                    SettingsItem(
                      value: authSetting,
                      text: 'Authentication',
                      onToggle: (value) => context
                          .read<SettingsScreenCubit>()
                          .setAuthSetting(value),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              SettingsError(:final error) => Center(
                  child: Text(error),
                ),
            };
          },
        ),
      ),
    );
  }
}
