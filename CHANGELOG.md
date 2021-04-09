# 1.2.0

<sup><sub>Release date: 2021-04-09.</sub></sup>

* Updated dependencies.
* **Breaking change.** Changed `TransactionMethod` enumeration name into `MoneyTransactionMethod` in order to contextualize the term “transaction”.

# 1.1.0

<sup><sub>Release date: 2021-02-23.</sub></sup>

* **Breaking change.** Changed the `Payment` class name into `Transaction`. This is because the word “payment” conveys the idea of an expense, while the `Payment` class aims to represent both expenses and income.
* Added `String budgetName`, `String description`, `Place place` (`Place` class id from [geos](https://pub.dev/packages/geos) package) and `List<String> tags` fields to the `Transaction` class.

# 1.0.1

<sup><sub>Release date: 2021-02-19.</sub></sup>

* Changed the `string()` extension method for `PaymentMethod` enumeration.

# 1.0.0

<sup><sub>Release date: 2021-02-17.</sub></sup>

* Stable null safety release.

# 0.1.0-nullsafety.2

<sup><sub>Release date: 2021-02-12.</sub></sup>

* **Breaking change.** Changed `IncomeOrExpense` class name into `ExpenseOrIncome`.

# 0.1.0-nullsafety.1

<sup><sub>Release date: 2021-01-03.</sub></sup>

* First pre-release.
