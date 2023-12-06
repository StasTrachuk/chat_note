import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_work/blocs/image_picker_bloc/image_picker_bloc.dart';
import 'package:home_work/screens/chat_screen/image_picker_sheet/image_preview.dart';
import 'package:home_work/settings/context_theme.dart';
import 'package:home_work/widgets/formatter.dart';
import 'package:home_work/widgets/primary_button.dart';

class ImagePickerSheet extends StatefulWidget {
  final int chatId;
  final ScrollController controller;

  const ImagePickerSheet({
    super.key,
    required this.chatId,
    required this.controller,
  });

  @override
  State<ImagePickerSheet> createState() => _ImagePickerSheetState();
}

class _ImagePickerSheetState extends State<ImagePickerSheet> {
  int? _selectedImageIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImagePickerCubit>(
      create: (context) => GetIt.instance.get(param1: widget.chatId),
      child: BlocBuilder<ImagePickerCubit, ImagePickerState>(
        builder: (context, state) {
          return SingleChildScrollView(
            controller: widget.controller,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Recent',
                      style: TextStyle(
                        fontSize: 18,
                        color: context.theme.textSecondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: context.theme.borderNotActiveColor,
                  ),
                  Expanded(
                    child: switch (state) {
                      ImagePickerInitial() => const SizedBox(),
                      ImagePickerLoading() => GridView.count(
                          crossAxisCount: 4,
                          children: List.generate(
                            20,
                            (index) => Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                color: context.theme.buttonNotActiveColor,
                              ),
                            ),
                          ),
                        ),
                      ImagePickerLoaded(:final images) => Stack(
                          children: [
                            GridView.count(
                              padding: const EdgeInsets.only(top: 4),
                              crossAxisCount: 4,
                              controller: widget.controller,
                              children: List.generate(
                                images.length,
                                (index) => GestureDetector(
                                  onTap: () => setState(
                                    () => _selectedImageIndex = index,
                                  ),
                                  child: ImagePreview(
                                    asset: images[index],
                                    isSelect: _selectedImageIndex == index,
                                  ),
                                ),
                              ),
                            ),
                            if (_selectedImageIndex != null)
                              Align(
                                alignment: const AlignmentDirectional(0, 0.85),
                                child: PrimaryButton(
                                  onPressed: () => _sendImage(context),
                                  text: 'Send',
                                ),
                              ),
                          ],
                        ),
                      ImagePickerError(:final error) => Center(
                          child: Text(error),
                        ),
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _sendImage(BuildContext context) {
    context.read<ImagePickerCubit>().sendImage(
          date: Formatter.formatDate(DateTime.now()),
          time: Formatter.formatTime(DateTime.now()),
          imageIndex: _selectedImageIndex!,
        );
    Navigator.pop(context);
  }
}
