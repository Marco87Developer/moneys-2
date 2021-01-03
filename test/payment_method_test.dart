import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enumerations/payment_method.dart';

void main() {
  test('string()', () {
    const PaymentMethod method1 = PaymentMethod.applePay;
    const PaymentMethod method2 = PaymentMethod.debitCard;
    const PaymentMethod method3 = PaymentMethod.bankTransfer;

    expect(method1.string(), 'applePay');
    expect(method2.string(), 'debitCard');
    expect(method3.string(), 'bankTransfer');
  });

  test('From String to PaymentMethod', () {
    const String method1 = 'creditCard';
    const String method2 = 'gPay';
    const String methodNotValid1 = 'CREDITCard';
    const String methodNotValid2 = 'abcdefg';

    expect(method1.toPaymentMethod(), PaymentMethod.creditCard);
    expect(method2.toPaymentMethod(), PaymentMethod.gPay);
    expect(() => methodNotValid1.toPaymentMethod(), throwsFormatException);
    expect(() => methodNotValid2.toPaymentMethod(), throwsFormatException);
  });
}
