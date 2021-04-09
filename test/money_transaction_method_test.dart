import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enumerations/money_transaction_method.dart';

void main() {
  test('string()', () {
    const MoneyTransactionMethod method1 = MoneyTransactionMethod.applePay;
    const MoneyTransactionMethod method2 = MoneyTransactionMethod.debitCard;
    const MoneyTransactionMethod method3 = MoneyTransactionMethod.bankTransfer;

    expect(method1.string(), 'Apple Pay');
    expect(method2.string(), 'debit card');
    expect(method3.string(), 'bank transfer');
  });

  test('From String to TransactionMethod', () {
    const String method1 = 'credit card';
    const String method2 = 'Google Pay';
    const String methodNotValid1 = 'CREDITCard';
    const String methodNotValid2 = 'abcdefg';

    expect(
        method1.toMoneyTransactionMethod(), MoneyTransactionMethod.creditCard);
    expect(method2.toMoneyTransactionMethod(), MoneyTransactionMethod.gPay);
    expect(() => methodNotValid1.toMoneyTransactionMethod(),
        throwsFormatException);
    expect(() => methodNotValid2.toMoneyTransactionMethod(),
        throwsFormatException);
  });
}
