/// In this enumeration several money transaction methods are enumerated.
///
enum MoneyTransactionMethod {
  /// Apple Pay
  applePay,

  /// Bank transfer
  bankTransfer,

  /// Cash
  cash,

  /// Credit card
  creditCard,

  /// Crypto currency
  cryptoCurrency,

  /// Debit card
  debitCard,

  /// Google Pay
  gPay,

  /// PayPal
  payPal,

  /// Prepaid card
  prepaidCard,
}

/// This extension adds functionality to the `MoneyTransactionMethod`
/// enumeration values.
///
extension MoneyTransactionMethodX on MoneyTransactionMethod {
  /// Returns the corresponding string value of this `MoneyTransactionMethod`
  /// value.
  ///
  String string() {
    switch (this) {
      case MoneyTransactionMethod.applePay:
        return 'Apple Pay';
      case MoneyTransactionMethod.bankTransfer:
        return 'bank transfer';
      case MoneyTransactionMethod.cash:
        return 'cash';
      case MoneyTransactionMethod.creditCard:
        return 'credit card';
      case MoneyTransactionMethod.cryptoCurrency:
        return 'cryptocurrency';
      case MoneyTransactionMethod.debitCard:
        return 'debit card';
      case MoneyTransactionMethod.gPay:
        return 'Google Pay';
      case MoneyTransactionMethod.payPal:
        return 'PayPal';
      case MoneyTransactionMethod.prepaidCard:
        return 'prepaid card';
    }
  }
}

/// This extension provides useful tools in order to convert a `String` into a
/// `MoneyTransactionMethod` value.
///
extension StringToMoneyTransactionMethodX on String {
  /// Converts this string into the corresponding `MoneyTransactionMethod`
  /// value.
  ///
  MoneyTransactionMethod toMoneyTransactionMethod() {
    for (final MoneyTransactionMethod moneyTransactionMethod
        in MoneyTransactionMethod.values)
      if (this == moneyTransactionMethod.string())
        return moneyTransactionMethod;

    throw const FormatException(
        'The string does not contains a valid MoneyTransactionMethod '
        'representation.');
  }
}
