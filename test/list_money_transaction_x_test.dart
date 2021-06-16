import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enumerations/currency.dart';
import 'package:moneys/src/enumerations/expense_or_income.dart';
import 'package:moneys/src/enumerations/money_transaction_method.dart';
import 'package:moneys/src/models/exchange_rate.dart';
import 'package:moneys/src/models/money.dart';
import 'package:moneys/src/models/money_transaction.dart';
import 'package:moneys/src/extensions/list_money_transaction_x.dart';

void main() {
  final transaction1 = MoneyTransaction(
    dateTime: DateTime(2021, 5, 7),
    description: 'Description 1',
    expenseOrIncome: ExpenseOrIncome.income,
    id: '2021-05-07',
    method: MoneyTransactionMethod.bankTransfer,
    value: const Money(
      amount: 1550,
      currency: Currency.eur,
    ),
  );
  final transaction2 = MoneyTransaction(
    dateTime: DateTime(2021, 5, 10),
    description: 'Description 2',
    expenseOrIncome: ExpenseOrIncome.expense,
    id: '2021-05-10',
    method: MoneyTransactionMethod.debitCard,
    value: const Money(
      amount: 500000,
      currency: Currency.cop,
    ),
  );
  final transaction3 = MoneyTransaction(
    dateTime: DateTime(2021, 5, 3),
    description: 'Description 3',
    expenseOrIncome: ExpenseOrIncome.income,
    id: '2021-05-03',
    method: MoneyTransactionMethod.bankTransfer,
    value: const Money(
      amount: 250000,
      currency: Currency.cop,
    ),
  );
  final transaction4 = MoneyTransaction(
    dateTime: DateTime(2021, 5, 4),
    description: 'Description 4',
    expenseOrIncome: ExpenseOrIncome.expense,
    id: '2021-05-04',
    method: MoneyTransactionMethod.creditCard,
    value: const Money(
      amount: 8.5,
      currency: Currency.usd,
    ),
  );

  final rateEurCop = ExchangeRate(
    dateTime: DateTime(2021, 5, 1),
    from: Currency.eur,
    to: Currency.cop,
    value: 4500,
  );
  final rateCopEur = ExchangeRate(
    dateTime: DateTime(2021, 5, 1),
    from: Currency.cop,
    to: Currency.eur,
    value: 1 / 4500,
  );
  final rateEurUsd = ExchangeRate(
    dateTime: DateTime(2021, 5, 7),
    from: Currency.eur,
    to: Currency.usd,
    value: 1.2,
  );
  final rateUsdEur = ExchangeRate(
    dateTime: DateTime(2021, 5, 7),
    from: Currency.usd,
    to: Currency.eur,
    value: 1 / 1.2,
  );
  final rateUsdCop = ExchangeRate(
    dateTime: DateTime(2021, 5, 5),
    from: Currency.usd,
    to: Currency.cop,
    value: 3800,
  );
  final rateCopUsd = ExchangeRate(
    dateTime: DateTime(2021, 5, 5),
    from: Currency.cop,
    to: Currency.usd,
    value: 1 / 3800,
  );

  test('addMoneyTransaction()', () {
    final List<MoneyTransaction> list = [
      transaction3,
      transaction2,
      transaction1,
    ];

    // ignore: cascade_invocations
    list.addMoneyTransaction(transaction4);

    expect(
      list,
      [
        transaction3,
        transaction4,
        transaction1,
        transaction2,
      ],
    );
  });

  test('compareTo()', () {
    final List<MoneyTransaction> list1 = [
      transaction1,
      transaction2,
    ];
    final List<MoneyTransaction> list2 = [
      transaction4,
      transaction1,
    ];
    final List<MoneyTransaction> list3 = [
      transaction3,
      transaction1,
      transaction2,
    ];
    final List<MoneyTransaction> list4 = [
      transaction2,
      transaction1,
    ];

    expect(list1.compareTo(list2), 1);
    expect(list2.compareTo(list1), -1);
    expect(list1.compareTo(list4), 0);
    expect(list2.compareTo(list3), -1);
  });

  test('toListOfMaps()', () {
    final List<MoneyTransaction> list1 = [
      transaction2,
      transaction1,
    ];
    final List<MoneyTransaction> list2 = <MoneyTransaction>[];

    expect(list2.toListOfMaps(), <Map<String, dynamic>>[]);

    expect(
      list1.toListOfMaps(),
      [
        {
          'budgetName': '',
          'dateTime': '2021-05-07T00:00:00.000',
          'description': 'Description 1',
          'id': '2021-05-07',
          'expenseOrIncome': 'income',
          'method': 'bank transfer',
          'place': {
            'address': '',
            'latitude': '0.000000000000',
            'longitude': '0.000000000000',
            'name': '',
            'tags': <String>[],
          },
          'tags': <String>[],
          'value': '1550.00 EUR',
        },
        {
          'budgetName': '',
          'dateTime': '2021-05-10T00:00:00.000',
          'description': 'Description 2',
          'id': '2021-05-10',
          'expenseOrIncome': 'expense',
          'method': 'debit card',
          'place': {
            'address': '',
            'latitude': '0.000000000000',
            'longitude': '0.000000000000',
            'name': '',
            'tags': <String>[],
          },
          'tags': <String>[],
          'value': '500000.00 COP',
        },
      ],
    );
  });

  test('total()', () {
    final list = [
      transaction3,
      transaction4,
      transaction1,
      transaction2,
    ];

    final rates = [
      rateCopEur,
      rateEurUsd,
      rateEurCop,
      rateUsdCop,
      rateUsdEur,
    ];

    final Money total = list.total(
      currency: Currency.eur,
      exchangeRates: rates,
    );

    const Money calculatedTotal = Money(
      amount: 1487.36,
      currency: Currency.eur,
    );
    expect(
      '$total',
      '$calculatedTotal',
    );

    final Money totalExpenses = list.total(
      currency: Currency.cop,
      exchangeRates: rates,
      expenseOrIncome: ExpenseOrIncome.expense,
    );
    const Money calculatedTotalExpenses = Money(
      amount: 532300,
      currency: Currency.cop,
    );
    expect(
      '$totalExpenses',
      '$calculatedTotalExpenses',
    );

    final Money totalExpensesBetween = list.total(
      currency: Currency.cop,
      exchangeRates: rates,
      expenseOrIncome: ExpenseOrIncome.expense,
      from: DateTime(2021, 5, 9),
      until: DateTime(2021, 5, 11),
    );
    const Money calculatedTotalExpensesBetween = Money(
      amount: 500000,
      currency: Currency.cop,
    );
    expect(
      '$totalExpensesBetween',
      '$calculatedTotalExpensesBetween',
    );

    expect(
      () => list.total(
        currency: Currency.eur,
        expenseOrIncome: ExpenseOrIncome.expense,
        from: DateTime(2021, 5, 9),
        until: DateTime(2021, 5, 11),
      ),
      throwsFormatException,
    );
  });

  test('whoseMethodWas()', () {
    final List<MoneyTransaction> list = [
      transaction1,
      transaction2,
      transaction3,
      transaction4,
    ];

    final rates = [
      rateCopEur,
    ];
    final transaction2Eur = MoneyTransaction(
      dateTime: DateTime(2021, 5, 10),
      description: 'Description 2',
      expenseOrIncome: ExpenseOrIncome.expense,
      id: '2021-05-10',
      method: MoneyTransactionMethod.debitCard,
      value: const Money(
        amount: 500000 / 4500,
        currency: Currency.eur,
      ),
    );

    expect(
      list.whoseMethodWas(method: MoneyTransactionMethod.debitCard),
      [transaction2],
    );
    expect(
      list.whoseMethodWas(method: MoneyTransactionMethod.bankTransfer),
      [transaction3, transaction1],
    );
    expect(
      list.whoseMethodWas(
        method: MoneyTransactionMethod.debitCard,
        normalized: true,
        currency: Currency.eur,
        exchangeRates: rates,
      ),
      [transaction2Eur],
    );
  });

  test('withValueEqualTo', () {
    final List<MoneyTransaction> list = [
      transaction1,
      transaction2,
      transaction3,
      transaction4,
    ];

    final rates = [
      rateCopEur,
      rateUsdEur,
    ];

    expect(
      list.withValueEqualTo(
        exchangeRates: rates,
        value: const Money(
          amount: 500000 / 4500,
          currency: Currency.eur,
        ),
      ),
      [transaction2],
    );
  });

  test('withValueGreaterThan', () {
    final List<MoneyTransaction> list = [
      transaction1,
      transaction2,
      transaction3,
      transaction4,
    ];

    final rates = [
      rateEurCop,
      rateUsdCop,
    ];

    expect(
      list.withValueGreaterThan(
        exchangeRates: rates,
        value: const Money(
          amount: 500000,
          currency: Currency.cop,
        ),
      ),
      [transaction1],
    );
  });

  test('withValueGreaterThanOrEqualTo', () {
    final List<MoneyTransaction> list = [
      transaction1,
      transaction2,
      transaction3,
      transaction4,
    ];

    final rates = [
      rateEurCop,
      rateUsdCop,
    ];

    expect(
      list.withValueGreaterThanOrEqualTo(
        exchangeRates: rates,
        value: const Money(
          amount: 500000,
          currency: Currency.cop,
        ),
      ),
      [
        transaction1,
        transaction2,
      ],
    );
  });

  test('withValueLessThan()', () {
    final List<MoneyTransaction> list = [
      transaction1,
      transaction2,
      transaction3,
      transaction4,
    ];

    final rates = [
      rateEurCop,
      rateUsdCop,
      rateCopEur,
      rateUsdEur,
    ];

    expect(
      list.withValueLessThan(
        exchangeRates: rates,
        value: const Money(
          amount: 500000,
          currency: Currency.cop,
        ),
      ),
      [
        transaction3,
        transaction4,
      ],
    );
    expect(
      list.withValueLessThan(
        currency: Currency.eur,
        exchangeRates: rates,
        normalized: true,
        value: const Money(
          amount: 500000,
          currency: Currency.cop,
        ),
      ),
      [
        MoneyTransaction(
          dateTime: DateTime(2021, 5, 3),
          description: 'Description 3',
          expenseOrIncome: ExpenseOrIncome.income,
          id: '2021-05-03',
          method: MoneyTransactionMethod.bankTransfer,
          value: const Money(
            amount: 250000 / 4500,
            currency: Currency.eur,
          ),
        ),
        MoneyTransaction(
          dateTime: DateTime(2021, 5, 4),
          description: 'Description 4',
          expenseOrIncome: ExpenseOrIncome.expense,
          id: '2021-05-04',
          method: MoneyTransactionMethod.creditCard,
          value: const Money(
            amount: 8.5 / 1.2,
            currency: Currency.eur,
          ),
        ),
      ],
    );
  });

  test('withValueLessThanOrEqualTo()', () {
    final List<MoneyTransaction> list = [
      transaction1,
      transaction2,
      transaction3,
      transaction4,
    ];

    final rates = [
      rateEurCop,
      rateUsdCop,
      rateCopEur,
      rateUsdEur,
    ];

    expect(
      list.withValueLessThanOrEqualTo(
        exchangeRates: rates,
        value: const Money(
          amount: 500000,
          currency: Currency.cop,
        ),
      ),
      [
        transaction3,
        transaction4,
        transaction2,
      ],
    );
    expect(
      list.withValueLessThanOrEqualTo(
        currency: Currency.eur,
        exchangeRates: rates,
        normalized: true,
        value: const Money(
          amount: 500000,
          currency: Currency.cop,
        ),
      ),
      [
        MoneyTransaction(
          dateTime: DateTime(2021, 5, 3),
          description: 'Description 3',
          expenseOrIncome: ExpenseOrIncome.income,
          id: '2021-05-03',
          method: MoneyTransactionMethod.bankTransfer,
          value: const Money(
            amount: 250000 / 4500,
            currency: Currency.eur,
          ),
        ),
        MoneyTransaction(
          dateTime: DateTime(2021, 5, 4),
          description: 'Description 4',
          expenseOrIncome: ExpenseOrIncome.expense,
          id: '2021-05-04',
          method: MoneyTransactionMethod.creditCard,
          value: const Money(
            amount: 8.5 / 1.2,
            currency: Currency.eur,
          ),
        ),
        MoneyTransaction(
          dateTime: DateTime(2021, 5, 10),
          description: 'Description 2',
          expenseOrIncome: ExpenseOrIncome.expense,
          id: '2021-05-10',
          method: MoneyTransactionMethod.debitCard,
          value: const Money(
            amount: 500000 / 4500,
            currency: Currency.eur,
          ),
        ),
      ],
    );
  });
}
