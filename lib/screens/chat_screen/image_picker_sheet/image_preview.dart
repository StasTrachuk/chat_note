import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:home_work/widgets/chek_box.dart';

class ImagePreview extends StatefulWidget {
  final Uint8List asset;
  final bool isSelect;

  const ImagePreview({
    super.key,
    required this.asset,
    required this.isSelect,
  });

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Stack(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.memory(
              widget.asset,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0.9, -0.9),
            child: CheckBox(
              border: true,
              isSelect: widget.isSelect,
            ),
          )
        ],
      ),
    );
  }
}
