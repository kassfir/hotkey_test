# hotkey_test

This Flutter project was created to test the inheriatance of Shortcuts and their respective actions. While developing for another MacOS/Windows app, I had difficulty understanding how the `Intents` called by pressing specific hotkeys are passed down different widgets. 

In this example I explore how the `Shortcut` widgets work when they are nested, and the child widget appears conditionally. I.e., a `Shortcut` widget is at the top level and its child is an `OverlayPortal` which will render its content if the `controller.isShowing` value is `true`. 

The `OverlayPortal` builder requests `Focus` to the child `Shortcut` widget and contains two `TextFields` - one which has a focusNode managed by the parent in the builder function, and the other is managed internally within the widget. Clicking on the first one will not cause the overlay content to lose focus (and thus lose its `Shortcut` functionality), whereas unfocusing the second will cause the focus state in that context to be lost altogether, disabling all `Shortcut`s unless focus is requested.

Not sure if this is expected Flutter behavaiour, but I hope it serves you well. 

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
