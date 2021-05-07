import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geos/geos.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moneys/src/enumerations/expense_or_income.dart';

import '../enumerations/money_transaction_method.dart';
import 'money.dart';

const String _budgetNameKey = 'budgetName';
const String _dateTimeKey = 'dateTime';
const String _descriptionKey = 'description';
const String _idKey = 'id';
const String _expenseOrIncomeKey = 'expenseOrIncome';
const String _methodKey = 'method';
const String _placeKey = 'place';
const String _tagsKey = 'tags';
const String _valueKey = 'value';

/// This class models a representation of a money transaction.
///
@immutable
class MoneyTransaction implements Comparable {
  /// Representation of a money transaction.
  ///
  const MoneyTransaction({
    this.budgetName = '',
    required this.dateTime,
    required this.description,
    required this.expenseOrIncome,
    required this.id,
    required this.method,
    this.place = const Place(
      address: '',
      position: LatLng(0, 0),
      tags: [],
    ),
    List<String> tags = const [],
    required this.value,
  }) : _tags = tags;

  /// Creates an `MoneyTransaction` instance starting from a
  /// `Map<String, dynamic> map`.
  ///
  /// This can be useful for retrieving the instance in a database.
  ///
  MoneyTransaction.fromMap(Map<String, dynamic> map)
      : budgetName = map[_budgetNameKey],
        dateTime = DateTime.parse('${map[_dateTimeKey]}'),
        description = map[_descriptionKey],
        id = map[_idKey],
        expenseOrIncome = '${map[_expenseOrIncomeKey]}'.toExpenseOrIncome(),
        method = '${map[_methodKey]}'.toMoneyTransactionMethod(),
        place = Place.fromMap(map[_placeKey]),
        _tags = (map[_tagsKey] as List<dynamic>).map((e) => '$e').toList(),
        value = '${map[_valueKey]}'.toMoney();

  /// The name of the budget associated with this transaction.
  final String budgetName;

  /// The date and time when this transaction is made.
  final DateTime dateTime;

  /// The description of this transaction.
  final String description;

  /// Indicates whether this transaction is an expense or an income.
  final ExpenseOrIncome expenseOrIncome;

  /// The identificator of this transaction. It should be unique.
  final String id;

  /// The method used for this transaction.
  final MoneyTransactionMethod method;

  /// The place where the transaction occured.
  final Place place;

  /// The tags associated with this place.
  final List<String> _tags;

  /// The value, or amount, of this transaction.
  final Money value;

  /// Returns the sorted list of [tags], each of which with only 1 occurrence.
  List<String> get tags =>
      List.unmodifiable(SplayTreeSet<String>.from(_tags).toList());

  /// Add a [tag] to the list of the tags for this place.
  void addTag(String tag) {
    if (!_tags.contains(tag)) {
      _tags.add(tag);
    }
    _tags.sort();
  }

  /// Creates a copy of this `MoneyTransaction` instance where the only changes
  /// are those specified in the parameters of this method.
  ///
  MoneyTransaction copyWith({
    DateTime? dateTime,
    String? description,
    ExpenseOrIncome? expenseOrIncome,
    String? id,
    MoneyTransactionMethod? method,
    Money? value,
  }) =>
      MoneyTransaction(
        dateTime: dateTime ?? this.dateTime,
        description: description ?? this.description,
        expenseOrIncome: expenseOrIncome ?? this.expenseOrIncome,
        id: id ?? this.id,
        method: method ?? this.method,
        value: value ?? this.value,
      );

  /// Creates a `Map<String, dynamic> map` representation of this instance.
  ///
  /// This can be useful for saving the instance in a database.
  ///
  Map<String, dynamic> toMap() => {
        _budgetNameKey: budgetName,
        _dateTimeKey: dateTime.toIso8601String(),
        _descriptionKey: description,
        _idKey: id,
        _expenseOrIncomeKey: expenseOrIncome.string(),
        _methodKey: method.string(),
        _placeKey: place.toMap(),
        _tagsKey: tags,
        _valueKey: '$value',
      };

  /// The order of the comparisons is:
  ///
  /// 1. [dateTime]
  /// 2. [description]
  /// 3. [place]
  /// 4. [value]
  /// 5. [method]
  /// 6. [id]
  ///
  @override
  int compareTo(covariant MoneyTransaction other) {
    // 1º comparison
    final int comparison1 = dateTime.compareTo(other.dateTime);
    if (comparison1 != 0) return comparison1;

    // 2º comparison
    final int comparison2 = description.compareTo(other.description);
    if (comparison2 != 0) return comparison2;

    // 3º comparison
    final int comparison3 = place.compareTo(other.place);
    if (comparison3 != 0) return comparison3;

    // 4º comparison
    final int comparison4 = value.compareTo(other.value);
    if (comparison4 != 0) return comparison4;

    // 5º comparison
    final int comparison5 = method.string().compareTo(other.method.string());
    if (comparison5 != 0) return comparison5;

    // Last comparison
    final int comparison6 = id.compareTo(other.id);
    return comparison6;
  }

  @override
  int get hashCode => hashValues(budgetName, dateTime, description, id,
      expenseOrIncome, method, place, value);

  /// Returns if this instance is less than the [other].
  ///
  bool operator <(covariant MoneyTransaction other) => compareTo(other) < 0;

  /// Return if this instance is less than or equal to the [other].
  ///
  bool operator <=(covariant MoneyTransaction other) => compareTo(other) <= 0;

  @override
  bool operator ==(covariant MoneyTransaction other) => compareTo(other) == 0;

  /// Return if this instance is greater than or equal to the [other].
  ///
  bool operator >=(covariant MoneyTransaction other) => compareTo(other) >= 0;

  /// Return if this instance is greater than the [other].
  ///
  bool operator >(covariant MoneyTransaction other) => compareTo(other) > 0;
}
