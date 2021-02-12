import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enumerations/currency.dart';
import 'package:moneys/src/enumerations/income_or_expense.dart';
import 'package:moneys/src/enumerations/payment_method.dart';
import 'package:moneys/src/enumerations/renewal.dart';
import 'package:moneys/src/models/budget.dart';
import 'package:moneys/src/models/money.dart';
import 'package:moneys/src/models/payment.dart';
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

  final List<Map<String, dynamic>> paymentsListOfMaps = [
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

  final List<Map<String, dynamic>> orderedPaymentsListOfMaps = [
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

  final Map<String, dynamic> map = {
    'name': 'budget name',
    'payments': paymentsListOfMaps,
    'renewal': 'annual',
    'size': '50000.00 EUR',
    'start': '2020-01-10T00:00:00.000',
  };

  final Budget budgetAnnual = Budget(
    name: 'budget name',
    payments: payments,
    renewal: Renewal.annual,
    size: Money(amount: 50000, currency: Currency.eur),
    start: DateTime(2020, 1, 10),
  );

  final Budget budgetDaily = Budget(
    name: 'budget name 2',
    payments: payments,
    renewal: Renewal.daily,
    size: Money(amount: 10000, currency: Currency.eur),
    start: DateTime(2020, 1, 10),
  );

  final Budget budgetWeekly = Budget(
    name: 'budget',
    payments: payments,
    renewal: Renewal.weekly,
    size: Money(amount: 70000, currency: Currency.eur),
    start: DateTime(2020, 1, 10),
  );

  final Budget budgetMonthly = Budget(
    name: 'budget name',
    payments: payments,
    renewal: Renewal.monthly,
    size: Money(amount: 70000, currency: Currency.eur),
    start: DateTime(2020, 1, 5),
  );

  test('Budget.fromMap()', () {
    payments..add(payment1)..add(payment2)..add(payment3)..add(payment4);

    expect(Budget.fromMap(map), budgetAnnual);
  });

  test('To toMap()', () {
    payments..add(payment1)..add(payment2)..add(payment3)..add(payment4);

    expect(budgetAnnual.toMap(), {
      'name': 'budget name',
      'payments': orderedPaymentsListOfMaps,
      'renewal': 'annual',
      'size': '50000.00 EUR',
      'start': '2020-01-10T00:00:00.000',
    });
  });

  test('lastRenewal()', () {
    /// Renewal.annual
    expect(budgetAnnual.lastRenewal(), DateTime(2020, 1, 10));
    expect(
      budgetAnnual.lastRenewal(from: DateTime(2021, 1, 15)),
      DateTime(2021, 1, 10),
    );

    /// Renewal.daily
    expect(
      budgetDaily.lastRenewal(from: DateTime(2020, 1, 15)),
      DateTime(2020, 1, 15),
    );

    /// Renewal.monthly
    expect(
      budgetMonthly.lastRenewal(from: DateTime(2020, 2, 4)),
      DateTime(2020, 1, 5),
    );
    expect(
      budgetMonthly.lastRenewal(from: DateTime(2020, 2, 27)),
      DateTime(2020, 2, 5),
    );

    /// Renewal.weekly
    expect(
      budgetWeekly.lastRenewal(from: DateTime(2020, 1, 16)),
      DateTime(2020, 1, 10),
    );
    expect(
      budgetWeekly.lastRenewal(from: DateTime(2021, 1, 3)),
      DateTime(2021, 1, 1),
    );
    expect(
      budgetWeekly.lastRenewal(from: DateTime(2021, 1, 15)),
      DateTime(2021, 1, 15),
    );
  });

  test('nextRenewal()', () {
    /// Renewal.annual
    expect(budgetAnnual.nextRenewal(), DateTime(2021, 1, 10));
    expect(
      budgetAnnual.nextRenewal(from: DateTime(2021, 1, 10)),
      DateTime(2022, 1, 10),
    );

    // Renewal.daily
    expect(
      budgetDaily.nextRenewal(from: DateTime(2020, 12, 31)),
      DateTime(2021, 1, 1),
    );

    /// Renewal.monthly
    expect(
      budgetMonthly.nextRenewal(from: DateTime(2020, 1, 5)),
      DateTime(2020, 2, 5),
    );
    expect(
      budgetMonthly.nextRenewal(from: DateTime(2020, 2, 7)),
      DateTime(2020, 3, 5),
    );

    /// Renewal.weekly
    expect(
      budgetWeekly.nextRenewal(from: DateTime(2020, 1, 16)),
      DateTime(2020, 1, 17),
      reason: 'Weekly 1',
    );
    expect(
      budgetWeekly.nextRenewal(from: DateTime(2021, 1, 3)),
      DateTime(2021, 1, 8),
      reason: 'Weekly 2',
    );
    expect(
      budgetWeekly.nextRenewal(from: DateTime(2021, 1, 15)),
      DateTime(2021, 1, 22),
      reason: 'Weekly 3',
    );
  });

  test('daysBetweenRenewals()', () {
    /// Renewal.annual
    expect(budgetAnnual.daysBetweenRenewals(), 366);
    expect(budgetAnnual.daysBetweenRenewals(from: DateTime(2022, 1, 10)), 365);
    expect(budgetAnnual.daysBetweenRenewals(from: DateTime(2022, 1, 11)), 365);

    /// Renewal.daily
    expect(budgetDaily.daysBetweenRenewals(from: DateTime(2020, 12, 31)), 1);

    /// Renewal.monthly
    expect(budgetMonthly.daysBetweenRenewals(from: DateTime(2020, 1, 3)), 31);
    expect(budgetMonthly.daysBetweenRenewals(from: DateTime(2021, 2, 7)), 28);

    /// Renewal.weekly
    expect(budgetWeekly.daysBetweenRenewals(from: DateTime(2020, 1, 1)), 7);
    expect(budgetWeekly.daysBetweenRenewals(from: DateTime(2021, 2, 1)), 7);
    expect(budgetWeekly.daysBetweenRenewals(from: DateTime(2022, 5, 7)), 7);
  });

  test('spent() and earned()', () {
    payments..add(payment1)..add(payment2)..add(payment3)..add(payment4);

    expect(budgetAnnual.spent(), Money(amount: 20000, currency: Currency.eur));
    expect(
      budgetAnnual.spent(until: DateTime(2020, 3, 1)),
      Money(amount: 5000, currency: Currency.eur),
    );
    expect(
      budgetAnnual.spent(from: DateTime(2020, 3, 15)),
      Money(amount: 15000, currency: Currency.eur),
    );
    expect(
      budgetAnnual.earned(
          from: DateTime(2020, 1, 1), until: DateTime(2020, 2, 16)),
      Money(amount: 15000, currency: Currency.eur),
    );
  });

  test('compareTo()', () {
    payments..add(payment1)..add(payment2)..add(payment3)..add(payment4);

    expect(budgetAnnual.compareTo(budgetDaily), -1);
    expect(budgetAnnual.compareTo(budgetWeekly), 1);
    expect(budgetAnnual.compareTo(budgetMonthly), 1);
  });
}
