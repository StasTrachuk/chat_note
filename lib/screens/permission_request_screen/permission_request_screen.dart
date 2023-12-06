import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_work/blocs/permission_screen_bloc/permission_screen_cubit.dart';
import 'package:home_work/settings/context_theme.dart';
import 'package:home_work/widgets/loader.dart';
import 'package:home_work/widgets/primary_button.dart';
import 'package:home_work/widgets/secondary_button.dart';

class PermissionRequestScreen extends StatelessWidget {
  const PermissionRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PermissionScreenCubit(),
      child: Scaffold(
        body: Container(
          color: context.theme.backgroundPrimaryColor,
          child: BlocBuilder<PermissionScreenCubit, PermissionScreenState>(
            builder: (context, state) {
              return switch (state) {
                PermissionScreenInitial() => const SizedBox(),
                PermissionScreenLoading() => const Loader(),
                PermissionScreenLoaded(
                  :final mediaIsGranded,
                  :final strorageIsGranded,
                ) =>
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PrimaryButton(
                            withBorder: true,
                            onPressed: () => context
                                .read<PermissionScreenCubit>()
                                .storageRequest(),
                            text: 'Allow accses to storage.',
                          ),
                          const SizedBox(width: 10),
                          PermissionCheckBox(
                            storageIsGranded: strorageIsGranded,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PrimaryButton(
                            withBorder: true,
                            onPressed: () => context
                                .read<PermissionScreenCubit>()
                                .mediaRequest(),
                            text: 'Allow accses to Photo.',
                          ),
                          const SizedBox(width: 10),
                          PermissionCheckBox(
                            storageIsGranded: strorageIsGranded,
                          ),
                        ],
                      ),
                      const SizedBox(height: 100),
                      SecondaryButton(
                        isActive: mediaIsGranded & strorageIsGranded,
                        onPressed: () => Navigator.pushNamed(context, '/home'),
                        text: 'Next',
                      ),
                    ],
                  ),
                PermissionScreenError(:final error) => Center(
                    child: Text(error),
                  )
              };
            },
          ),
        ),
      ),
    );
  }
}

class PermissionCheckBox extends StatelessWidget {
  final bool storageIsGranded;

  const PermissionCheckBox({super.key, required this.storageIsGranded});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.theme.buttonNotActiveColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.check,
          color: storageIsGranded
              ? context.theme.iconSecondaryColor
              : context.theme.iconSecondaryColor,
        ),
      ),
    );
  }
}
