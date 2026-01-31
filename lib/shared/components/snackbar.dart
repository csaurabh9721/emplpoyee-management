import 'package:flutter/material.dart';

import '../../core/Enums/enums.dart';
import '../../main.dart';
import '../app_color.dart';


class AppSnackBar {
  static void successSnackBar({required String message}) {
    _GlobalSnackBar.show(message, SnackBarEnum.success);
  }

  static void errorSnackBar({required String message}) {
    _GlobalSnackBar.show(message, SnackBarEnum.error);
  }

  static void infoSnackBar({required String message}) {
    _GlobalSnackBar.show(message, SnackBarEnum.info);
  }
  static void warningSnackBar({required String message}) {
    _GlobalSnackBar.show(message, SnackBarEnum.warning);
  }
}

class _GlobalSnackBar {
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;
  static const Map<SnackBarEnum, Map<String, dynamic>> _map = {
    SnackBarEnum.success: {
      "icon": Icons.check_circle,
      "color": AppColors.green,
    },
    SnackBarEnum.error: {
      "icon": Icons.cancel,
      "color":  AppColors.error,
    },
    SnackBarEnum.info: {
      "icon": Icons.info,
      "color": AppColors.blue,
    },
    SnackBarEnum.warning: {
      "icon": Icons.warning,
      "color": AppColors.yellow,
    },
  };

  static void show(String message, SnackBarEnum snackBarEnum) {
    if (_isVisible) return;
    final overlay = navigatorKey.currentState?.overlay;
    if (overlay == null) return;
    _isVisible = true;
    final ValueNotifier<double> topPosition = ValueNotifier(-100); // Start above the screen
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned.fill(
          child: Stack(
            children: [
              ValueListenableBuilder<double>(
                valueListenable: topPosition,
                builder: (context, value, child) {
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                    top: value,
                    left: 12,
                    right: 12,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: _map[snackBarEnum]!["color"],
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(_map[snackBarEnum]!["icon"], color: Colors.white), // Optional icon
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                message,
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );

    overlay.insert(_overlayEntry!);
    Future.delayed(const Duration(milliseconds: 50), () => topPosition.value = 40);
    Future.delayed(const Duration(seconds: 3), () {
      topPosition.value = -100; // Move out
      Future.delayed(const Duration(milliseconds: 300), () {
        _overlayEntry?.remove();
        _overlayEntry = null;
        _isVisible = false;
      });
    });
  }
}
