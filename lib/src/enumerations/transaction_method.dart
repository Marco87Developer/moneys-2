/// In this enumeration several money transaction methods are enumerated.
///
enum TransactionMethod {
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

/// This extension adds functionality to the `TransactionMethod` enumeration
/// values.
///
extension TransactionMethodX on TransactionMethod {
  /// Returns the corresponding string value of this `TransactionMethod` value.
  ///
  String string() {
    switch (this) {
      case TransactionMethod.applePay:
        return 'Apple Pay';
      case TransactionMethod.bankTransfer:
        return 'bank transfer';
      case TransactionMethod.cash:
        return 'cash';
      case TransactionMethod.creditCard:
        return 'credit card';
      case TransactionMethod.cryptoCurrency:
        return 'cryptocurrency';
      case TransactionMethod.debitCard:
        return 'debit card';
      case TransactionMethod.gPay:
        return 'Google Pay';
      case TransactionMethod.payPal:
        return 'PayPal';
      case TransactionMethod.prepaidCard:
        return 'prepaid card';
    }
  }
}

/// This extension provides useful tools in order to convert a `String` into a
/// `TransactionMethod` value.
///
extension StringToTransactionMethodX on String {
  /// Converts this string into the corresponding `TransactionMethod` value.
  ///
  TransactionMethod toTransactionMethod() {
    for (final TransactionMethod transactionMethod in TransactionMethod.values)
      if (this == transactionMethod.string()) return transactionMethod;

    throw FormatException(
        'The string does not contains a valid TransactionMethod '
        'representation.');
  }
}
