import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enumerations/income_or_expense.dart';

void main() {
  test('string()', () {
    const IncomeOrExpense incomeOrExpense1 = IncomeOrExpense.expense;
    const IncomeOrExpense incomeOrExpense2 = IncomeOrExpense.income;

    expect(incomeOrExpense1.string(), 'expense');
    expect(incomeOrExpense2.string(), 'income');
  });

  test('From String to IncomeOrExpense', () {
    const String incomeOrExpense1 = 'expense';
    const String incomeOrExpense2 = 'income';

    expect(incomeOrExpense1.toIncomeOrExpense(), IncomeOrExpense.expense);
    expect(incomeOrExpense2.toIncomeOrExpense(), IncomeOrExpense.income);
  });
}
