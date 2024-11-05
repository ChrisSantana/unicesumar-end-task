import 'dart:io';

import 'package:flutter/material.dart';

class ViewImageWidget extends StatelessWidget {
  final String? imageAssets;
  final File? imageFile;
  final double containerDimension;
  final BoxShape boxShape;
  final double borderRadius;
  final double? imageDimension;
  final Color? containerColor;
  final EdgeInsets? paddingImage;
  final Alignment? alignmentImage;

  const ViewImageWidget({
    super.key,
    this.imageAssets,
    this.imageFile,
    this.containerDimension = 86,
    this.boxShape = BoxShape.rectangle,
    this.borderRadius = 0,
    this.imageDimension,
    this.containerColor,
    this.paddingImage,
    this.alignmentImage,
  }) : assert(imageAssets != null || imageFile != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignmentImage,
      height: containerDimension,
      width: containerDimension,
      padding: paddingImage,
      decoration: BoxDecoration(
        shape: boxShape,
        color: containerColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: _FactoryImageWidget(
          imageAssets: imageAssets,
          imageFile: imageFile,
          imageDimension: imageDimension,
        ),
      ),
    );
  }
}

class _FactoryImageWidget extends StatelessWidget {
  final String? imageAssets;
  final File? imageFile;
  final double? imageDimension;

  const _FactoryImageWidget({
    required this.imageAssets,
    required this.imageFile,
    required this.imageDimension,
  });

  @override
  Widget build(BuildContext context) {
    if (imageAssets != null) {
      return _ImageAssetWidget(
        imageAssets: imageAssets!,
        imageDimension: imageDimension,
      );
    }

    if (imageFile != null) {
      return _ImageFileWidget(
        imageFile: imageFile!,
        imageDimension: imageDimension,
      );
    }

    return const Offstage();
  }
}

class _ImageAssetWidget extends StatelessWidget {
  final String imageAssets;
  final double? imageDimension;

  const _ImageAssetWidget({
    required this.imageAssets,
    required this.imageDimension,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageAssets,
      height: imageDimension,
      width: imageDimension,
    );
  }
}

class _ImageFileWidget extends StatelessWidget {
  final File imageFile;
  final double? imageDimension;

  const _ImageFileWidget({
    required this.imageFile,
    required this.imageDimension,
  });

  @override
  Widget build(BuildContext context) {
    return Image.file(
      imageFile,
      height: imageDimension,
      width: imageDimension,
    );
  }
}
