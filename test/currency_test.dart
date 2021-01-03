import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enumerations/currency.dart';

void main() {
  test('Get the alphabetical representation', () {
    const Currency currencyAUD = Currency.aud;
    const Currency currencyEUR = Currency.eur;
    const Currency currencyTND = Currency.tnd;
    const Currency currencyXAG = Currency.xag;

    expect(currencyAUD.alphabetic, 'AUD');
    expect(currencyEUR.alphabetic, 'EUR');
    expect(currencyTND.alphabetic, 'TND');
    expect(currencyXAG.alphabetic, 'XAG');
  });

  test('Get the exponent', () {
    const Currency currencyAUD = Currency.aud;
    const Currency currencyEUR = Currency.eur;
    const Currency currencyTND = Currency.tnd;
    const Currency currencyXAG = Currency.xag;

    expect(currencyAUD.exponent, 2);
    expect(currencyEUR.exponent, 2);
    expect(currencyTND.exponent, 3);
    expect(currencyXAG.exponent, null);
  });

  test('Is fund?', () {
    const Currency currencyCOP = Currency.cop;
    const Currency currencyMXV = Currency.mxv;

    expect(currencyCOP.isFund, false);
    expect(currencyMXV.isFund, true);
  });

  test('Get the name', () {
    const Currency currencyENG = Currency.ang;
    const Currency currencyFKP = Currency.fkp;

    expect(currencyENG.name, 'Netherlands Antillean Guilder');
    expect(currencyFKP.name, 'Falkland Islands Pound');
  });

  test('Get the numerical representation', () {
    const Currency currencyHTG = Currency.htg;
    const Currency currencyHUF = Currency.huf;
    const Currency currencyIDR = Currency.idr;

    expect(currencyHTG.numerical, '332');
    expect(currencyHUF.numerical, '348');
    expect(currencyIDR.numerical, '360');
  });

  test('Get the symbol', () {
    const Currency currencyBMD = Currency.bmd;
    const Currency currencyXPF = Currency.xpf;
    const Currency currencyXTS = Currency.xts;

    expect(currencyBMD.symbol, r'$');
    expect(currencyXPF.symbol, '₣');
    expect(currencyXTS.symbol, '');
  });

  test('From String to Currency', () {
    const String currencyUSD = 'USD';
    const String currencyANG = 'ang';
    const String currencyFKP = '238';
    const String currencyNotValid = 'abcdefg';

    expect(currencyUSD.toCurrency(), Currency.usd);
    expect(currencyANG.toCurrency(), Currency.ang);
    expect(currencyFKP.toCurrency(), Currency.fkp);
    expect(() => currencyNotValid.toCurrency(), throwsFormatException);
  });
}
