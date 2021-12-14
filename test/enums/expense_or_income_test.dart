import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enums/expense_or_income.dart';

void main() {
  group('The transitive and the symmetric property', () {
    test(
      'The transitive property: if [b] = [a] and [c] = [b], then [c] = [a].',
      () {
        for (final ExpenseOrIncome discountFirst in ExpenseOrIncome.values) {
          final ExpenseOrIncome a = discountFirst;
          final ExpenseOrIncome b = a;
          final ExpenseOrIncome c = b;
          expect(c, equals(a));
        }
      },
    );

    test(
      'The symmetric property: if [a] = [b], then [b] = [a].',
      () {
        for (final ExpenseOrIncome discountFirst in ExpenseOrIncome.values) {
          final ExpenseOrIncome a = discountFirst;
          final ExpenseOrIncome b = discountFirst;
          expect(a, equals(b));
          expect(b, equals(a));
        }
      },
    );
  });

  group('compareTo', () {
    test('The comparation is done based on the name property.', () {
      expect(
        ExpenseOrIncome.expense.compareTo(ExpenseOrIncome.income),
        isNegative,
      );
      expect(
        ExpenseOrIncome.expense.compareTo(ExpenseOrIncome.expense),
        isZero,
      );
      expect(
        ExpenseOrIncome.income.compareTo(ExpenseOrIncome.expense),
        isPositive,
      );
    });
  });

  group('toExpenseOrIncome (StringToExpenseOrIncomeExtension)', () {
    test(
      'If the string is not a valid representation of a value of'
      ' [ExpenseOrIncome], throws a [FormatException] with the not valid string'
      ' in the message.',
      () {
        const String notValidString = 'NotValidString';
        expect(
          () => notValidString.toExpenseOrIncome(),
          throwsA(
            isA<FormatException>().having(
              (final e) => e.message,
              'message',
              contains(notValidString),
            ),
          ),
        );
        expect(
          () => notValidString.toExpenseOrIncome(),
          throwsA(
            isA<FormatException>().having(
              (final e) => e.message,
              'message',
              contains('no valid'),
            ),
          ),
        );
        expect(
          () => notValidString.toExpenseOrIncome(),
          throwsA(
            isA<FormatException>().having(
              (final e) => e.message,
              'message',
              contains('ExpenseOrIncome'),
            ),
          ),
        );
      },
    );
    test(
      'The string is a valid representation of a value of [ExpenseOrIncome] if'
      ' coincides with the result of [name].',
      () {
        expect(
          'expense'.toExpenseOrIncome(),
          equals(ExpenseOrIncome.expense),
        );
        expect(
          'EXPENSE'.toExpenseOrIncome(),
          equals(ExpenseOrIncome.expense),
        );
        expect(
          ' expense '.toExpenseOrIncome(),
          equals(ExpenseOrIncome.expense),
        );
        expect(
          ' EXPENSE '.toExpenseOrIncome(),
          equals(ExpenseOrIncome.expense),
        );
      },
    );
  });
}
