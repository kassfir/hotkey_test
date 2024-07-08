import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardShortcutTest extends StatelessWidget {
  final Widget child;
  final String snackbarMessage;
  final LogicalKeyboardKey hotkey;

  const KeyboardShortcutTest({
    super.key,
    required this.child,
    required this.hotkey,
    required this.snackbarMessage,
  });

  @override
  Widget build(BuildContext context) {
    Object? handleInvoke(Intent intent) {
      final snackBar = SnackBar(
        showCloseIcon: true,
        duration: const Duration(seconds: 1),
        content: Text(snackbarMessage),
      );

      print('----> $snackbarMessage');

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return null;
    }

    return Shortcuts(
      shortcuts: {
        SingleActivator(hotkey): const SnackbarIntent(),
      },
      child: Actions(
        actions: {
          SnackbarIntent: CallbackAction(
            onInvoke: handleInvoke,
          )
        },
        child: child,
      ),
    );
  }
}

class SnackbarIntent extends Intent {
  const SnackbarIntent();
}
