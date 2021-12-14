import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enums/discount_first.dart';

void main() {
  group('The transitive and the symmetric property', () {
    test(
      'The transitive property: if [b] = [a] and [c] = [b], then [c] = [a].',
      () {
        for (final DiscountFirst discountFirst in DiscountFirst.values) {
          final DiscountFirst a = discountFirst;
          final DiscountFirst b = a;
          final DiscountFirst c = b;
          expect(c, equals(a));
        }
      },
    );

    test(
      'The symmetric property: if [a] = [b], then [b] = [a].',
      () {
        for (final DiscountFirst discountFirst in DiscountFirst.values) {
          final DiscountFirst a = discountFirst;
          final DiscountFirst b = discountFirst;
          expect(a, equals(b));
          expect(b, equals(a));
        }
      },
    );
  });

  group('compareTo', () {
    test('The comparation is done based on the name property.', () {
      expect(
        DiscountFirst.absolute.compareTo(DiscountFirst.percentage),
        isNegative,
      );
      expect(
        DiscountFirst.absolute.compareTo(DiscountFirst.absolute),
        isZero,
      );
      expect(
        DiscountFirst.percentage.compareTo(DiscountFirst.absolute),
        isPositive,
      );
    });
  });

  group('toDiscountFirst (StringToDiscountFirstExtension)', () {
    test(
      'If the string is not a valid representation of a value of'
      ' [DiscountFirst], throws a [FormatException] with the not valid string'
      ' in the message.',
      () {
        const String notValidString = 'NotValidString';
        expect(
          () => notValidString.toDiscountFirst(),
          throwsA(
            isA<FormatException>().having(
              (final e) => e.message,
              'message',
              contains(notValidString),
            ),
          ),
        );
        expect(
          () => notValidString.toDiscountFirst(),
          throwsA(
            isA<FormatException>().having(
              (final e) => e.message,
              'message',
              contains('no valid'),
            ),
          ),
        );
        expect(
          () => notValidString.toDiscountFirst(),
          throwsA(
            isA<FormatException>().having(
              (final e) => e.message,
              'message',
              contains('DiscountFirst'),
            ),
          ),
        );
      },
    );
    test(
      'The string is a valid representation of a value of [DiscountFirst] if'
      ' coincides with the result of [name].',
      () {
        expect(
          'percentage'.toDiscountFirst(),
          equals(DiscountFirst.percentage),
        );
        expect(
          'PERCENTAGE'.toDiscountFirst(),
          equals(DiscountFirst.percentage),
        );
        expect(
          ' percentage '.toDiscountFirst(),
          equals(DiscountFirst.percentage),
        );
        expect(
          ' PERCENTAGE '.toDiscountFirst(),
          equals(DiscountFirst.percentage),
        );
      },
    );
  });
}
