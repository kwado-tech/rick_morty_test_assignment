import 'package:flutter/material.dart';

class DialogUtil<T> {
  final BuildContext _context;

  const DialogUtil(this._context);

  Future<T?> openDialog(
      {required Widget child, bool barrierDismissable = true}) async {
    final _result = await showDialog<T>(
      barrierDismissible: barrierDismissable,
      context: _context,
      builder: (context) {
        return child;
      },
    );

    return _result;
  }

  Future<T?> bottomModal({
    required Widget child,
    bool barrierDismissable = true,
    bool enableDrag = true,
  }) async {
    final _result = await showModalBottomSheet<T>(
      context: _context,
      enableDrag: enableDrag,
      builder: (context) {
        return child;
      },
    );

    return _result;
  }
}
