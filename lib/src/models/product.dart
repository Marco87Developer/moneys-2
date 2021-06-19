import 'package:flutter/material.dart';
import 'package:geos/geos.dart';

import '../../moneys.dart';

const _brandKey = 'brand';
const _categoryKey = 'category';
const _costKey = 'cost';
const _descriptionKey = 'description';
const _idKey = 'id';
const _nameKey = 'name';
const _originKey = 'origin';
const _priceKey = 'price';

/// This class models a reference to a product.
///
@immutable
class Product implements Comparable<Product> {
  /// Models a product.
  ///
  const Product({
    required this.brand,
    required this.category,
    required this.cost,
    this.description = '',
    required this.id,
    required this.name,
    this.origin,
    required this.price,
  });

  /// Creates an `Product` instance starting from a `Map<String, dynamic> map`.
  ///
  /// This can be useful for retrieving the instance from a database.
  ///
  Product.fromMap(Map<String, dynamic> map)
      : brand = map[_brandKey] as String,
        category = map[_categoryKey] as String,
        cost = '${map[_costKey]}'.toMoney(),
        description = map[_descriptionKey] as String,
        id = map[_idKey] as String,
        name = map[_nameKey] as String,
        origin = '${map[_originKey]}'.toCountry(),
        price = '${map[_priceKey]}'.toMoney();

  /// The company that made this product.
  final String brand;

  /// The category.
  final String category;

  /// The cost of purchasing this product.
  final Money cost;

  /// The description. For example, it may contain technical details, or advice
  /// on use.
  final String description;

  /// The identifier. It should be unique.
  final String id;

  /// The name that .
  final String name;

  /// The country of origin of this product.
  final Country? origin;

  /// The selling price.
  final Money price;

  /// Creates a copy of this `Product` instance where the only changes are those
  /// specified in the parameters of this method.
  ///
  Product copyWith({
    String? brand,
    String? category,
    Money? cost,
    String? description,
    String? id,
    String? name,
    Country? origin,
    Money? price,
  }) =>
      Product(
        brand: brand ?? this.brand,
        category: category ?? this.category,
        cost: cost ?? this.cost,
        description: description ?? this.description,
        id: id ?? this.id,
        name: name ?? this.name,
        origin: origin ?? this.origin,
        price: price ?? this.price,
      );

  /// Creates a `Map<String, dynamic> map` representation of this instance.
  ///
  /// This can be useful for saving the instance in a database.
  ///
  Map<String, dynamic> toMap() => <String, dynamic>{
        _brandKey: brand,
        _categoryKey: category,
        _costKey: '$cost',
        _descriptionKey: description,
        _idKey: id,
        _nameKey: name,
        _originKey: origin?.string(),
        _priceKey: '$price',
      };

  /// The order of the comparisons is:
  ///
  /// 1. [name]
  /// 2. [cost]
  ///
  /// The two currencies must be the same.
  ///
  @override
  int compareTo(covariant Product other) {
    // 1º comparison
    final int comparison1 = name.compareTo(other.name);
    if (comparison1 != 0) return comparison1;

    // Last comparison
    final int comparison2 = cost.compareTo(other.cost);
    return comparison2;
  }

  @override
  int get hashCode => hashValues(
        brand,
        category,
        cost,
        description,
        id,
        name,
        origin,
        price,
      );

  /// Returns if this instance is less than the [other].
  ///
  bool operator <(covariant Product other) => compareTo(other) < 0;

  /// Return if this instance is less than or equal to the [other].
  ///
  bool operator <=(covariant Product other) => compareTo(other) <= 0;

  @override
  bool operator ==(covariant Product other) => compareTo(other) == 0;

  /// Return if this instance is greater than or equal to the [other].
  ///
  bool operator >=(covariant Product other) => compareTo(other) >= 0;

  /// Return if this instance is greater than the [other].
  ///
  bool operator >(covariant Product other) => compareTo(other) > 0;
}
