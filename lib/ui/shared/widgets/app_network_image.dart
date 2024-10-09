import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/_constants.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final bool isCircular;
  final bool cacheImage;
  final Size? size;
  final double borderRadius;
  final Widget? placeholderWidget;
  final String? placeholderAssetImage;
  final Widget? errorWidget;
  final String? errorAssetImage;

  const AppNetworkImage({
    super.key,
    String? url,
    this.fit,
    this.isCircular = false,
    this.cacheImage = true,
    this.size = const Size.square(40),
    this.borderRadius = 0,
    this.placeholderWidget,
    this.placeholderAssetImage,
    this.errorWidget,
    this.errorAssetImage,
  })  : imageUrl = url ?? '',
        assert(
          url != null ||
              placeholderAssetImage != null ||
              placeholderWidget != null,
          'At least one must be set',
        ),
        assert(
          placeholderWidget == null || placeholderAssetImage == null,
          'Only one of placeholderWidget or placeholderAssetImage can be set',
        ),
        assert(
          errorWidget == null || errorAssetImage == null,
          'Only one of errorWidget or errorAssetImage can be set',
        );

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return FittedBox(
        child: Container(
          height: size?.height,
          width: size?.width,
          decoration: BoxDecoration(
            borderRadius:
                isCircular ? null : BorderRadius.circular(borderRadius),
            shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          ),
          child: () {
            if (placeholderWidget != null) {
              return placeholderWidget!;
            }
            return placeholderAssetImage!.endsWith('.svg')
                ? SvgPicture.asset(
                    placeholderAssetImage!,
                    fit: fit ?? BoxFit.contain,
                  )
                : Image.asset(
                    placeholderAssetImage!,
                    fit: fit,
                  );
          }(),
        ),
      );
    }
    return ExtendedImage.network(
      imageUrl,
      cache: cacheImage,
      height: size?.height,
      width: size?.width,
      clipBehavior: Clip.hardEdge,
      fit: fit ?? BoxFit.cover,
      shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
      borderRadius: isCircular ? null : BorderRadius.circular(borderRadius),
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            if (placeholderWidget != null) {
              return placeholderWidget!;
            }
            if (placeholderAssetImage != null &&
                placeholderAssetImage!.isNotEmpty) {
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius:
                      isCircular ? null : BorderRadius.circular(borderRadius),
                  shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
                ),
                child: placeholderAssetImage!.endsWith('.svg')
                    ? SvgPicture.asset(
                        placeholderAssetImage!,
                        fit: fit ?? BoxFit.contain,
                      )
                    : Image.asset(
                        placeholderAssetImage!,
                        fit: fit,
                      ),
              );
            }
            return Shimmer.fromColors(
              baseColor: AppColors.black,
              highlightColor: AppColors.orange,
              child: Container(
                height: size?.height,
                width: size?.width,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
                  borderRadius:
                      isCircular ? null : BorderRadius.circular(borderRadius),
                ),
              ),
            );
          case LoadState.completed:
            return ExtendedRawImage(
              image: state.extendedImageInfo?.image,
              height: size?.height,
              width: size?.width,
              fit: fit ?? BoxFit.cover,
            );
          case LoadState.failed:
            if (errorWidget != null) {
              return errorWidget!;
            }
            final errorImage = errorAssetImage ?? placeholderAssetImage ?? '';
            if (errorImage.isNotEmpty) {
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius:
                      isCircular ? null : BorderRadius.circular(borderRadius),
                  shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
                ),
                child: errorImage.endsWith('.svg')
                    ? SvgPicture.asset(
                        errorImage,
                        fit: fit ?? BoxFit.contain,
                      )
                    : Image.asset(
                        errorImage,
                        fit: fit,
                      ),
              );
            }
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius:
                    isCircular ? null : BorderRadius.circular(borderRadius),
                shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
              ),
            );
        }
      },
    );
  }
}
