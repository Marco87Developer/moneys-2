import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enumerations/currency.dart';
import 'package:moneys/src/models/exchange_rate.dart';

void main() {
  test('ExchangeRate.fromMap()', () {
    final Map<String, dynamic> map = <String, dynamic>{
      'dateTime': '2021-04-29T11:16:30.859',
      'from': Currency.eur.string(),
      'to': Currency.cop.string(),
      'value': 4200.755,
    };

    expect(
      ExchangeRate.fromMap(map),
      ExchangeRate(
        dateTime: DateTime(2021, 4, 29, 11, 16, 30, 859),
        from: Currency.eur,
        to: Currency.cop,
        value: 4200.755,
      ),
    );
  });

  test('ExchangeRate.toMap()', () {
    final exchangeRate = ExchangeRate(
      dateTime: DateTime(2021, 4, 29, 11, 16, 30, 859),
      from: Currency.eur,
      to: Currency.cop,
      value: 4200.755,
    );

    expect(
      exchangeRate.toMap(),
      {
        'dateTime': '2021-04-29T11:16:30.859',
        'from': Currency.eur.string(),
        'to': Currency.cop.string(),
        'value': 4200.755,
      },
    );
  });
}
