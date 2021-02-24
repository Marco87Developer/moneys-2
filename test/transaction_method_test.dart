import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enumerations/transaction_method.dart';

void main() {
  test('string()', () {
    const TransactionMethod method1 = TransactionMethod.applePay;
    const TransactionMethod method2 = TransactionMethod.debitCard;
    const TransactionMethod method3 = TransactionMethod.bankTransfer;

    expect(method1.string(), 'Apple Pay');
    expect(method2.string(), 'debit card');
    expect(method3.string(), 'bank transfer');
  });

  test('From String to TransactionMethod', () {
    const String method1 = 'credit card';
    const String method2 = 'Google Pay';
    const String methodNotValid1 = 'CREDITCard';
    const String methodNotValid2 = 'abcdefg';

    expect(method1.toTransactionMethod(), TransactionMethod.creditCard);
    expect(method2.toTransactionMethod(), TransactionMethod.gPay);
    expect(() => methodNotValid1.toTransactionMethod(), throwsFormatException);
    expect(() => methodNotValid2.toTransactionMethod(), throwsFormatException);
  });
}
