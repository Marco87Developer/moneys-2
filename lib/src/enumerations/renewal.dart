import 'package:flutter/foundation.dart';

/// The values in this enumeration are used to determine the period after which
/// a certain amount is renewed (for example, a budget).
///
enum Renewal {
  /// Annual
  annual,

  /// Daily
  daily,

  /// Monthly
  monthly,

  /// Weekly
  weekly,
}

/// This extension adds functionality to the `Renewal` enumeration values.
///
extension RenewalX on Renewal {
  /// Returns the corresponding string value of this `Renewal` value.
  ///
  String string() => describeEnum(this);

  /// Returns the corresponding `double` value of this `Renewal` value.
  ///
  double value() {
    switch (this) {
      case Renewal.annual:
        return 365.25;
      case Renewal.daily:
        return 1;
      case Renewal.monthly:
        return 365.25 / 12;
      case Renewal.weekly:
        return 7;
    }
  }
}

/// This extension provides useful tools in order to convert a `String` into a
/// `Renewal` value.
///
extension StringToRenewalX on String {
  /// Converts this string into the corresponding `Renewal` value.
  ///
  Renewal toRenewal() {
    for (final Renewal renewal in Renewal.values)
      if (this == renewal.string()) return renewal;

    throw const FormatException(
        'The string does not contains a valid Renewal representation.');
  }
}
