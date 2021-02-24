import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enumerations/currency.dart';
import 'package:moneys/src/enumerations/income_or_expense.dart';
import 'package:moneys/src/enumerations/transaction_method.dart';
import 'package:moneys/src/models/money.dart';
import 'package:moneys/src/models/transaction.dart';

void main() {
  test('Transaction.fromMap()', () {
    const Map<String, dynamic> map = {
      'budgetName': '',
      'dateTime': '2020-02-27T13:27:00.000',
      'description': 'Transaction from map',
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
      'value': '10000.5 EUR',
    };

    expect(
      Transaction.fromMap(map),
      Transaction(
        dateTime: DateTime(2020, 2, 27, 13, 27),
        description: 'Transaction from map',
        id: 'unique id',
        incomeOrExpense: ExpenseOrIncome.income,
        method: TransactionMethod.debitCard,
        value: Money(
          amount: 10000.5,
          currency: Currency.eur,
        ),
      ),
    );
  });

  test('toMap()', () {
    final Transaction transaction = Transaction(
      dateTime: DateTime(2020, 2, 27, 13, 27),
      description: 'Transaction to map',
      id: 'unique id',
      incomeOrExpense: ExpenseOrIncome.income,
      method: TransactionMethod.debitCard,
      value: Money(
        amount: 10000.5,
        currency: Currency.eur,
      ),
    );

    expect(transaction.toMap(), {
      'budgetName': '',
      'dateTime': '2020-02-27T13:27:00.000',
      'description': 'Transaction to map',
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
      'value': '10000.50 EUR',
    });
  });

  test('@override compareTo()', () {
    final Transaction transaction1 = Transaction(
      dateTime: DateTime(2020, 2, 27, 13, 27),
      description: 'Transaction 1',
      id: 'unique id',
      incomeOrExpense: ExpenseOrIncome.income,
      method: TransactionMethod.debitCard,
      value: Money(
        amount: 10000.5,
        currency: Currency.eur,
      ),
    );
    final Transaction transaction2 = Transaction(
      dateTime: DateTime(2020, 2, 15, 15, 30),
      description: 'Transaction 2',
      id: 'unique id',
      incomeOrExpense: ExpenseOrIncome.income,
      method: TransactionMethod.debitCard,
      value: Money(
        amount: 15000,
        currency: Currency.eur,
      ),
    );
    final Transaction transaction3 = Transaction(
      dateTime: DateTime(2020, 2, 27, 13, 27),
      description: 'Transaction 3',
      id: 'unique id',
      incomeOrExpense: ExpenseOrIncome.income,
      method: TransactionMethod.debitCard,
      value: Money(
        amount: 15000,
        currency: Currency.eur,
      ),
    );
    final Transaction transaction4 = Transaction(
      dateTime: DateTime(2020, 2, 27, 13, 27),
      description: 'Transaction 4',
      id: 'unique id',
      incomeOrExpense: ExpenseOrIncome.income,
      method: TransactionMethod.applePay,
      value: Money(
        amount: 10000.5,
        currency: Currency.eur,
      ),
    );

    expect(transaction1.compareTo(transaction2), 1);
    expect(transaction1.compareTo(transaction3), -1);
    expect(transaction1.compareTo(transaction4), -1);
  });
}