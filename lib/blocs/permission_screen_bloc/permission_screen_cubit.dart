import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

part 'permission_screen_state.dart';

class PermissionScreenCubit extends Cubit<PermissionScreenState> {
  bool _hasStoragePermission = false;
  bool _hasMediaPermission = false;

  PermissionScreenCubit() : super(PermissionScreenInitial()) {
    init();
  }

  void init() async {
    await storageRequest();
    await mediaRequest();
  }

  Future<void> storageRequest() async {
    emit(PermissionScreenLoading());
    try {
      final storageStatus = Platform.isAndroid
          ? await Permission.manageExternalStorage.request()
          : await Permission.storage.request();

      _hasStoragePermission = storageStatus.isGranted ? true : false;

      emit(
        PermissionScreenLoaded(
          strorageIsGranded: _hasStoragePermission,
          mediaIsGranded: _hasMediaPermission,
        ),
      );
    } catch (e) {
      emit(PermissionScreenError(error: e.toString()));
    }
  }

  Future<void> mediaRequest() async {
    emit(PermissionScreenLoading());
    try {
      if (Platform.isAndroid) {
        final PermissionState storageStatus;
        storageStatus = await PhotoManager.requestPermissionExtend();
        _hasMediaPermission = storageStatus.hasAccess;
      } else {
        _hasMediaPermission = true;
      }
      emit(
        PermissionScreenLoaded(
          strorageIsGranded: _hasStoragePermission,
          mediaIsGranded: _hasMediaPermission,
        ),
      );
    } catch (e) {
      emit(PermissionScreenError(error: e.toString()));
    }
  }
}
