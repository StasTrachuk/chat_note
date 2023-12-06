part of 'image_picker_bloc.dart';

@immutable
sealed class ImagePickerState {}

final class ImagePickerInitial extends ImagePickerState {}

final class ImagePickerLoading extends ImagePickerState {}

final class ImagePickerLoaded extends ImagePickerState {
  final List<Uint8List> images;

  ImagePickerLoaded({required this.images});
}

final class ImagePickerError extends ImagePickerState {
  final String error;
  ImagePickerError({required this.error});
}
