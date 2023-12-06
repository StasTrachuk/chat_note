import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:home_work/core/message_repository.dart';
import 'package:home_work/models/message.dart';
import 'package:photo_manager/photo_manager.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  final MessageRepository repository;
  final int chatId;
  List<AssetEntity> _recentAssets = [];
  List<Uint8List> _recentUint8List = [];

  ImagePickerCubit({
    required this.chatId,
    required this.repository,
  }) : super(ImagePickerInitial()) {
    _getImages();
  }

  Future<void> _getImages() async {
    emit(ImagePickerLoading());
    try {
      final albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
      );

      if (albums.isEmpty) {
        emit(ImagePickerError(error: 'No photo'));
      } else {
        _recentAssets = await albums[0].getAssetListRange(
          start: 0,
          end: 40,
        );

        _recentUint8List = await _assetToUint8List(_recentAssets);

        emit(ImagePickerLoaded(images: _recentUint8List));
      }
    } catch (e) {
      emit(ImagePickerError(error: e.toString()));
    }
  }

  Future<void> sendImage({
    required String time,
    required String date,
    required int imageIndex,
  }) async {
    var image = await _recentAssets[imageIndex].thumbnailDataWithSize(
      const ThumbnailSize(500, 500),
    );

    repository.insertMessage(
      message: Message(
        time: time,
        date: date,
        chatId: chatId,
        image: image,
      ),
    );
  }

  Future<List<Uint8List>> _assetToUint8List(
    List<AssetEntity> assetList,
  ) async {
    final List<Uint8List> thumbnails = [];

    for (final asset in assetList) {
      final thumbnailData = await asset.thumbnailDataWithSize(
        const ThumbnailSize(220, 220),
      );

      if (thumbnailData != null) thumbnails.add(thumbnailData);
    }

    return thumbnails;
  }
}
