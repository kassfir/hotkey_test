import 'package:flutter/material.dart';

class CustomOverlayPortalController extends OverlayPortalController {
  late final ValueNotifier<bool> isShowingNotifier =
      ValueNotifier(super.isShowing);

  CustomOverlayPortalController();

  @override
  void toggle() {
    isShowingNotifier.value = !isShowingNotifier.value;
    super.toggle();
  }

  @override
  void show() {
    isShowingNotifier.value = true;
    super.show();
  }

  @override
  void hide() {
    isShowingNotifier.value = false;
    super.hide();
  }

  void dispose() {
    isShowingNotifier.dispose();
  }
}
