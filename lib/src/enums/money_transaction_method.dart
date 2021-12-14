/// A **money transaction method**.
///
enum MoneyTransactionMethod {
  /// Apple Pay
  applepay,

  /// Bank transfer
  banktransfer,

  /// Cash
  cash,

  /// Coupon
  coupon,

  /// Credit card
  creditcard,

  /// Crypto currency
  cryptocurrency,

  /// Debit card
  debitcard,

  /// Google Pay
  googlepay,

  /// PayPal
  paypal,

  /// Prepaid card
  prepaidcard,

  /// Wire transfer
  wiretransfer,
}

/// This extension adds features to the [MoneyTransactionMethod] enum.
///
extension MoneyTransactionMethodExtension on MoneyTransactionMethod {
  /// The name (in English) of this money transaction method.
  ///
  /// Examples:
  ///
  /// ```dart
  /// MoneyTransactionMethod.applepay.denomination // 'Apple Pay'
  /// MoneyTransactionMethod.creditcard.denomination // 'credit card'
  /// MoneyTransactionMethod.cryptocurrency.denomination // 'cryptocurrency'
  /// MoneyTransactionMethod.googlepay.denomination // 'Google Pay'
  /// MoneyTransactionMethod.paypal.denomination // 'PayPal'
  /// ```
  ///
  String get denomination {
    switch (this) {
      case MoneyTransactionMethod.applepay:
        return 'Apple Pay';
      case MoneyTransactionMethod.banktransfer:
        return 'bank transfer';
      case MoneyTransactionMethod.cash:
        return 'cash';
      case MoneyTransactionMethod.coupon:
        return 'coupon';
      case MoneyTransactionMethod.creditcard:
        return 'credit card';
      case MoneyTransactionMethod.cryptocurrency:
        return 'cryptocurrency';
      case MoneyTransactionMethod.debitcard:
        return 'debit card';
      case MoneyTransactionMethod.googlepay:
        return 'Google Pay';
      case MoneyTransactionMethod.paypal:
        return 'PayPal';
      case MoneyTransactionMethod.prepaidcard:
        return 'prepaid card';
      case MoneyTransactionMethod.wiretransfer:
        return 'wire transfer';
    }
  }

  /// Compares this method to [other].
  ///
  /// Returns a **negative** value if this method is ordered before [other], a
  /// **positive** value if this method is ordered after [other], or **zero** if
  /// this method and [other] are equivalent.
  ///
  /// The comparison is made **based on the [name] property** of these two
  /// methods and is **not case sensitive**.
  ///
  /// Examples:
  ///
  /// ```dart
  /// MoneyTransactionMethod.applepay.compareTo(MoneyTransactionMethod.banktransfer) // isNegative
  /// MoneyTransactionMethod.applepay.compareTo(MoneyTransactionMethod.applepay) // isZero
  /// MoneyTransactionMethod.banktransfer.compareTo(MoneyTransactionMethod.applepay) // isPositive
  /// ```
  ///
  int compareTo(final MoneyTransactionMethod other) =>
      name.toLowerCase().compareTo(other.name.toLowerCase());
}

/// This extension adds functionality to the [String] class so that **a string
/// can be converted to the corresponding [MoneyTransactionMethod] value**.
///
extension StringToMoneyTransactionMethodExtension on String {
  /// Returns **the value of [MoneyTransactionMethod] corresponding to this
  /// string**.
  ///
  /// Throws a [FormatException] if this string is not a valid representation of
  /// a value of [MoneyTransactionMethod]. This string is a valid representation
  /// of a value of [MoneyTransactionMethod] if it matches one of the following
  /// values:
  ///
  /// * The result of `MoneyTransactionMethod.denomination`.
  /// * The result of `MoneyTransactionMethod.name`.
  ///
  /// This method is **not case sensitive** and **does not take into account
  /// leading and trailing white spaces**.
  ///
  /// Examples:
  ///
  /// ```dart
  /// 'wiretransfer'.toMoneyTransactionMethod() // MoneyTransactionMethod.wiretransfer
  /// 'WIRETRANSFER'.toMoneyTransactionMethod() // MoneyTransactionMethod.wiretransfer
  /// ' wiretransfer '.toMoneyTransactionMethod() // MoneyTransactionMethod.wiretransfer
  /// ' WIRETRANSFER '.toMoneyTransactionMethod() // MoneyTransactionMethod.wiretransfer
  /// 'wire transfer'.toMoneyTransactionMethod() // MoneyTransactionMethod.wiretransfer
  /// 'WIRE TRANSFER'.toMoneyTransactionMethod() // MoneyTransactionMethod.wiretransfer
  /// ' wire transfer '.toMoneyTransactionMethod() // MoneyTransactionMethod.wiretransfer
  /// ' WIRE TRANSFER '.toMoneyTransactionMethod() // MoneyTransactionMethod.wiretransfer
  /// 'NotValidString'.toExpenseOrIncome() // Throws a [FormatException]
  /// ```
  ///
  MoneyTransactionMethod toMoneyTransactionMethod() {
    final String trimmedLowerCase = trim().toLowerCase();
    for (final MoneyTransactionMethod method in MoneyTransactionMethod.values) {
      if (trimmedLowerCase == method.denomination ||
          trimmedLowerCase == method.name.toLowerCase()) {
        return method;
      }
    }
    throw FormatException(
      'This string (${this}) contains no valid (or unique) representation of a'
      ' [MoneyTransactionMethod] value.',
    );
  }
}
