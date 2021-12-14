import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enums/currency.dart';

void main() {
  group('The transitive and the symmetric property', () {
    test(
      'The transitive property: if [b] = [a] and [c] = [b], then [c] = [a].',
      () {
        for (final Currency currency in Currency.values) {
          final Currency a = currency;
          final Currency b = a;
          final Currency c = b;
          expect(c, equals(a));
        }
      },
    );
    test(
      'The symmetric property: if [a] = [b], then [b] = [a].',
      () {
        for (final Currency currency in Currency.values) {
          final Currency a = currency;
          final Currency b = currency;
          expect(a, equals(b));
          expect(b, equals(a));
        }
      },
    );
  });

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

  group('symbol', () {
    test('Is the symbol that represents the currency.', () {
      expect(Currency.eur.symbol, equals('€'));
      expect(Currency.inr.symbol, equals('₹'));
      expect(Currency.usd.symbol, equals(r'$'));
    });
  });

  group('compareTo', () {
    test('The comparation is done based on the name property.', () {
      expect(Currency.eur.compareTo(Currency.usd), isNegative);
      expect(Currency.eur.compareTo(Currency.eur), isZero);
      expect(Currency.usd.compareTo(Currency.eur), isPositive);
    });
  });

  group('toCurrency (StringToCurrencyExtension)', () {
    test(
      'If the string is not a valid representation of a value of [Currency],'
      ' throws a [FormatException] with the not valid string in the message.',
      () {
        const String notValidString = 'NotValidString';
        expect(
          () => notValidString.toCurrency(),
          throwsA(
            isA<FormatException>().having(
              (final e) => e.message,
              'message',
              contains(notValidString),
            ),
          ),
        );
        expect(
          () => notValidString.toCurrency(),
          throwsA(
            isA<FormatException>().having(
              (final e) => e.message,
              'message',
              contains('no valid'),
            ),
          ),
        );
        expect(
          () => notValidString.toCurrency(),
          throwsA(
            isA<FormatException>().having(
              (final e) => e.message,
              'message',
              contains('Currency'),
            ),
          ),
        );
      },
    );
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
