import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_work/blocs/auth_bloc/auth_bloc_cubit.dart';
import 'package:home_work/settings/context_theme.dart';
import 'package:home_work/widgets/loader.dart';
import 'package:home_work/widgets/secondary_button.dart';

class LocalAuthScreen extends StatefulWidget {
  const LocalAuthScreen({super.key});

  @override
  State<LocalAuthScreen> createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<AuthCubit>(),
      child: Scaffold(
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(30),
              alignment: Alignment.bottomCenter,
              color: context.theme.backgroundPrimaryColor,
              child: Center(
                child: switch (state) {
                  AuthInitial() => const SizedBox(),
                  AuthLoading() => const Loader(),
                  AuthLoaded(
                    :final isAuthComplete,
                    :final isBiometricsAvailable,
                  ) =>
                    (isBiometricsAvailable == false & isAuthComplete)
                        ? SecondaryButton(
                            onPressed: () => Navigator.pushNamed(
                                context, '/permission_request'),
                            text: "Next",
                          )
                        : SecondaryButton(
                            onPressed: () =>
                                context.read<AuthCubit>().authenticate(),
                            text: 'Try Again',
                          ),
                  AuthError(:final error) => Text(
                      error,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,

                      ),
                    )
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
