import 'package:flutter/material.dart';

class CustomOverlayPortalController extends OverlayPortalController {
  ValueNotifier<bool> isShowingNotifier = ValueNotifier(false);
  FocusNode focusNode = FocusNode();

  CustomOverlayPortalController() {
    // Add a listener to the isShowingNotifier to handle focus automatically
    isShowingNotifier.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (isShowingNotifier.value) {
      focusNode.requestFocus();
    } else {
      focusNode.unfocus();
    }
  }

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
    focusNode.dispose();
    isShowingNotifier.removeListener(_handleFocusChange);
    isShowingNotifier.dispose();
  }
}
