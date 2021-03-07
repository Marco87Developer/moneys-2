import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/moneys.dart';
import 'package:moneys/src/models/money_transactions.dart';

void main() {
  final MoneyTransactions transactions = MoneyTransactions();

  final MoneyTransaction transaction1 = MoneyTransaction(
    dateTime: DateTime(2020, 2, 27, 13, 27),
    description: 'Transaction 1',
    id: 'unique id',
    incomeOrExpense: ExpenseOrIncome.income,
    method: TransactionMethod.gPay,
    value: Money(
      amount: 10000.5,
      currency: Currency.eur,
    ),
  );
  final MoneyTransaction transaction2 = MoneyTransaction(
    dateTime: DateTime(2020, 3, 15, 15, 30),
    description: 'Transaction 2',
    id: 'unique id',
    incomeOrExpense: ExpenseOrIncome.expense,
    method: TransactionMethod.debitCard,
    value: Money(
      amount: 15000,
      currency: Currency.eur,
    ),
  );
  final MoneyTransaction transaction3 = MoneyTransaction(
    dateTime: DateTime(2020, 2, 15, 15, 30),
    description: 'Transaction 3',
    id: 'unique id',
    incomeOrExpense: ExpenseOrIncome.income,
    method: TransactionMethod.debitCard,
    value: Money(
      amount: 15000,
      currency: Currency.eur,
    ),
  );
  final MoneyTransaction transaction4 = MoneyTransaction(
    dateTime: DateTime(2020, 1, 10),
    description: 'Transaction 4',
    id: 'unique id',
    incomeOrExpense: ExpenseOrIncome.expense,
    method: TransactionMethod.gPay,
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
    transactions
      ..add(transaction1)
      ..add(transaction2)
      ..add(transaction3)
      ..add(transaction4);

    expect(MoneyTransactions.fromListOfMaps(listOfMaps), transactions);
  });

  test('To List<Map<String, dynamic>>', () {
    transactions
      ..add(transaction1)
      ..add(transaction2)
      ..add(transaction3)
      ..add(transaction4);

    expect(transactions.toListOfMaps(), orderedListOfMaps);
  });

  test('add() and history', () {
    transactions..add(transaction1)..add(transaction2);

    expect(transactions.history, [transaction1, transaction2]);

    transactions.add(transaction3);

    expect(transactions.history, [transaction3, transaction1, transaction2]);
  });

  test('remove() and history', () {
    transactions
      ..add(transaction1)
      ..add(transaction2)
      ..add(transaction3)
      ..remove(transaction1);

    expect(transactions.history, [transaction3, transaction2]);
  });

  test(
      'madeAtDateTime() and madeAtDateTimeOrBefore() and'
      ' madeAtDateTimeOrAfter()', () {
    transactions..add(transaction1)..add(transaction2)..add(transaction3);

    expect(
      transactions.madeAtDateTime(DateTime(2020, 2, 27, 13, 27)),
      [transaction1],
    );
    expect(
      transactions.madeAtDateTimeOrBefore(DateTime(2020, 2, 27, 13, 28)),
      [transaction3, transaction1],
    );
    expect(
      transactions.madeAtDateTimeOrAfter(DateTime(2020, 2, 27)),
      [transaction1, transaction2],
    );
  });

  test('total()', () {
    transactions..add(transaction1)..add(transaction2)..add(transaction3);

    expect(
      transactions.total(incomeOrExpense: ExpenseOrIncome.income),
      Money(amount: 25000.5, currency: Currency.eur),
    );
    expect(
      transactions.total(incomeOrExpense: ExpenseOrIncome.expense),
      Money(amount: 15000, currency: Currency.eur),
    );
    expect(
      transactions.total(
        incomeOrExpense: ExpenseOrIncome.income,
        from: DateTime(2020, 2, 27),
      ),
      Money(amount: 10000.5, currency: Currency.eur),
    );
    expect(
      transactions.total(
        incomeOrExpense: ExpenseOrIncome.income,
        from: DateTime(2020, 2, 14),
        until: DateTime(2020, 2, 28),
      ),
      Money(amount: 25000.5, currency: Currency.eur),
    );
    expect(
      transactions.total(
        incomeOrExpense: ExpenseOrIncome.income,
        until: DateTime(2020, 2, 28),
      ),
      Money(amount: 25000.5, currency: Currency.eur),
    );
  });

  test('whoseMethodWas()', () {
    transactions
      ..add(transaction1)
      ..add(transaction2)
      ..add(transaction3)
      ..add(transaction4);

    expect(transactions.whoseMethodWas(TransactionMethod.gPay),
        [transaction4, transaction1]);
  });

  test(
      'withValueLessThan(), withValueLessThanOrEqualTo(),'
      ' withValueGreaterThanOrEqualTo() and withValueGreaterThan()', () {
    transactions
      ..add(transaction1)
      ..add(transaction2)
      ..add(transaction3)
      ..add(transaction4);

    expect(
      transactions
          .withValueLessThan(Money(amount: 12000, currency: Currency.eur)),
      [transaction4, transaction1],
    );
    expect(
      transactions.withValueLessThanOrEqualTo(
          Money(amount: 10000.5, currency: Currency.eur)),
      [transaction4, transaction1],
    );
    expect(
      transactions.withValueGreaterThanOrEqualTo(
          Money(amount: 10000.5, currency: Currency.eur)),
      [transaction3, transaction1, transaction2],
    );
    expect(
      transactions
          .withValueGreaterThan(Money(amount: 10000.5, currency: Currency.eur)),
      [transaction3, transaction2],
    );
  });
}
