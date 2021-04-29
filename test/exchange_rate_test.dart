import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enumerations/currency.dart';
import 'package:moneys/src/models/exchange_rate.dart';

void main() {
  test('ExchangeRate.fromMap()', () {
    final Map<String, dynamic> map = {
      'from': Currency.eur.string(),
      'to': Currency.cop.string(),
      'value': 4200.755,
    };

    expect(
      ExchangeRate.fromMap(map),
      ExchangeRate(
        from: Currency.eur,
        to: Currency.cop,
        value: 4200.755,
      ),
    );
  });

  test('ExchangeRate.toMap()', () {
    final exchangeRate = ExchangeRate(
      from: Currency.eur,
      to: Currency.cop,
      value: 4200.755,
    );

    expect(
      exchangeRate.toMap(),
      {
        'from': Currency.eur.string(),
        'to': Currency.cop.string(),
        'value': 4200.755,
      },
    );
  });
}
