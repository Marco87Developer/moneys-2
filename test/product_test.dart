import 'package:flutter_test/flutter_test.dart';
import 'package:geos/geos.dart';
import 'package:moneys/src/enumerations/currency.dart';
import 'package:moneys/src/models/money.dart';
import 'package:moneys/src/models/product.dart';

void main() {
  test('Product.fromMap()', () {
    const Map<String, dynamic> map1 = <String, dynamic>{
      'brand': 'Brand',
      'category': 'Category',
      'cost': '10000.55 AUD',
      'description': 'Description',
      'id': 'Id',
      'name': 'Name',
      'origin': 'Italy',
      'price': '20000.00 AUD',
    };

    expect(
      Product.fromMap(map1),
      const Product(
        brand: 'Brand',
        category: 'Category',
        cost: Money(amount: 10000.55, currency: Currency.aud),
        description: 'Description',
        id: 'Id',
        name: 'Name',
        origin: Country.italy,
        price: Money(amount: 20000, currency: Currency.aud),
      ),
    );
  });

  test('toMap()', () {
    const Product product1 = Product(
      brand: 'Brand',
      category: 'Category',
      cost: Money(amount: 10000.55, currency: Currency.aud),
      description: 'Description',
      id: 'Id',
      name: 'Name',
      origin: Country.italy,
      price: Money(amount: 20000, currency: Currency.aud),
    );

    expect(
      product1.toMap(),
      {
        'brand': 'Brand',
        'category': 'Category',
        'cost': '10000.55 AUD',
        'description': 'Description',
        'id': 'Id',
        'name': 'Name',
        'origin': 'Italy',
        'price': '20000.00 AUD',
      },
    );
  });

  test('@override compareTo()', () {
    const Product product1 = Product(
      brand: 'Brand',
      category: 'Category',
      cost: Money(amount: 10000.55, currency: Currency.aud),
      description: 'Description',
      id: 'Id',
      name: 'Name 1',
      origin: Country.italy,
      price: Money(amount: 20000, currency: Currency.aud),
    );
    const Product product2 = Product(
      brand: 'Brand',
      category: 'Category',
      cost: Money(amount: 20000, currency: Currency.aud),
      description: 'Description',
      id: 'Id',
      name: 'Name 2',
      origin: Country.italy,
      price: Money(amount: 25000, currency: Currency.aud),
    );
    const Product product3 = Product(
      brand: 'Brand',
      category: 'Category',
      cost: Money(amount: 25000, currency: Currency.aud),
      description: 'Description',
      id: 'Id',
      name: 'Name 2',
      origin: Country.italy,
      price: Money(amount: 30000, currency: Currency.aud),
    );

    expect(product1.compareTo(product1), 0);
    expect(product1.compareTo(product2), -1);
    expect(product2.compareTo(product3), -1);
  });

  test('<, <=, ==, >= and > operators', () {
    const Product product1 = Product(
      brand: 'Brand',
      category: 'Category',
      cost: Money(amount: 10000.55, currency: Currency.aud),
      description: 'Description',
      id: 'Id',
      name: 'Name 1',
      origin: Country.italy,
      price: Money(amount: 20000, currency: Currency.aud),
    );
    const Product product2 = Product(
      brand: 'Brand',
      category: 'Category',
      cost: Money(amount: 20000, currency: Currency.aud),
      description: 'Description',
      id: 'Id',
      name: 'Name 2',
      origin: Country.italy,
      price: Money(amount: 25000, currency: Currency.aud),
    );

    expect(product1 < product2, true);
    expect(product1 <= product2, true);
    expect(product1 == product2, false);
    expect(product1 >= product2, false);
    expect(product1 > product2, false);
  });
}
