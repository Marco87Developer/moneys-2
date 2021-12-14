import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enums/currency.dart';

void main() {
  group('alphabeticCode', () {
    test('Is an all-uppercase 3-letter code.', () {
      expect(Currency.eur.alphabeticCode, equals('EUR'));
      expect(Currency.usd.alphabeticCode, equals('USD'));
      expect(Currency.try_.alphabeticCode, equals('TRY'));
    });
  });

  group('countryEmojiFlag', () {
    test(
        'If the currency has a corresponding country flag, is the unicode'
        ' country flag emoji.', () {
      expect(Currency.eur.countryEmojiFlag, equals('🇪🇺'));
      expect(Currency.usd.countryEmojiFlag, equals('🇺🇸'));
      expect(Currency.try_.countryEmojiFlag, equals('🇹🇷'));
    });
    test(
        'If the currency does not have a corresponding country flag, is an'
        ' empty string.', () {
      expect(Currency.xaf.countryEmojiFlag, equals(''));
    });
  });

  group('denomination', () {
    test('Is the name (in English) of the currency.', () {
      expect(Currency.eur.denomination, equals('Euro'));
      expect(Currency.usd.denomination, equals('US Dollar'));
      expect(Currency.try_.denomination, equals('Turkish Lira'));
    });
  });

  group('isFund', () {
    test(
      'Indicates with a bool value whether this currency is actually a fund or'
      ' not.',
      () {
        expect(Currency.eur.isFund, isFalse);
        expect(Currency.usd.isFund, isFalse);
        expect(Currency.usn.isFund, isTrue);
      },
    );
  });

  group('minorUnitRelationship', () {
    test(
      'If is present in the ISO 4217 is a number.',
      () {
        expect(Currency.eur.minorUnitRelationship, equals(2));
        expect(Currency.usd.minorUnitRelationship, equals(2));
        expect(Currency.bif.minorUnitRelationship, equals(0));
      },
    );
    test(
      'If is not present in the ISO 4217 is null.',
      () {
        expect(Currency.xag.minorUnitRelationship, isNull);
        expect(Currency.xau.minorUnitRelationship, isNull);
        expect(Currency.xba.minorUnitRelationship, isNull);
      },
    );
  });

  group('numericCode', () {
    test('Is a 3-digit code.', () {
      expect(Currency.aud.numericCode, equals('036'));
      expect(Currency.eur.numericCode, equals('978'));
      expect(Currency.usd.numericCode, equals('840'));
    });
  });

  group('string', () {
    test('Is an all-uppercase 3-letter code equal to alphabeticCode.', () {
      expect(Currency.eur.string, equals('EUR'));
      expect(Currency.eur.string, equals(Currency.eur.alphabeticCode));
      expect(Currency.usd.string, equals('USD'));
      expect(Currency.usd.string, equals(Currency.usd.alphabeticCode));
      expect(Currency.try_.string, equals('TRY'));
      expect(Currency.try_.string, equals(Currency.try_.alphabeticCode));
    });
  });

  group('symbol', () {
    test('Is the symbol that represents the currency.', () {
      expect(Currency.eur.symbol, equals('€'));
      expect(Currency.inr.symbol, equals('₹'));
      expect(Currency.usd.symbol, equals(r'$'));
    });
  });

  group('compareTo', () {
    test('The comparation is done based on the string property.', () {
      expect(Currency.eur.compareTo(Currency.usd), isNegative);
      expect(Currency.eur.compareTo(Currency.eur), isZero);
      expect(Currency.usd.compareTo(Currency.eur), isPositive);
    });
  });

  group('toCurrency (StringToCurrencyExtension)', () {
    test(
      'The string is a valid representation of a value of [Currency] if'
      ' coincides with the result of [alphabeticCode].',
      () {
        expect('eur'.toCurrency(), equals(Currency.eur));
        expect('EUR'.toCurrency(), equals(Currency.eur));
        expect(' eur '.toCurrency(), equals(Currency.eur));
        expect(' EUR '.toCurrency(), equals(Currency.eur));
      },
    );
    test(
      'The string is a valid representation of a value of [Currency] if'
      ' coincides with the result of [denomination].',
      () {
        expect('euro'.toCurrency(), equals(Currency.eur));
        expect('EURO'.toCurrency(), equals(Currency.eur));
        expect(' euro '.toCurrency(), equals(Currency.eur));
        expect(' EURO '.toCurrency(), equals(Currency.eur));
      },
    );
    test(
      'The string is a valid representation of a value of [Currency] if'
      ' coincides with the result of [name].',
      () {
        expect('eur'.toCurrency(), equals(Currency.eur));
        expect('EUR'.toCurrency(), equals(Currency.eur));
        expect(' eur '.toCurrency(), equals(Currency.eur));
        expect(' EUR '.toCurrency(), equals(Currency.eur));
      },
    );
    test(
      'The string is a valid representation of a value of [Currency] if'
      ' coincides with the result of [numericCode].',
      () {
        expect('978'.toCurrency(), equals(Currency.eur));
        expect(' 978 '.toCurrency(), equals(Currency.eur));
      },
    );
    test(
      'The string is a valid representation of a value of [Currency] if'
      ' coincides with the result of [string].',
      () {
        expect('eur'.toCurrency(), equals(Currency.eur));
        expect('EUR'.toCurrency(), equals(Currency.eur));
        expect(' eur '.toCurrency(), equals(Currency.eur));
        expect(' EUR '.toCurrency(), equals(Currency.eur));
      },
    );
  });
}
