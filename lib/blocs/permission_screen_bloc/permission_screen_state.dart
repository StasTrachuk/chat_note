part of 'permission_screen_cubit.dart';

sealed class PermissionScreenState {}

final class PermissionScreenInitial extends PermissionScreenState {}

final class PermissionScreenLoading extends PermissionScreenState {}

final class PermissionScreenLoaded extends PermissionScreenState {
  final bool strorageIsGranded;
  final bool mediaIsGranded;

  PermissionScreenLoaded({
    required this.strorageIsGranded,
    required this.mediaIsGranded,
  });
}

final class PermissionScreenError extends PermissionScreenState {
  final String error;

  PermissionScreenError({required this.error});
}
