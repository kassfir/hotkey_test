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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
          child: KeyboardShortcutTest(
        snackbarMessage: "Parent widget",
        hotkey: LogicalKeyboardKey.escape,
        child: Focus(
          autofocus: true,
          child: Column(
            children: [
              const Text("content"),
              OverlayPortal(
                controller: controller,
                overlayChildBuilder: (context) {
                  return KeyboardShortcutTest(
                    snackbarMessage: "Overlay  widget",
                    hotkey: LogicalKeyboardKey.space,
                    child: Focus(
                      autofocus: true,
                      focusNode: overlayFocusNode,
                      child: Center(
                        child: TapRegion(
                          consumeOutsideTaps: true,
                          onTapOutside: (event) {
                            controller.hide();
                            setState(() {});
                          },
                          child: Container(
                            color: Colors.blue,
                            width: 150,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text(
                              'overlay content',
                              style: TextStyle(
                                color: Colors.white,
                              ),
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
                    setState(() {});
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
