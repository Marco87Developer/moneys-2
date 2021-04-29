import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../enumerations/currency.dart';
import 'exchange_rate.dart';

const String _amountKey = 'amount';
const String _currencyKey = 'currency';

/// This class models a reference to a money.
///
@immutable
class Money implements Comparable {
  /// A reference to a money.
  ///
  const Money({
    required this.amount,
    required this.currency,
  });

  /// Creates an `Money` instance starting from a `Map<String, dynamic> map`.
  ///
  /// This can be useful for retrieving the instance from a database.
  ///
  Money.fromMap(Map<String, dynamic> map)
      : amount = map[_amountKey],
        currency = '${map[_currencyKey]}'.toCurrency();

  /// The amount or, the value, of this money.
  final double amount;

  /// The currency of this money.
  final Currency currency;

  /// Converts the value of this money to the currency expressed by [rate]`.to`.
  ///
  Money convert({
    required ExchangeRate rate,
  }) {
    if (rate.to == currency) return this;

    if (rate.from != currency)
      throw ArgumentError(
          'The base currency of the rate is different from the currency of this'
          ' money. Change the rate with one which has the same currency.');

    return Money(
      amount: amount * rate.value,
      currency: rate.to,
    );
  }

  /// Returns the money representation in order to show it in the UI.
  ///
  /// It be possible to utilize ‘[k] representation’ (for example, “10000” is
  /// rewritten as “10k”). Also, it be possible to change the [locale]
  /// parameter.
  ///
  /// (Using `'it_IT'` locale, for example, it will write the money
  /// representation using a [no-break space](https://unicode-table.com/en/00A0)
  /// between the [amount] and the [currency]).
  ///
  String show({
    bool k = false,
    String? locale,
  }) {
    final int decimalDigits = amount % 1 == 0 ? 0 : 1;

    final String value = NumberFormat.currency(
      decimalDigits: k ? decimalDigits : currency.exponent,
      locale: locale,
      name: currency.alphabetic,
      symbol: currency.symbol,
    ).format(k ? amount / 1000 : amount);

    return k ? '$value k' : value;
  }

  /// This is a shorthand for `show(k: true)`.
  ///
  /// It be possible to change the [locale] parameter.
  ///
  /// (Using `'it_IT'` locale, for example, it will write the money
  /// representation using a [no-break space](https://unicode-table.com/en/00A0)
  /// between the [amount] and the [currency]).
  ///
  String showK({
    String? locale,
  }) =>
      show(
        k: true,
        locale: locale,
      );

  /// Creates a `Map<String, dynamic> map` representation of this instance.
  ///
  /// This can be useful for saving the instance in a database.
  ///
  Map<String, dynamic> toMap() => {
        _amountKey: amount,
        _currencyKey: currency.string(),
      };

  /// The order of the comparisons is:
  ///
  /// 1. [amount]
  ///
  /// The two currencies must be the same.
  ///
  @override
  int compareTo(covariant Money other) {
    if (currency != other.currency)
      throw FormatException(
          'You cannot compare two moneys with different currencies. Before'
          ' comparing, convert one of them.');

    // Last comparison
    final int comparison1 = amount.compareTo(other.amount);
    return comparison1;
  }

  @override
  int get hashCode => hashValues(amount, currency);

  @override
  String toString() => '${amount.toStringAsFixed(currency.exponent ?? 0)}'
      ' ${currency.alphabetic}';

  /// Returns if this instance is less than the [other].
  ///
  bool operator <(covariant Money other) => compareTo(other) < 0;

  /// Return if this instance is less than or equal to the [other].
  ///
  bool operator <=(covariant Money other) => compareTo(other) <= 0;

  @override
  bool operator ==(covariant Money other) => compareTo(other) == 0;

  /// Return if this instance is greater than or equal to the [other].
  ///
  bool operator >=(covariant Money other) => compareTo(other) >= 0;

  /// Return if this instance is greater than the [other].
  ///
  bool operator >(covariant Money other) => compareTo(other) > 0;

  /// Defines the subtraction operator.
  ///
  Money operator -(covariant Money other) => other.currency != currency
      ? throw FormatException(
          'You cannot subtract a money with a currency from another money with'
          ' a different currency. Before subtracting, convert one of them.')
      : amount < other.amount
          ? throw FormatException(
              'You cannot subtract a money with an amount greater than this.')
          : Money(
              amount: amount - other.amount,
              currency: currency,
            );

  /// Defines the sum operator.
  ///
  Money operator +(covariant Money other) => other.currency != currency
      ? throw FormatException(
          'You cannot sum a money with a currency to another money with a'
          ' different currency. Before subtracting, convert one of them.')
      : Money(
          amount: amount + other.amount,
          currency: currency,
        );

  /// Defines the multiplication operator between a `num` [number] and a
  /// `Money`.
  ///
  Money operator *(covariant num number) => Money(
        amount: amount * number,
        currency: currency,
      );

  /// It defines the division operator, of a `Money` by a `num` [number].
  ///
  Money operator /(covariant num number) => Money(
        amount: amount / number,
        currency: currency,
      );
}

/// This extension provides useful tools in order to convert a `String` into a
/// `Money` instance.
///
extension StringToMoneyX on String {
  /// Converts this string into the corresponding `Money` instance.
  ///
  Money toMoney() {
    final List<String> strings = split(' ');

    return Money(
      amount: double.parse(strings[0]),
      currency: strings[1].toCurrency(),
    );
  }
}
