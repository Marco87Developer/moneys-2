import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enumerations/expense_or_income.dart';

void main() {
  test('string()', () {
    const ExpenseOrIncome expenseOrIncome1 = ExpenseOrIncome.expense;
    const ExpenseOrIncome expenseOrIncome2 = ExpenseOrIncome.income;

    expect(expenseOrIncome1.string(), 'expense');
    expect(expenseOrIncome2.string(), 'income');
  });

  test('From String to ExpenseOrIncome', () {
    const String expenseOrIncome1 = 'expense';
    const String expenseOrIncome2 = 'income';

    expect(expenseOrIncome1.toExpenseOrIncome(), ExpenseOrIncome.expense);
    expect(expenseOrIncome2.toExpenseOrIncome(), ExpenseOrIncome.income);
  });
}
