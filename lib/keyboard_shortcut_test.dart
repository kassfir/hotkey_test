import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardShortcutTest extends StatelessWidget {
  final Widget child;
  final String snackbarMessage;
  final LogicalKeyboardKey hotkey;
  final Intent intent;

  const KeyboardShortcutTest({
    super.key,
    required this.child,
    required this.hotkey,
    required this.snackbarMessage,
    required this.intent,
  });

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: {SingleActivator(hotkey): intent},
      child: Actions(
        actions: {
          SnackbarIntent: ShowSnackbarAction(snackbarMessage, context),
          OverlaySnackbarIntent:
              ShowOverlaySnackbarAction(snackbarMessage, context),
        },
        child: child,
      ),
    );
  }
}

class SnackbarIntent extends Intent {
  const SnackbarIntent();
}

class OverlaySnackbarIntent extends Intent {
  const OverlaySnackbarIntent();
}

class ShowSnackbarAction extends Action<SnackbarIntent> {
  ShowSnackbarAction(this.message, this.context);

  final String message;
  final BuildContext context;

  @override
  Object? invoke(covariant SnackbarIntent intent) {
    final snackBar = SnackBar(
      showCloseIcon: true,
      duration: const Duration(seconds: 1),
      content: Text(message),
    );

    print('[ShowSnackbarAction]: $message');

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return null;
  }
}

class ShowOverlaySnackbarAction extends Action<OverlaySnackbarIntent> {
  ShowOverlaySnackbarAction(this.message, this.context);

  final String message;
  final BuildContext context;

  @override
  Object? invoke(covariant OverlaySnackbarIntent intent) {
    final snackBar = SnackBar(
      showCloseIcon: true,
      duration: const Duration(seconds: 1),
      content: Text(message),
    );

    print('[ShowOverlaySnackbarAction]: $message');

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return null;
  }
}
