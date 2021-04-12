import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/moneys.dart';
import 'package:moneys/src/models/money_transactions.dart';

void main() {
  final MoneyTransactions moneyTransactions = MoneyTransactions();

  final MoneyTransaction moneyTransaction1 = MoneyTransaction(
    dateTime: DateTime(2020, 2, 27, 13, 27),
    description: 'Transaction 1',
    id: 'unique id',
    expenseOrIncome: ExpenseOrIncome.income,
    method: MoneyTransactionMethod.gPay,
    value: Money(
      amount: 10000.5,
      currency: Currency.eur,
    ),
  );
  final MoneyTransaction moneyTransaction2 = MoneyTransaction(
    dateTime: DateTime(2020, 3, 15, 15, 30),
    description: 'Transaction 2',
    id: 'unique id',
    expenseOrIncome: ExpenseOrIncome.expense,
    method: MoneyTransactionMethod.debitCard,
    value: Money(
      amount: 15000,
      currency: Currency.eur,
    ),
  );
  final MoneyTransaction moneyTransaction3 = MoneyTransaction(
    dateTime: DateTime(2020, 2, 15, 15, 30),
    description: 'Transaction 3',
    id: 'unique id',
    expenseOrIncome: ExpenseOrIncome.income,
    method: MoneyTransactionMethod.debitCard,
    value: Money(
      amount: 15000,
      currency: Currency.eur,
    ),
  );
  final MoneyTransaction moneyTransaction4 = MoneyTransaction(
    dateTime: DateTime(2020, 1, 10),
    description: 'Transaction 4',
    id: 'unique id',
    expenseOrIncome: ExpenseOrIncome.expense,
    method: MoneyTransactionMethod.gPay,
    value: Money(
      amount: 5000,
      currency: Currency.eur,
    ),
  );

  final List<Map<String, dynamic>> listOfMaps = [
    {
      'budgetName': '',
      'dateTime': '2020-02-27T13:27:00.000',
      'description': 'Transaction 1',
      'id': 'unique id',
      'incomeOrExpense': 'income',
      'method': 'Google Pay',
      'place': {
        'address': '',
        'latitude': 0,
        'longitude': 0,
        'name': '',
        'tags': <String>[],
      },
      'tags': <String>[],
      'value': '10000.5 EUR',
    },
    {
      'budgetName': '',
      'dateTime': '2020-02-15T15:30:00.000',
      'description': 'Transaction 3',
      'id': 'unique id',
      'incomeOrExpense': 'income',
      'method': 'debit card',
      'place': {
        'address': '',
        'latitude': 0,
        'longitude': 0,
        'name': '',
        'tags': <String>[],
      },
      'tags': <String>[],
      'value': '15000 EUR',
    },
    {
      'budgetName': '',
      'dateTime': '2020-03-15T15:30:00.000',
      'description': 'Transaction 2',
      'id': 'unique id',
      'incomeOrExpense': 'expense',
      'method': 'debit card',
      'place': {
        'address': '',
        'latitude': 0,
        'longitude': 0,
        'name': '',
        'tags': <String>[],
      },
      'tags': <String>[],
      'value': '15000 EUR',
    },
    {
      'budgetName': '',
      'dateTime': '2020-01-10T00:00:00.000',
      'description': 'Transaction 4',
      'id': 'unique id',
      'incomeOrExpense': 'expense',
      'method': 'Google Pay',
      'place': {
        'address': '',
        'latitude': 0,
        'longitude': 0,
        'name': '',
        'tags': <String>[],
      },
      'tags': <String>[],
      'value': '5000 EUR',
    },
  ];

  final List<Map<String, dynamic>> orderedListOfMaps = [
    {
      'budgetName': '',
      'dateTime': '2020-01-10T00:00:00.000',
      'description': 'Transaction 4',
      'id': 'unique id',
      'incomeOrExpense': 'expense',
      'method': 'Google Pay',
      'place': {
        'address': '',
        'latitude': '0.000000000000',
        'longitude': '0.000000000000',
        'name': '',
        'tags': <String>[],
      },
      'tags': <String>[],
      'value': '5000.00 EUR',
    },
    {
      'budgetName': '',
      'dateTime': '2020-02-15T15:30:00.000',
      'description': 'Transaction 3',
      'id': 'unique id',
      'incomeOrExpense': 'income',
      'method': 'debit card',
      'place': {
        'address': '',
        'latitude': '0.000000000000',
        'longitude': '0.000000000000',
        'name': '',
        'tags': <String>[],
      },
      'tags': <String>[],
      'value': '15000.00 EUR',
    },
    {
      'budgetName': '',
      'dateTime': '2020-02-27T13:27:00.000',
      'description': 'Transaction 1',
      'id': 'unique id',
      'incomeOrExpense': 'income',
      'method': 'Google Pay',
      'place': {
        'address': '',
        'latitude': '0.000000000000',
        'longitude': '0.000000000000',
        'name': '',
        'tags': <String>[],
      },
      'tags': <String>[],
      'value': '10000.50 EUR',
    },
    {
      'budgetName': '',
      'dateTime': '2020-03-15T15:30:00.000',
      'description': 'Transaction 2',
      'id': 'unique id',
      'incomeOrExpense': 'expense',
      'method': 'debit card',
      'place': {
        'address': '',
        'latitude': '0.000000000000',
        'longitude': '0.000000000000',
        'name': '',
        'tags': <String>[],
      },
      'tags': <String>[],
      'value': '15000.00 EUR',
    },
  ];

  test('Transactions.fromListOfMaps()', () {
    moneyTransactions
      ..add(moneyTransaction1)
      ..add(moneyTransaction2)
      ..add(moneyTransaction3)
      ..add(moneyTransaction4);

    expect(MoneyTransactions.fromListOfMaps(listOfMaps), moneyTransactions);
  });

  test('To List<Map<String, dynamic>>', () {
    moneyTransactions
      ..add(moneyTransaction1)
      ..add(moneyTransaction2)
      ..add(moneyTransaction3)
      ..add(moneyTransaction4);

    expect(moneyTransactions.toListOfMaps(), orderedListOfMaps);
  });

  test('add() and history', () {
    moneyTransactions..add(moneyTransaction1)..add(moneyTransaction2);

    expect(moneyTransactions.history, [moneyTransaction1, moneyTransaction2]);

    moneyTransactions.add(moneyTransaction3);

    expect(moneyTransactions.history,
        [moneyTransaction3, moneyTransaction1, moneyTransaction2]);
  });

  test('remove() and history', () {
    moneyTransactions
      ..add(moneyTransaction1)
      ..add(moneyTransaction2)
      ..add(moneyTransaction3)
      ..remove(moneyTransaction1);

    expect(moneyTransactions.history, [moneyTransaction3, moneyTransaction2]);
  });

  test(
      'madeAtDateTime() and madeAtDateTimeOrBefore() and'
      ' madeAtDateTimeOrAfter()', () {
    moneyTransactions
      ..add(moneyTransaction1)
      ..add(moneyTransaction2)
      ..add(moneyTransaction3);

    expect(
      moneyTransactions.madeAtDateTime(DateTime(2020, 2, 27, 13, 27)),
      [moneyTransaction1],
    );
    expect(
      moneyTransactions.madeAtDateTimeOrBefore(DateTime(2020, 2, 27, 13, 28)),
      [moneyTransaction3, moneyTransaction1],
    );
    expect(
      moneyTransactions.madeAtDateTimeOrAfter(DateTime(2020, 2, 27)),
      [moneyTransaction1, moneyTransaction2],
    );
  });

  test('total()', () {
    moneyTransactions
      ..add(moneyTransaction1)
      ..add(moneyTransaction2)
      ..add(moneyTransaction3);

    expect(
      moneyTransactions.total(incomeOrExpense: ExpenseOrIncome.income),
      Money(amount: 25000.5, currency: Currency.eur),
    );
    expect(
      moneyTransactions.total(incomeOrExpense: ExpenseOrIncome.expense),
      Money(amount: 15000, currency: Currency.eur),
    );
    expect(
      moneyTransactions.total(
        incomeOrExpense: ExpenseOrIncome.income,
        from: DateTime(2020, 2, 27),
      ),
      Money(amount: 10000.5, currency: Currency.eur),
    );
    expect(
      moneyTransactions.total(
        incomeOrExpense: ExpenseOrIncome.income,
        from: DateTime(2020, 2, 14),
        until: DateTime(2020, 2, 28),
      ),
      Money(amount: 25000.5, currency: Currency.eur),
    );
    expect(
      moneyTransactions.total(
        incomeOrExpense: ExpenseOrIncome.income,
        until: DateTime(2020, 2, 28),
      ),
      Money(amount: 25000.5, currency: Currency.eur),
    );
  });

  test('whoseMethodWas()', () {
    moneyTransactions
      ..add(moneyTransaction1)
      ..add(moneyTransaction2)
      ..add(moneyTransaction3)
      ..add(moneyTransaction4);

    expect(moneyTransactions.whoseMethodWas(MoneyTransactionMethod.gPay),
        [moneyTransaction4, moneyTransaction1]);
  });

  test(
      'withValueLessThan(), withValueLessThanOrEqualTo(),'
      ' withValueGreaterThanOrEqualTo() and withValueGreaterThan()', () {
    moneyTransactions
      ..add(moneyTransaction1)
      ..add(moneyTransaction2)
      ..add(moneyTransaction3)
      ..add(moneyTransaction4);

    expect(
      moneyTransactions
          .withValueLessThan(Money(amount: 12000, currency: Currency.eur)),
      [moneyTransaction4, moneyTransaction1],
    );
    expect(
      moneyTransactions.withValueLessThanOrEqualTo(
          Money(amount: 10000.5, currency: Currency.eur)),
      [moneyTransaction4, moneyTransaction1],
    );
    expect(
      moneyTransactions.withValueGreaterThanOrEqualTo(
          Money(amount: 10000.5, currency: Currency.eur)),
      [moneyTransaction3, moneyTransaction1, moneyTransaction2],
    );
    expect(
      moneyTransactions
          .withValueGreaterThan(Money(amount: 10000.5, currency: Currency.eur)),
      [moneyTransaction3, moneyTransaction2],
    );
  });
}
