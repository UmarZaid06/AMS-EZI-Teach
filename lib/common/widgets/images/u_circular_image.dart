import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class AppCircularImage extends StatelessWidget {
  const AppCircularImage({
    super.key,
    this.height = 56,
    this.width = 56,
    this.fit,
    this.overlayColor,
    required this.image,
    this.backgroundColor,
    this.padding = AppSizes.sm,
    this.isNetworkImage = false,
  });

  final BoxFit? fit;
  final String? image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ??
            (AppHelperFunctions.isDarkMode(context)
                ? AppColors.black
                : AppColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    if (image == null || image!.isEmpty) {
      return const Icon(
        Icons.person,
        size: 40,
        color: Colors.grey,
      );
    }

    return Image(
      image: isNetworkImage
          ? NetworkImage(image!)
          : AssetImage(image!) as ImageProvider,
      fit: fit ?? BoxFit.fitHeight,
      color: overlayColor,
    );
  }
}
