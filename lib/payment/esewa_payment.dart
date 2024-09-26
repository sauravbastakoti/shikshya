import 'package:esewa_flutter/esewa_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EsewaPaymentScreen extends StatefulWidget {
  final ESewaConfig paymentConfig;

  const EsewaPaymentScreen({
    super.key,
    required this.paymentConfig,
  });

  @override
  _EsewaPaymentScreenState createState() => _EsewaPaymentScreenState();
}

class _EsewaPaymentScreenState extends State<EsewaPaymentScreen> {
  String refId = '';
  String hasError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('eSewa Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EsewaPayButton(
              paymentConfig: widget.paymentConfig,
              width: 100,
              onFailure: (result) {
                setState(() {
                  refId = '';
                  hasError = result;
                });
                if (kDebugMode) {
                  print(result);
                }
              },
              onSuccess: (result) {
                setState(() {
                  hasError = '';
                  refId = result.refId!;
                });
                if (kDebugMode) {
                  print(result.toJson());
                }
              },
            ),
            if (refId.isNotEmpty)
              Text('Console: Payment Success, Ref Id: $refId'),
            if (hasError.isNotEmpty)
              Text('Console: Payment Failed, Message: $hasError'),
          ],
        ),
      ),
    );
  }
}
