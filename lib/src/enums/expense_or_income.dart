/// An **expense** or **income**.
///
/// This value is used to mark a monetary transaction as an **expense** or
/// **income**.
///
enum ExpenseOrIncome {
  /// Expense
  expense,

  /// Income
  income,
}

/// This extension adds features to the [ExpenseOrIncome] enum.
///
extension ExpenseOrIncomeExtension on ExpenseOrIncome {
  /// Compares this [ExpenseOrIncome] value to [other].
  ///
  /// Returns a **negative** value if this [ExpenseOrIncome] value is ordered
  /// before [other], a **positive** value if this [ExpenseOrIncome] value is
  /// ordered after [other], or **zero** if this [ExpenseOrIncome] value and
  /// [other] are equivalent.
  ///
  /// The comparison is made **based on the [name] property** of these two
  /// [ExpenseOrIncome] values and is **not case sensitive**.
  ///
  /// Examples:
  ///
  /// ```dart
  /// ExpenseOrIncome.expense.compareTo(ExpenseOrIncome.income) // isNegative
  /// ExpenseOrIncome.expense.compareTo(ExpenseOrIncome.expense) // isZero
  /// ExpenseOrIncome.income.compareTo(ExpenseOrIncome.expense) // isPositive
  /// ```
  ///
  int compareTo(final ExpenseOrIncome other) =>
      name.toLowerCase().compareTo(other.name.toLowerCase());
}

/// This extension adds functionality to the [String] class so that **a string
/// can be converted to the corresponding [ExpenseOrIncome] value**.
///
extension StringToExpenseOrIncomeExtension on String {
  /// Returns **the value of [ExpenseOrIncome] corresponding to this string**.
  ///
  /// Throws a [FormatException] if this string is not a valid representation of
  /// a value of [ExpenseOrIncome]. This string is a valid representation of a
  /// value of [ExpenseOrIncome] if it matches the result of
  /// `ExpenseOrIncome.name`.
  ///
  /// This method is **not case sensitive** and **does not take into account
  /// leading and trailing white spaces**.
  ///
  /// Examples:
  ///
  /// ```dart
  /// 'expense'.toExpenseOrIncome() // ExpenseOrIncome.expense
  /// 'EXPENSE'.toExpenseOrIncome() // ExpenseOrIncome.expense
  /// ' expense '.toExpenseOrIncome() // ExpenseOrIncome.expense
  /// ' EXPENSE '.toExpenseOrIncome() // ExpenseOrIncome.expense
  /// 'NotValidString'.toExpenseOrIncome() // Throws a [FormatException]
  /// ```
  ///
  ExpenseOrIncome toExpenseOrIncome() {
    final String trimmedLowerCase = trim().toLowerCase();
    for (final ExpenseOrIncome expenseOrIncome in ExpenseOrIncome.values) {
      if (trimmedLowerCase == expenseOrIncome.name.toLowerCase()) {
        return expenseOrIncome;
      }
    }
    throw FormatException(
      'This string (${this}) contains no valid (or unique) representation of a'
      ' [ExpenseOrIncome] value.',
    );
  }
}
