import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_test/custom_controller.dart';
import 'package:hotkey_test/keyboard_shortcut_test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CustomOverlayPortalController controller = CustomOverlayPortalController();

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  FocusNode overlayFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: KeyboardShortcutTest(
        intent: const SnackbarIntent(),
        snackbarMessage: 'Parent widget',
        hotkey: LogicalKeyboardKey.escape,
        child: Focus(
          autofocus: true,
          onFocusChange: (isFocused) {
            final message = isFocused
                ? 'Parent widget gained focus.'
                : 'Parent widget lost focus.';

            print('----> $message');
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'Press Esc to trigger a snackbar or press the button to open an overlay'),
              OverlayPortal(
                controller: controller,
                overlayChildBuilder: (context) {
                  final FocusNode focusNode = FocusNode();

                  return KeyboardShortcutTest(
                    intent: const OverlaySnackbarIntent(),
                    snackbarMessage: 'Overlay widget',
                    hotkey: LogicalKeyboardKey.space,
                    child: Focus(
                      focusNode: overlayFocusNode,
                      child: Center(
                        child: TapRegion(
                          consumeOutsideTaps: true,
                          onTapOutside: (event) {
                            inspect(FocusScope.of(context));
                            focusNode.dispose();
                          },
                          child: Container(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            width: 400,
                            height: 400,
                            padding: const EdgeInsets.all(20),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Notice that the snackbar message changes, but both SnackbarIntents produce the same message when Esc of Space is pressed. Click outside the overlay to close it.',
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'With FocusNode',
                                  textAlign: TextAlign.center,
                                ),
                                TextField(
                                  focusNode: focusNode,
                                  onTapOutside: (_) {
                                    focusNode.unfocus(
                                      disposition: UnfocusDisposition
                                          .previouslyFocusedChild,
                                    );
                                  },
                                  onEditingComplete: () {
                                    focusNode.unfocus(
                                      disposition: UnfocusDisposition
                                          .previouslyFocusedChild,
                                    );
                                  },
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Without FocusNode. This will cause focus to be misplaced.',
                                  textAlign: TextAlign.center,
                                ),
                                const TextField(),
                                const SizedBox(height: 12),
                                OutlinedButton(
                                  onPressed: () {
                                    controller.hide();
                                  },
                                  child: const Text('Click me!'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: ElevatedButton(
                  child: const Text('Open overlay portal'),
                  onPressed: () {
                    controller.show();
                    FocusScope.of(context).requestFocus(overlayFocusNode);
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
