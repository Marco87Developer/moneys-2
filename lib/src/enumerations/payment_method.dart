import 'package:flutter/foundation.dart';

/// In this enumeration several payment methods are enumerated.
///
enum PaymentMethod {
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

/// This extension adds functionality to the `PaymentMethod` enumeration
/// values.
///
extension PaymentMethodX on PaymentMethod {
  /// Returns the corresponding string value of this `PaymentMethod` value.
  ///
  String string() => describeEnum(this);
}

/// This extension provides useful tools in order to convert a `String` into a
/// `PaymentMethod` value.
///
extension StringToPaymentMethodX on String {
  /// Converts this string into the corresponding `PaymentMethod` value.
  ///
  PaymentMethod toPaymentMethod() {
    for (final PaymentMethod paymentMethod in PaymentMethod.values)
      if (this == paymentMethod.string()) return paymentMethod;

    throw FormatException(
        'The string does not contains a valid PaymentMethod representation.');
  }
}
