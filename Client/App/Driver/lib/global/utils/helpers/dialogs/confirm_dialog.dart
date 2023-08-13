import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/constants/size.dart';
import 'package:driver/global/utils/extensions/string_extension.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:driver/global/widgets/common_widget.dart';
import 'package:driver/global/widgets/loader.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum DialogType { CONFIRMATION, ACCEPT, DELETE, UPDATE, ADD, RETRY }

// ignore: constant_identifier_names
enum DialogAnimation {
  // ignore: constant_identifier_names
  DEFAULT,
  // ignore: constant_identifier_names
  ROTATE,
  // ignore: constant_identifier_names
  SLIDE_TOP_BOTTOM,
  // ignore: constant_identifier_names
  SLIDE_BOTTOM_TOP,
  // ignore: constant_identifier_names
  SLIDE_LEFT_RIGHT,
  // ignore: constant_identifier_names
  SLIDE_RIGHT_LEFT,
  // ignore: constant_identifier_names
  SCALE
}

Color getDialogPrimaryColor(
  BuildContext context,
  DialogType dialogType,
  Color? primaryColor,
) {
  if (primaryColor != null) return primaryColor;
  Color color;

  switch (dialogType) {
    case DialogType.DELETE:
      color = Colors.red;
      break;
    case DialogType.UPDATE:
      color = Colors.amber;
      break;
    case DialogType.CONFIRMATION:
    case DialogType.ADD:
    case DialogType.RETRY:
      color = Colors.blue;
      break;
    case DialogType.ACCEPT:
      color = Colors.green;
      break;
  }
  return color;
}

String getPositiveText(DialogType dialogType) {
  String positiveText = "";

  switch (dialogType) {
    case DialogType.CONFIRMATION:
      positiveText = "Yes";
      break;
    case DialogType.DELETE:
      positiveText = "Delete";
      break;
    case DialogType.UPDATE:
      positiveText = "Update";
      break;
    case DialogType.ADD:
      positiveText = "Add";
      break;
    case DialogType.ACCEPT:
      positiveText = "Accept";
      break;
    case DialogType.RETRY:
      positiveText = "Retry";
      break;
  }
  return positiveText;
}

String getTitle(DialogType dialogType) {
  String titleText = "";

  switch (dialogType) {
    case DialogType.CONFIRMATION:
      titleText = "Are you sure want to perform this action?";
      break;
    case DialogType.DELETE:
      titleText = "Do you want to delete?";
      break;
    case DialogType.UPDATE:
      titleText = "Do you want to update?";
      break;
    case DialogType.ADD:
      titleText = "Do you want to add?";
      break;
    case DialogType.ACCEPT:
      titleText = "Do you want to accept?";
      break;
    case DialogType.RETRY:
      titleText = "Click to retry";
      break;
  }
  return titleText;
}

Widget getIcon(DialogType dialogType, {double? size}) {
  Icon icon;

  switch (dialogType) {
    case DialogType.CONFIRMATION:
    case DialogType.RETRY:
    case DialogType.ACCEPT:
      icon = Icon(
        Icons.done,
        size: size ?? 20,
        color: Colors.white,
      );
      break;
    case DialogType.DELETE:
      icon = Icon(
        Icons.delete_forever_outlined,
        size: size ?? 20,
        color: Colors.white,
      );
      break;
    case DialogType.UPDATE:
      icon = Icon(
        Icons.edit,
        size: size ?? 20,
        color: Colors.white,
      );
      break;
    case DialogType.ADD:
      icon = Icon(
        Icons.add,
        size: size ?? 20,
        color: Colors.white,
      );
      break;
  }
  return icon;
}

Widget? getCenteredImage(BuildContext context, DialogType dialogType, Color? primaryColor) {
  Widget? widget;

  switch (dialogType) {
    case DialogType.CONFIRMATION:
      widget = Container(
        decoration: BoxDecoration(
          color: getDialogPrimaryColor(
            context,
            dialogType,
            primaryColor,
          ).withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(16),
        child: Icon(
          Icons.warning_amber_rounded,
          color: getDialogPrimaryColor(
            context,
            dialogType,
            primaryColor,
          ),
          size: 40,
        ),
      );
      break;
    case DialogType.DELETE:
      widget = Container(
        decoration: BoxDecoration(
            color: getDialogPrimaryColor(
              context,
              dialogType,
              primaryColor,
            ).withOpacity(0.2),
            shape: BoxShape.circle),
        padding: const EdgeInsets.all(16),
        child: Icon(Icons.close,
            color: getDialogPrimaryColor(
              context,
              dialogType,
              primaryColor,
            ),
            size: 40),
      );
      break;
    case DialogType.UPDATE:
      widget = Container(
        decoration: BoxDecoration(
            color: getDialogPrimaryColor(
              context,
              dialogType,
              primaryColor,
            ).withOpacity(0.2),
            shape: BoxShape.circle),
        padding: const EdgeInsets.all(16),
        child: Icon(
          Icons.edit_outlined,
          color: getDialogPrimaryColor(
            context,
            dialogType,
            primaryColor,
          ),
          size: 40,
        ),
      );
      break;
    case DialogType.ADD:
    case DialogType.ACCEPT:
      widget = Container(
        decoration: BoxDecoration(
          color: getDialogPrimaryColor(
            context,
            dialogType,
            primaryColor,
          ).withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(16),
        child: Icon(
          Icons.done_outline,
          color: getDialogPrimaryColor(
            context,
            dialogType,
            primaryColor,
          ),
          size: 40,
        ),
      );
      break;
    case DialogType.RETRY:
      widget = Container(
        decoration: BoxDecoration(
          color: getDialogPrimaryColor(
            context,
            dialogType,
            primaryColor,
          ).withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(16),
        child: Icon(
          Icons.refresh_rounded,
          color: getDialogPrimaryColor(
            context,
            dialogType,
            primaryColor,
          ),
          size: 40,
        ),
      );
      break;
  }
  return widget;
}

Widget defaultPlaceHolder(
  BuildContext context,
  DialogType dialogType,
  double? height,
  double? width,
  Color? primaryColor, {
  Widget? child,
  ShapeBorder? shape,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: getDialogPrimaryColor(
        context,
        dialogType,
        primaryColor,
      ).withOpacity(0.2),
    ),
    alignment: Alignment.center,
    child: child ??
        getCenteredImage(
          context,
          dialogType,
          primaryColor,
        ),
  );
}

Widget buildTitleWidget(
  BuildContext context,
  DialogType dialogType,
  Color? primaryColor,
  Widget? customCenterWidget,
  double height,
  double width,
  String? centerImage,
  ShapeBorder? shape,
) {
  if (customCenterWidget != null) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: height,
        maxWidth: width,
      ),
      child: customCenterWidget,
    );
  } else {
    if (centerImage != null) {
      return Image.network(
        centerImage,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (_, object, stack) {
          log(object.toString());
          return defaultPlaceHolder(
            context,
            dialogType,
            height,
            width,
            primaryColor,
            shape: shape,
          );
        },
        loadingBuilder: (_, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return defaultPlaceHolder(
            context,
            dialogType,
            height,
            width,
            primaryColor,
            shape: shape,
            child: Loader(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    } else {
      return defaultPlaceHolder(
        context,
        dialogType,
        height,
        width,
        primaryColor,
        shape: shape,
      );
    }
  }
}

Future<bool?> showConfirmDialogCustom(
  BuildContext context, {
  required Function(BuildContext) onAccept,
  String? title,
  String? subTitle,
  String? positiveText,
  String? negativeText,
  String? centerImage,
  Widget? customCenterWidget,
  Color? primaryColor,
  Color? positiveTextColor,
  Color? negativeTextColor,
  ShapeBorder? shape,
  Function(BuildContext)? onCancel,
  bool barrierDismissible = true,
  double? height,
  double? width,
  bool cancelable = true,
  Color? barrierColor,
  DialogType dialogType = DialogType.CONFIRMATION,
  DialogAnimation dialogAnimation = DialogAnimation.DEFAULT,
  Duration? transitionDuration,
  Curve curve = Curves.easeInBack,
}) async {
  hideKeyboard(context);

  return await showGeneralDialog(
    context: context,
    barrierColor: barrierColor ?? Colors.black54,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container();
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: '',
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 400),
    transitionBuilder: (_, animation, secondaryAnimation, child) {
      return dialogAnimatedWrapperWidget(
        animation: animation,
        dialogAnimation: dialogAnimation,
        curve: curve,
        child: AlertDialog(
          shape: shape ?? dialogShape(),
          titlePadding: EdgeInsets.zero,
          backgroundColor: Theme.of(context).cardColor,
          elevation: 4,
          title: buildTitleWidget(
            _,
            dialogType,
            primaryColor,
            customCenterWidget,
            height ?? customDialogHeight,
            width ?? customDialogWidth,
            centerImage,
            shape,
          ),
          content: Container(
            width: width ?? customDialogWidth,
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title ?? getTitle(dialogType),
                  style: boldTextStyle(size: 16),
                  textAlign: TextAlign.center,
                ),
                Visibility(
                  visible: subTitle.validate().isNotEmpty,
                  child: const SizedBox(height: 8),
                ),
                Visibility(
                  visible: subTitle.validate().isNotEmpty,
                  child: Text(
                    subTitle.validate(),
                    style: secondaryTextStyle(size: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          if (cancelable) Navigator.pop(_, false);

                          onCancel?.call(_);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(defaultRadius),
                            side: const BorderSide(color: viewLineColor),
                          ),
                        ),
                        child: FittedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.close,
                                color: textPrimaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                negativeText ?? 'Cancel',
                                style: boldTextStyle(
                                  color: negativeTextColor ?? textPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          onAccept.call(_);

                          if (cancelable) Navigator.pop(context, true);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: getDialogPrimaryColor(_, dialogType, primaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(defaultRadius),
                            side: const BorderSide(color: viewLineColor),
                          ),
                        ),
                        child: FittedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              getIcon(dialogType),
                              const SizedBox(width: 6),
                              Text(
                                positiveText ?? getPositiveText(dialogType),
                                style: boldTextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget dialogAnimatedWrapperWidget({
  required Animation<double> animation,
  required Widget child,
  required DialogAnimation dialogAnimation,
  required Curve curve,
}) {
  switch (dialogAnimation) {
    case DialogAnimation.ROTATE:
      return Transform.rotate(
        angle: radians(animation.value * 360),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      );

    case DialogAnimation.SLIDE_TOP_BOTTOM:
      final curvedValue = curve.transform(animation.value) - 1.0;

      return Transform(
        transform: Matrix4.translationValues(
          0.0,
          curvedValue * 300,
          0.0,
        ),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      );

    case DialogAnimation.SCALE:
      return Transform.scale(
        scale: animation.value,
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );

    case DialogAnimation.SLIDE_BOTTOM_TOP:
      return SlideTransition(
        position: Tween(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).chain(CurveTween(curve: curve)).animate(animation),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      );

    case DialogAnimation.SLIDE_LEFT_RIGHT:
      return SlideTransition(
        position: Tween(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: curve)).animate(animation),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      );

    case DialogAnimation.SLIDE_RIGHT_LEFT:
      return SlideTransition(
        position: Tween(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: curve)).animate(animation),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      );

    case DialogAnimation.DEFAULT:
      return FadeTransition(
        opacity: animation,
        child: child,
      );
  }
}
