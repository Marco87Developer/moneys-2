## [1.1.0] - 2021-02-23

* **Breaking change.** Changed the `Payment` class name into `Transaction`. This is because the word “payment” conveys the idea of an expense, while the `Payment` class aims to represent both expenses and income.
* Added `String budgetName`, `String description`, `Place place` (`Place` class id from [geos](https://pub.dev/packages/geos) package) and `List<String> tags` fields to the `Transaction` class.

## [1.0.1] - 2021-02-19

* Changed the `string()` extension method for `PaymentMethod` enumeration.

## [1.0.0] - 2021-02-17

* Stable null safety release.

## [0.1.0-nullsafety.2] - 2021-02-12

* **Breaking change.** Changed `IncomeOrExpense` class name into `ExpenseOrIncome`.

## [0.1.0-nullsafety.1] - 2021-01-03

* First pre-release.
