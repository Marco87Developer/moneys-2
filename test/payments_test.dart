import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/moneys.dart';
import 'package:moneys/src/models/payments.dart';

void main() {
  final Payments payments = Payments();

  final Payment payment1 = Payment(
    dateTime: DateTime(2020, 2, 27, 13, 27),
    id: 'unique id',
    incomeOrExpense: ExpenseOrIncome.income,
    method: PaymentMethod.gPay,
    value: Money(
      amount: 10000.5,
      currency: Currency.eur,
    ),
  );
  final Payment payment2 = Payment(
    dateTime: DateTime(2020, 2, 15, 15, 30),
    id: 'unique id',
    incomeOrExpense: ExpenseOrIncome.income,
    method: PaymentMethod.debitCard,
    value: Money(
      amount: 15000,
      currency: Currency.eur,
    ),
  );
  final Payment payment3 = Payment(
    dateTime: DateTime(2020, 3, 15, 15, 30),
    id: 'unique id',
    incomeOrExpense: ExpenseOrIncome.expense,
    method: PaymentMethod.debitCard,
    value: Money(
      amount: 15000,
      currency: Currency.eur,
    ),
  );
  final Payment payment4 = Payment(
    dateTime: DateTime(2020, 1, 10),
    id: 'unique id',
    incomeOrExpense: ExpenseOrIncome.expense,
    method: PaymentMethod.gPay,
    value: Money(
      amount: 5000,
      currency: Currency.eur,
    ),
  );

  final List<Map<String, dynamic>> listOfMaps = [
    {
      'dateTime': '2020-02-27T13:27:00.000',
      'id': 'unique id',
      'incomeOrExpense': 'income',
      'method': 'gPay',
      'value': '10000.5 EUR',
    },
    {
      'dateTime': '2020-02-15T15:30:00.000',
      'id': 'unique id',
      'incomeOrExpense': 'income',
      'method': 'debitCard',
      'value': '15000 EUR',
    },
    {
      'dateTime': '2020-03-15T15:30:00.000',
      'id': 'unique id',
      'incomeOrExpense': 'expense',
      'method': 'debitCard',
      'value': '15000 EUR',
    },
    {
      'dateTime': '2020-01-10T00:00:00.000',
      'id': 'unique id',
      'incomeOrExpense': 'expense',
      'method': 'gPay',
      'value': '5000 EUR',
    },
  ];

  final List<Map<String, dynamic>> orderedListOfMaps = [
    {
      'dateTime': '2020-01-10T00:00:00.000',
      'id': 'unique id',
      'incomeOrExpense': 'expense',
      'method': 'gPay',
      'value': '5000.00 EUR',
    },
    {
      'dateTime': '2020-02-15T15:30:00.000',
      'id': 'unique id',
      'incomeOrExpense': 'income',
      'method': 'debitCard',
      'value': '15000.00 EUR',
    },
    {
      'dateTime': '2020-02-27T13:27:00.000',
      'id': 'unique id',
      'incomeOrExpense': 'income',
      'method': 'gPay',
      'value': '10000.50 EUR',
    },
    {
      'dateTime': '2020-03-15T15:30:00.000',
      'id': 'unique id',
      'incomeOrExpense': 'expense',
      'method': 'debitCard',
      'value': '15000.00 EUR',
    },
  ];

  test('Payments.fromListOfMaps()', () {
    payments..add(payment1)..add(payment2)..add(payment3)..add(payment4);

    expect(Payments.fromListOfMaps(listOfMaps), payments);
  });

  test('To List<Map<String, dynamic>>', () {
    payments..add(payment1)..add(payment2)..add(payment3)..add(payment4);

    expect(payments.toListOfMaps(), orderedListOfMaps);
  });

  test('add() and history', () {
    payments..add(payment1)..add(payment2);

    expect(payments.history, [payment2, payment1]);

    payments.add(payment3);

    expect(payments.history, [payment2, payment1, payment3]);
  });

  test('remove() and history', () {
    payments
      ..add(payment1)
      ..add(payment2)
      ..add(payment3)
      ..remove(payment1);

    expect(payments.history, [payment2, payment3]);
  });

  test(
      'madeAtDateTime() and madeAtDateTimeOrBefore() and'
      ' madeAtDateTimeOrAfter()', () {
    payments..add(payment1)..add(payment2)..add(payment3);

    expect(
      payments.madeAtDateTime(DateTime(2020, 2, 27, 13, 27)),
      [payment1],
    );
    expect(
      payments.madeAtDateTimeOrBefore(DateTime(2020, 2, 27, 13, 28)),
      [payment2, payment1],
    );
    expect(
      payments.madeAtDateTimeOrAfter(DateTime(2020, 2, 27)),
      [payment1, payment3],
    );
  });

  test('total()', () {
    payments..add(payment1)..add(payment2)..add(payment3);

    expect(
      payments.total(incomeOrExpense: ExpenseOrIncome.income),
      Money(amount: 25000.5, currency: Currency.eur),
    );
    expect(
      payments.total(incomeOrExpense: ExpenseOrIncome.expense),
      Money(amount: 15000, currency: Currency.eur),
    );
    expect(
      payments.total(
        incomeOrExpense: ExpenseOrIncome.income,
        from: DateTime(2020, 2, 27),
      ),
      Money(amount: 10000.5, currency: Currency.eur),
    );
    expect(
      payments.total(
        incomeOrExpense: ExpenseOrIncome.income,
        from: DateTime(2020, 2, 14),
        until: DateTime(2020, 2, 28),
      ),
      Money(amount: 25000.5, currency: Currency.eur),
    );
    expect(
      payments.total(
        incomeOrExpense: ExpenseOrIncome.income,
        until: DateTime(2020, 2, 28),
      ),
      Money(amount: 25000.5, currency: Currency.eur),
    );
  });

  test('whoseMethodWas()', () {
    payments..add(payment1)..add(payment2)..add(payment3)..add(payment4);

    expect(payments.whoseMethodWas(PaymentMethod.gPay), [payment4, payment1]);
  });

  test(
      'withValueLessThan(), withValueLessThanOrEqualTo(),'
      ' withValueGreaterThanOrEqualTo() and withValueGreaterThan()', () {
    payments..add(payment1)..add(payment2)..add(payment3)..add(payment4);

    expect(
      payments.withValueLessThan(Money(amount: 12000, currency: Currency.eur)),
      [payment4, payment1],
    );
    expect(
      payments.withValueLessThanOrEqualTo(
          Money(amount: 10000.5, currency: Currency.eur)),
      [payment4, payment1],
    );
    expect(
      payments.withValueGreaterThanOrEqualTo(
          Money(amount: 10000.5, currency: Currency.eur)),
      [payment2, payment1, payment3],
    );
    expect(
      payments
          .withValueGreaterThan(Money(amount: 10000.5, currency: Currency.eur)),
      [payment2, payment3],
    );
  });
}
