import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/moneys.dart';

void main() {
  group('Values of the [Currency] enum:', () {
    test('The transitive property: if [b] = [a] and [c] = [b], then [c] = [a].',
        () {
      for (final Currency currency in Currency.values) {
        final Currency a = currency;
        final Currency b = a;
        final Currency c = b;
        expect(c, equals(a));
        expect(a, equals(c));
      }
    });

    test('The symmetric property: if [a] = [b], [b] = [a].', () {
      for (final Currency currency in Currency.values) {
        final Currency a = currency;
        final Currency b = currency;
        expect(a, equals(b));
        expect(b, equals(a));
      }
    });
  });

  group('[Currency] extension methods:', () {
    test(
        '[alphabeticCode] returns the all-uppercase 3-letter code corresponding'
        ' to the currency.', () {
      expect(Currency.eur.alphabeticCode, equals('EUR'));
      expect(Currency.eur.alphabeticCode, isNot('eur'));
      expect(Currency.eur.alphabeticCode, isNot('euro'));
      expect(Currency.try_.alphabeticCode, equals('TRY'));
      expect(Currency.try_.alphabeticCode, isNot('TRY_'));
    });

    test(
        '[compareTo] compares two currencies based on the corresponding strings'
        ' comparison.', () {
      expect(Currency.eur.compareTo(Currency.usd), equals(-1));
      expect(Currency.eur.compareTo(Currency.eur), equals(0));
      expect(Currency.try_.compareTo(Currency.eur), equals(1));
    });

    test(
        '[emojiFlag] returns the country flag emoji of the currency or an empty'
        ' string.', () {
      expect(Currency.eur.emojiFlag, equals('🇪🇺'));
      expect(Currency.try_.emojiFlag, equals('🇹🇷'));
      expect(Currency.zwl.emojiFlag, equals('🇿🇼'));
      expect(Currency.xcd.emojiFlag, equals(''));
    });

    test('[isFund] indicates whether the currency is actually a fund or not.',
        () {
      expect(Currency.eur.isFund, isFalse);
      expect(Currency.uyi.isFund, isTrue);
    });

    test(
        '[minorUnitsRelationship] corresponds to the number of decimal places'
        ' with which the value of money in this currency is represented.', () {
      expect(Currency.eur.minorUnitsRelationship, equals(2));
      expect(Currency.try_.minorUnitsRelationship, equals(2));
      expect(Currency.xpd.minorUnitsRelationship, isNull);
      expect(Currency.xpf.minorUnitsRelationship, equals(0));
    });

    test('[name] is the name (in English) of the currency.', () {
      expect(Currency.eur.name, equals('Euro'));
      expect(Currency.mur.name, equals('Mauritius Rupee'));
      expect(
        Currency.xbd.name,
        equals('Bond Markets Unit European Unit of Account 17 (E.U.A.-17)'),
      );
    });

    test('[numericCode] is the 3-digit numeric code.', () {
      expect(Currency.eur.numericCode, equals('978'));
      expect(Currency.try_.numericCode, equals('949'));
      expect(Currency.xcd.numericCode, equals('951'));
      expect(Currency.zwl.numericCode, equals('932'));
    });

    test('[string] returns the same of [alphabeticCode].', () {
      expect(Currency.eur.string(), equals('EUR'));
      expect(Currency.try_.string(), equals('TRY'));
      for (final Currency currency in Currency.values) {
        expect(currency.string(), equals(currency.alphabeticCode));
      }
    });

    test('[symbol] is the symbol that represents the currency.', () {
      expect(Currency.cop.symbol, equals(r'$'));
      expect(Currency.eur.symbol, equals('€'));
      expect(Currency.inr.symbol, equals('₹'));
      expect(Currency.pab.symbol, equals('B/.'));
      expect(Currency.xua.symbol, isEmpty);
    });
  });

  group('From a [String] to the corresponding [Currency] value:', () {
    test(
        'If the string is a valid representation of a [Currency] value,'
        ' [toCurrency] returns the [Currency] value corresponding to the'
        ' string.', () {
      expect('EUR'.toCurrency(), equals(Currency.eur));
      expect(' EUR '.toCurrency(), equals(Currency.eur));
      expect('EURO'.toCurrency(), equals(Currency.eur));
      expect(' EURO '.toCurrency(), equals(Currency.eur));
      expect('Euro'.toCurrency(), equals(Currency.eur));
      expect(' Euro '.toCurrency(), equals(Currency.eur));
      expect('euro'.toCurrency(), equals(Currency.eur));
      expect(' euro '.toCurrency(), equals(Currency.eur));
      expect('978'.toCurrency(), equals(Currency.eur));
      expect(' 978 '.toCurrency(), equals(Currency.eur));
    });

    test(
        'If the string is not a valid representation of a [Currency] value,'
        ' [toCurrency] throws a [FormatException].', () {
      expect(() => ''.toCurrency(), throwsFormatException);
      expect(() => 'Euros'.toCurrency(), throwsFormatException);
      expect(() => '1357'.toCurrency(), throwsFormatException);
    });
  });
}
