import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enumerations/currency.dart';
import 'package:moneys/src/models/money.dart';

void main() {
  test('Money.fromMap()', () {
    const Map<String, dynamic> map1 = {
      'amount': 10000.55,
      'currency': 'AUD',
    };

    expect(
      Money.fromMap(map1),
      const Money(amount: 10000.55, currency: Currency.aud),
    );
  });

  test('show() and showK()', () {
    const Money money1 = Money(amount: 10000.55, currency: Currency.aud);
    const Money money2 = Money(amount: 10000, currency: Currency.eur);

    expect(money1.show(), r'$10,000.55');
    expect(money2.show(k: true), '€10 k');
    // With a no-break space
    expect(money1.show(locale: 'it_IT'), r'10.000,55 $');
    expect(money1.show(k: true), money1.showK());
  });

  test('toMap()', () {
    const Money money1 = Money(amount: 10000.55, currency: Currency.aud);

    expect(money1.toMap(), {'amount': 10000.55, 'currency': 'AUD'});
  });

  test('@override compareTo()', () {
    const Money money1 = Money(amount: 10000.55, currency: Currency.aud);
    const Money money2 = Money(amount: 10000, currency: Currency.eur);
    const Money money3 = Money(amount: 10000, currency: Currency.aud);

    expect(() => money1.compareTo(money2), throwsFormatException);
    expect(money1.compareTo(money3), 1);
  });

  test('@override toString()', () {
    const Money money1 = Money(amount: 10000.55, currency: Currency.aud);
    const Money money2 = Money(amount: 10000, currency: Currency.eur);

    expect('$money1', '10000.55 AUD');
    expect('$money2', '10000.00 EUR');
  });

  test('<, <=, ==, >= and > operators', () {
    const Money money1 = Money(amount: 15000, currency: Currency.cad);
    const Money money2 = Money(amount: 10000, currency: Currency.cad);
    const Money money3 = Money(amount: 15000, currency: Currency.cad);
    const Money money4 = Money(amount: 15000, currency: Currency.cop);

    expect(money1 < money2, false);
    expect(money1 <= money2, false);
    expect(money1 == money2, false);
    expect(money1 == money3, true);
    expect(money1 >= money2, true);
    expect(money1 > money2, true);
    expect(() => money1 == money4, throwsFormatException);
  });

  test('- and + operators', () {
    const Money money1 = Money(amount: 15000, currency: Currency.cad);
    const Money money2 = Money(amount: 10000, currency: Currency.cad);
    const Money money3 = Money(amount: 15000, currency: Currency.cad);
    const Money money4 = Money(amount: 5000, currency: Currency.gbp);

    expect(money1 - money2, const Money(amount: 5000, currency: Currency.cad));
    expect(money2 - money1, const Money(amount: -5000, currency: Currency.cad));
    expect(money1 - money3, const Money(amount: 0, currency: Currency.cad));
    expect(() => money1 - money4, throwsFormatException);

    expect(money1 + money2, const Money(amount: 25000, currency: Currency.cad));
    expect(money1 + money3, const Money(amount: 30000, currency: Currency.cad));
    expect(() => money1 + money4, throwsFormatException);
  });

  test('* and / operators', () {
    const Money money1 = Money(amount: 15000, currency: Currency.cad);

    expect(money1 * 2, const Money(amount: 30000, currency: Currency.cad));
    expect(money1 * 2.5, const Money(amount: 37500, currency: Currency.cad));
    expect(money1 / 2, const Money(amount: 7500, currency: Currency.cad));
    expect(money1 / 2.5, const Money(amount: 6000, currency: Currency.cad));
  });

  test('String to Money', () {
    const String money1 = '10500.87 EUR';
    const String money2 = '1500 COP';
    const String money3 = '1500  COP';

    expect(money1.toMoney(),
        const Money(amount: 10500.87, currency: Currency.eur));
    expect(money2.toMoney(), const Money(amount: 1500, currency: Currency.cop));
    expect(() => money3.toMoney(), throwsFormatException);
  });
}
