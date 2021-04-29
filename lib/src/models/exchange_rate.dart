import 'package:flutter/material.dart';

import '../enumerations/currency.dart';

const String _fromKey = 'from';
const String _toKey = 'to';
const String _valueKey = 'value';

/// This class models a reference to a money.
///
@immutable
class ExchangeRate implements Comparable {
  /// A reference exchange rate from [from] currency to [to] currency.
  ///
  const ExchangeRate({
    required this.from,
    required this.to,
    required this.value,
  });

  /// Creates an `Money` instance starting from a `Map<String, dynamic> map`.
  ///
  /// This can be useful for retrieving the instance from a database.
  ///
  ExchangeRate.fromMap(Map<String, dynamic> map)
      : from = '${map[_fromKey]}'.toCurrency(),
        to = '${map[_toKey]}'.toCurrency(),
        value = map[_valueKey];

  /// The base currency.
  final Currency from;

  /// target currency.
  final Currency to;

  /// The value of the exchange rate.
  final double value;

  /// Creates a `Map<String, dynamic> map` representation of this instance.
  ///
  /// This can be useful for saving the instance in a database.
  ///
  Map<String, dynamic> toMap() => {
        _fromKey: from.string(),
        _toKey: to.string(),
        _valueKey: value,
      };

  /// The order of the comparisons is:
  ///
  /// 1. [from]
  /// 2. [to]
  /// 3. [value]
  ///
  @override
  int compareTo(covariant ExchangeRate other) {
    // 1º comparison
    final int comparison1 = from.string().compareTo(other.from.string());
    if (comparison1 != 0) return comparison1;

    // 2º comparison
    final int comparison2 = to.string().compareTo(other.to.string());
    if (comparison2 != 0) return comparison2;

    // Last comparison
    final int comparison3 = value.compareTo(other.value);
    return comparison3;
  }

  @override
  int get hashCode => hashValues(from, to, value);

  /// Returns if this instance is less than the [other].
  ///
  bool operator <(covariant ExchangeRate other) => compareTo(other) < 0;

  /// Return if this instance is less than or equal to the [other].
  ///
  bool operator <=(covariant ExchangeRate other) => compareTo(other) <= 0;

  @override
  bool operator ==(covariant ExchangeRate other) => compareTo(other) == 0;

  /// Return if this instance is greater than or equal to the [other].
  ///
  bool operator >=(covariant ExchangeRate other) => compareTo(other) >= 0;

  /// Return if this instance is greater than the [other].
  ///
  bool operator >(covariant ExchangeRate other) => compareTo(other) > 0;
}
