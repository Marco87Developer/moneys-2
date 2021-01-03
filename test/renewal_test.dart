import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enumerations/renewal.dart';

void main() {
  test('string()', () {
    const Renewal renewal1 = Renewal.annual;
    const Renewal renewal2 = Renewal.daily;

    expect(renewal1.string(), 'annual');
    expect(renewal2.string(), 'daily');
  });

  test('From String to Renewal', () {
    const String renewal1 = 'monthly';
    const String renewal2 = 'weekly';
    const String renewalNotValid1 = 'Annual';
    const String renewalNotValid2 = 'week';

    expect(renewal1.toRenewal(), Renewal.monthly);
    expect(renewal2.toRenewal(), Renewal.weekly);
    expect(() => renewalNotValid1.toRenewal(), throwsFormatException);
    expect(() => renewalNotValid2.toRenewal(), throwsFormatException);
  });
}
