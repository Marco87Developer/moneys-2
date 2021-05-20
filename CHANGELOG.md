# 2.1.0

<sup><sub>Release date: 2021-05-20.</sub></sup>

* Removed [`pedantic`](https://pub.dev/packages/pedantic) developer dependency.
* This now uses the newer [`lints`](https://pub.dev/packages/lints) developer dependency.
* Minimum Dart SDK was updated to `2.13.0` version and Flutter to `2.0.0` version.

# 2.0.0

<sup><sub>Release date: 2021-05-07.</sub></sup>

* **Breaking change.** The `MoneyTransactions` class has been removed. The methods of that class are now available as extension methods for `List<MoneyTransaction>`.
* Added extension methods for `List<ExchangeRate>`.
* Now in the `whoseMethodWas` (extension method on `List<MoneyTransaction>`) method it is possible to return a normalized list. Also, the result is already sorted.
* The result of the following `List<MoneyTransaction>` extension methods is already normalized and sorted:
  * `withValueEqualTo`.
  * `withValueGreaterThan`.
  * `withValueGreaterThanOrEqualTo`.
  * `withValueLessThan`.
  * `withValueLessThanOrEqualTo`.

# 1.4.0

<sup><sub>Release date: 2021-05-06.</sub></sup>

* Added `copyWith` to the `Budget` class.
* Added `copyWith` to the `ExchangeRate` class.
* Added `copyWith` to the `Money` class.
* Added `copyWith` to the `MoneyTransaction` class.

# 1.3.5

<sup><sub>Release date: 2021-05-06.</sub></sup>

* Fixed a minor issue.

# 1.3.4

<sup><sub>Release date: 2021-05-06.</sub></sup>

* In the `MoneyTransaction.fromMap(Map<String, dynamic> map)` constructor, the `List<dynamic> map['tags']` list is now casted `as List<String>`.

# 1.3.3

<sup><sub>Release date: 2021-05-05.</sub></sup>

* Added `MoneyTransactions.fromListOfMoneyTransaction(List<MoneyTransaction> listOfMoneyTransaction)` constructor to the `MoneyTransactions` class.

# 1.3.2

<sup><sub>Release date: 2021-04-29.</sub></sup>

* Added `dateTime` property to `ExchangeRate` class. This represents the date and the time in which the rate was retrieved.

# 1.3.1+1

<sup><sub>Release date: 2021-04-29.</sub></sup>

* Exposed `ExchangeRate` class.

# 1.3.1

<sup><sub>Release date: 2021-04-29.</sub></sup>

* Added the `ExchangeRate` class. This class stores the rate value in order to convert a money of a currency into a money of another one.
* Added the `convert()` method to the `Money` class.

# 1.3.0

<sup><sub>Release date: 2021-04-22.</sub></sup>

* Changed `MoneyTransactions.fromListOfMaps(List<Map<String, dynamic>> listOfMaps)` method in order to accept a `List<dynamic> listOfMaps` parameter.
* Fixed money_transactions_test.

# 1.2.1

<sup><sub>Release date: 2021-04-12.</sub></sup>

* Changed `incomeOrExpense` `MoneyTransaction` property name into `expenseOrIncome`.

# 1.2.0

<sup><sub>Release date: 2021-04-09.</sub></sup>

* Updated dependencies.
* **Breaking change.** Changed `TransactionMethod` enumeration name into `MoneyTransactionMethod` in order to contextualize the term “transaction”.

# 1.1.0

<sup><sub>Release date: 2021-02-23.</sub></sup>

* **Breaking change.** Changed the `Payment` class name into `Transaction`. This is because the word “payment” conveys the idea of an expense, while the `Payment` class aims to represent both expenses and income.
* Added `String budgetName`, `String description`, `Place place` (`Place` class is from [geos](https://pub.dev/packages/geos) package) and `List<String> tags` fields to the `Transaction` class.

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
