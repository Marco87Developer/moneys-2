import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enumerations/currency.dart';
import 'package:moneys/src/models/exchange_rate.dart';
import 'package:moneys/src/extensions/list_exchange_rate_x.dart';

void main() {
  test('getExchangeRate()', () {
    final rateEurCop = ExchangeRate(
      dateTime: DateTime(2021, 5, 1),
      from: Currency.eur,
      to: Currency.cop,
      value: 4500,
    );
    final rateEurUsd = ExchangeRate(
      dateTime: DateTime(2021, 5, 7),
      from: Currency.eur,
      to: Currency.usd,
      value: 1.2,
    );
    final rateUsdCop = ExchangeRate(
      dateTime: DateTime(2021, 5, 5),
      from: Currency.usd,
      to: Currency.cop,
      value: 3800,
    );

    final List<ExchangeRate> list = [
      rateEurCop,
      rateEurUsd,
      rateUsdCop,
    ];

    expect(
      list.getExchangeRate(
        from: Currency.eur,
        to: Currency.usd,
      ),
      rateEurUsd,
    );
    expect(
      list.getExchangeRate(
        from: Currency.cop,
        to: Currency.usd,
      ),
      null,
    );
  });

  test('getExchangeRateSameDay()', () {
    final rateEurCop = ExchangeRate(
      dateTime: DateTime(2021, 5, 1),
      from: Currency.eur,
      to: Currency.cop,
      value: 4500,
    );
    final rateEurUsd = ExchangeRate(
      dateTime: DateTime(2021, 5, 7),
      from: Currency.eur,
      to: Currency.usd,
      value: 1.2,
    );
    final rateUsdCop = ExchangeRate(
      dateTime: DateTime(2021, 5, 5),
      from: Currency.usd,
      to: Currency.cop,
      value: 3800,
    );

    final List<ExchangeRate> list = [
      rateEurCop,
      rateEurUsd,
      rateUsdCop,
    ];

    expect(
      list.getExchangeRateSameDay(
        dateTime: DateTime(2021, 5, 5),
        from: Currency.usd,
        to: Currency.cop,
      ),
      rateUsdCop,
    );
    expect(
      list.getExchangeRateSameDay(
        dateTime: DateTime(2021, 5, 7),
        from: Currency.usd,
        to: Currency.cop,
      ),
      null,
    );
    expect(
      list.getExchangeRateSameDay(
        dateTime: DateTime(2021, 5, 5),
        from: Currency.cop,
        to: Currency.usd,
      ),
      null,
    );
  });
}
