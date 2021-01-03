import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enumerations/currency.dart';
import 'package:moneys/src/enumerations/income_or_expense.dart';
import 'package:moneys/src/enumerations/payment_method.dart';
import 'package:moneys/src/models/money.dart';
import 'package:moneys/src/models/payment.dart';

void main() {
  test('Payment.fromMap()', () {
    const Map<String, dynamic> map = {
      'dateTime': '2020-02-27T13:27:00.000',
      'id': 'unique id',
      'incomeOrExpense': 'income',
      'method': 'debitCard',
      'value': '10000.5 EUR',
    };
    const Map<String, dynamic> wrongMap = {
      'dateTime': '2020-02-27T13:27:00.000',
      'id': 'unique id',
      'method': 'debitCard',
      'value': '10000.5 EUR',
    };

    expect(
      Payment.fromMap(map),
      Payment(
        dateTime: DateTime(2020, 2, 27, 13, 27),
        id: 'unique id',
        incomeOrExpense: IncomeOrExpense.income,
        method: PaymentMethod.debitCard,
        value: Money(
          amount: 10000.5,
          currency: Currency.eur,
        ),
      ),
    );
    expect(() => Payment.fromMap(wrongMap), throwsFormatException);
  });

  test('toMap()', () {
    final Payment payment = Payment(
      dateTime: DateTime(2020, 2, 27, 13, 27),
      id: 'unique id',
      incomeOrExpense: IncomeOrExpense.income,
      method: PaymentMethod.debitCard,
      value: Money(
        amount: 10000.5,
        currency: Currency.eur,
      ),
    );

    expect(payment.toMap(), {
      'dateTime': '2020-02-27T13:27:00.000',
      'id': 'unique id',
      'incomeOrExpense': 'income',
      'method': 'debitCard',
      'value': '10000.50 EUR',
    });
  });

  test('@override compareTo()', () {
    final Payment payment1 = Payment(
      dateTime: DateTime(2020, 2, 27, 13, 27),
      id: 'unique id',
      incomeOrExpense: IncomeOrExpense.income,
      method: PaymentMethod.debitCard,
      value: Money(
        amount: 10000.5,
        currency: Currency.eur,
      ),
    );
    final Payment payment2 = Payment(
      dateTime: DateTime(2020, 2, 15, 15, 30),
      id: 'unique id',
      incomeOrExpense: IncomeOrExpense.income,
      method: PaymentMethod.debitCard,
      value: Money(
        amount: 15000,
        currency: Currency.eur,
      ),
    );
    final Payment payment3 = Payment(
      dateTime: DateTime(2020, 2, 27, 13, 27),
      id: 'unique id',
      incomeOrExpense: IncomeOrExpense.income,
      method: PaymentMethod.debitCard,
      value: Money(
        amount: 15000,
        currency: Currency.eur,
      ),
    );
    final Payment payment4 = Payment(
      dateTime: DateTime(2020, 2, 27, 13, 27),
      id: 'unique id',
      incomeOrExpense: IncomeOrExpense.income,
      method: PaymentMethod.applePay,
      value: Money(
        amount: 10000.5,
        currency: Currency.eur,
      ),
    );

    expect(payment1.compareTo(payment2), 1);
    expect(payment1.compareTo(payment3), -1);
    expect(payment1.compareTo(payment4), 1);
  });
}
