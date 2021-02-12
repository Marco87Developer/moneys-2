import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enumerations/income_or_expense.dart';

void main() {
  test('string()', () {
    const ExpenseOrIncome incomeOrExpense1 = ExpenseOrIncome.expense;
    const ExpenseOrIncome incomeOrExpense2 = ExpenseOrIncome.income;

    expect(incomeOrExpense1.string(), 'expense');
    expect(incomeOrExpense2.string(), 'income');
  });

  test('From String to IncomeOrExpense', () {
    const String incomeOrExpense1 = 'expense';
    const String incomeOrExpense2 = 'income';

    expect(incomeOrExpense1.toExpenseOrIncome(), ExpenseOrIncome.expense);
    expect(incomeOrExpense2.toExpenseOrIncome(), ExpenseOrIncome.income);
  });
}
