import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enumerations/currency.dart';
import 'package:moneys/src/enumerations/expense_or_income.dart';
import 'package:moneys/src/enumerations/money_transaction_method.dart';
import 'package:moneys/src/models/money.dart';
import 'package:moneys/src/models/money_transaction.dart';

void main() {
  test('Transaction.fromMap()', () {
    const Map<String, dynamic> map = {
      'budgetName': '',
      'dateTime': '2020-02-27T13:27:00.000',
      'description': 'Transaction from map',
      'id': 'unique id',
      'expenseOrIncome': 'income',
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
      MoneyTransaction.fromMap(map),
      MoneyTransaction(
        dateTime: DateTime(2020, 2, 27, 13, 27),
        description: 'Transaction from map',
        id: 'unique id',
        expenseOrIncome: ExpenseOrIncome.income,
        method: MoneyTransactionMethod.debitCard,
        value: const Money(
          amount: 10000.5,
          currency: Currency.eur,
        ),
      ),
    );
  });

  test('toMap()', () {
    final MoneyTransaction transaction = MoneyTransaction(
      dateTime: DateTime(2020, 2, 27, 13, 27),
      description: 'Transaction to map',
      id: 'unique id',
      expenseOrIncome: ExpenseOrIncome.income,
      method: MoneyTransactionMethod.debitCard,
      value: const Money(
        amount: 10000.5,
        currency: Currency.eur,
      ),
    );

    expect(transaction.toMap(), {
      'budgetName': '',
      'dateTime': '2020-02-27T13:27:00.000',
      'description': 'Transaction to map',
      'id': 'unique id',
      'expenseOrIncome': 'income',
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
    final MoneyTransaction transaction1 = MoneyTransaction(
      dateTime: DateTime(2020, 2, 27, 13, 27),
      description: 'Transaction 1',
      id: 'unique id',
      expenseOrIncome: ExpenseOrIncome.income,
      method: MoneyTransactionMethod.debitCard,
      value: Money(
        amount: 10000.5,
        currency: Currency.eur,
      ),
    );
    final MoneyTransaction transaction2 = MoneyTransaction(
      dateTime: DateTime(2020, 2, 15, 15, 30),
      description: 'Transaction 2',
      id: 'unique id',
      expenseOrIncome: ExpenseOrIncome.income,
      method: MoneyTransactionMethod.debitCard,
      value: const Money(
        amount: 15000,
        currency: Currency.eur,
      ),
    );
    final MoneyTransaction transaction3 = MoneyTransaction(
      dateTime: DateTime(2020, 2, 27, 13, 27),
      description: 'Transaction 3',
      id: 'unique id',
      expenseOrIncome: ExpenseOrIncome.income,
      method: MoneyTransactionMethod.debitCard,
      value: const Money(
        amount: 15000,
        currency: Currency.eur,
      ),
    );
    final MoneyTransaction transaction4 = MoneyTransaction(
      dateTime: DateTime(2020, 2, 27, 13, 27),
      description: 'Transaction 4',
      id: 'unique id',
      expenseOrIncome: ExpenseOrIncome.income,
      method: MoneyTransactionMethod.applePay,
      value: const Money(
        amount: 10000.5,
        currency: Currency.eur,
      ),
    );

    expect(transaction1.compareTo(transaction2), 1);
    expect(transaction1.compareTo(transaction3), -1);
    expect(transaction1.compareTo(transaction4), -1);
  });
}
