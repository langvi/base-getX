import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:base_getx/base_getx.dart';
import 'package:base_getx/src/widgets/dialog/build_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowDialog {
  factory ShowDialog() {
    _instance._context = Get.context!;
    return _instance;
  }

  late BuildContext _context;
  int _numberDialog = 0; // check số lượng dialog đang hiển thị

  static final _instance = ShowDialog._internal();

  ShowDialog._internal();
  void showErrorDialog(
      {required String title, required String content, Function? onClick}) {
    // Nếu nhiều hơn 1 dialog sẽ đóng dialog cũ
    if (_numberDialog > 0) {
      Navigator.of(_context).pop();
    }
    CustomAwesomeDialog(
        context: _context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: title,
        dismissOnBackKeyPress: false,
        desc: content,
        btnCancel: _buildButton('OK', Colors.red, onClick: onClick),
        customHeader: _buildHeader(Icons.close, color: Colors.red))
      ..show();
    _numberDialog++;
  }

  void showSuccessDialog(
      {required String title, required String content, Function? onClick}) {
    CustomAwesomeDialog(
        context: _context,
        animType: AnimType.BOTTOMSLIDE,
        title: title,
        dismissOnBackKeyPress: false,
        desc: content,
        btnOk: _buildButton('OK', Theme.of(_context).primaryColor,
            onClick: onClick),
        customHeader:
        _buildHeader(Icons.done, color: Theme.of(_context).primaryColor))
      ..show();
  }

  void showDialogNotification(
      {required String title, required String content, Function? onClick}) {

    if (_numberDialog > 0) {
      Navigator.of(_context).pop();
    }
    CustomAwesomeDialog(
        context: _context,
        dialogType: DialogType.INFO,
        animType: AnimType.BOTTOMSLIDE,
        title: title,
        desc: content,
        btnCancel: _buildButton('OK', Theme.of(_context).primaryColor,
            onClick: onClick),
        customHeader: _buildHeader(Icons.priority_high,
            color: Theme.of(_context).primaryColor))
      ..show();
    _numberDialog++;
  }

  void showDialogConfirm(
      {required String title,
        required String content,
        Function? confirm,
        String titleAccept = 'Đồng ý'}) {
    CustomAwesomeDialog(
        context: _context,
        dialogType: DialogType.INFO,
        animType: AnimType.BOTTOMSLIDE,
        title: title,
        dismissOnBackKeyPress: false,
        desc: content,
        btnOk: ElevatedButton(
          style: ButtonStyle(backgroundColor:
          MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(_context).primaryColor.withOpacity(0.5);
            }
            return Theme.of(_context).primaryColor;
          }), shape:
          MaterialStateProperty.resolveWith<OutlinedBorder>((states) {
            return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10));
          })),
          onPressed: () {
            if (confirm != null) {
              confirm();
            }
          },
          child: Text(
            titleAccept,
            style: TextStyle(color: Colors.white),
          ),
        ),
        btnCancel: _buildButton(
          'Hủy',
          Colors.grey,
        ),
        customHeader: _buildHeader(Icons.priority_high,
            color: Theme.of(_context).primaryColor))
      ..show();
  }

  Future<void> showMenuDialog(
      {@required child,
        bool barrierDismissible = true,
        double paddingChild = 8.0}) async {
    await showDialog(
      context: _context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(padding: EdgeInsets.all(paddingChild), child: child),
          ),
        );
      },
    );
  }

  Widget _buildHeader(IconData icon, {Color color = Colors.blue}) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 40,
        color: Colors.white,
      ),
    );
  }

  Widget _buildButton(String title, Color color, {Function? onClick}) {
    return RaisedButton(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {
        _numberDialog = 0;
        Navigator.pop(_context);
        if (onClick != null) {
          onClick();
        }
      },
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
