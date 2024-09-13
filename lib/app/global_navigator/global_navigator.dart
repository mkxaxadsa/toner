import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Scnren extends StatefulWidget {
  final String njfkds;
  final String njfkads;
  final String mkda;

  Scnren({
    required this.njfkds,
    required this.njfkads,
    required this.mkda,
  });

  @override
  State<Scnren> createState() => _ScnrenState();
}

class _ScnrenState extends State<Scnren> {
  @override
  Widget build(BuildContext context) {
    final String ajx =
        '${widget.njfkds}&external_Id=${widget.njfkads}${widget.mkda}';
    print(ajx);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(ajx),
          ),
        ),
      ),
    );
  }
}

class GlobalNavigator {
  static Future<T?> push<T extends Object?>(BuildContext context,
      {required Widget page}) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
      ),
    );
  }

  static Future<T?> pushAndRemoveUntil<T extends Object?>(BuildContext context,
      {required Widget page}) {
    return Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
      ),
      (route) => false,
    );
  }

  static Future<T?> pushReplacement<T extends Object?>(BuildContext context,
      {required Widget page}) {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
      ),
    );
  }
}
