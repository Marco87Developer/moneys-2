import 'package:flutter_test/flutter_test.dart';
import 'package:moneys/src/enums/money_transaction_method.dart';

void main() {
  group('The transitive and the symmetric property', () {
    test(
      'The transitive property: if [b] = [a] and [c] = [b], then [c] = [a].',
      () {
        for (final MoneyTransactionMethod method
            in MoneyTransactionMethod.values) {
          final MoneyTransactionMethod a = method;
          final MoneyTransactionMethod b = a;
          final MoneyTransactionMethod c = b;
          expect(c, equals(a));
        }
      },
    );
    test(
      'The symmetric property: if [a] = [b], then [b] = [a].',
      () {
        for (final MoneyTransactionMethod method
            in MoneyTransactionMethod.values) {
          final MoneyTransactionMethod a = method;
          final MoneyTransactionMethod b = method;
          expect(a, equals(b));
          expect(b, equals(a));
        }
      },
    );
  });

  group('denomination', () {
    test(
      'The denomination is the name (in English) of the money transaction'
      ' method.',
      () {
        expect(
          MoneyTransactionMethod.applepay.denomination,
          equals('Apple Pay'),
        );
        expect(
          MoneyTransactionMethod.creditcard.denomination,
          equals('credit card'),
        );
        expect(
          MoneyTransactionMethod.cryptocurrency.denomination,
          equals('cryptocurrency'),
        );
        expect(
          MoneyTransactionMethod.googlepay.denomination,
          equals('Google Pay'),
        );
        expect(
          MoneyTransactionMethod.paypal.denomination,
          equals('PayPal'),
        );
      },
    );
  });

  group('compareTo', () {
    test('The comparation is done based on the name property.', () {
      expect(
        MoneyTransactionMethod.applepay
            .compareTo(MoneyTransactionMethod.banktransfer),
        isNegative,
      );
      expect(
        MoneyTransactionMethod.applepay
            .compareTo(MoneyTransactionMethod.applepay),
        isZero,
      );
      expect(
        MoneyTransactionMethod.banktransfer
            .compareTo(MoneyTransactionMethod.applepay),
        isPositive,
      );
    });
  });

  group('toMoneyTransactionMethod (StringToMoneyTransactionMethodExtension)',
      () {
    test(
      'If the string is not a valid representation of a value of'
      ' [MoneyTransactionMethod], throws a [FormatException] with the not valid'
      ' string in the message.',
      () {
        const String notValidString = 'NotValidString';
        expect(
          () => notValidString.toMoneyTransactionMethod(),
          throwsA(
            isA<FormatException>().having(
              (final e) => e.message,
              'message',
              contains(notValidString),
            ),
          ),
        );
        expect(
          () => notValidString.toMoneyTransactionMethod(),
          throwsA(
            isA<FormatException>().having(
              (final e) => e.message,
              'message',
              contains('no valid'),
            ),
          ),
        );
        expect(
          () => notValidString.toMoneyTransactionMethod(),
          throwsA(
            isA<FormatException>().having(
              (final e) => e.message,
              'message',
              contains('MoneyTransactionMethod'),
            ),
          ),
        );
      },
    );
    test(
      'The string is a valid representation of a value of [ExpenseOrIncome] if'
      ' coincides with the result of [name].',
      () {
        expect(
          'wiretransfer'.toMoneyTransactionMethod(),
          equals(MoneyTransactionMethod.wiretransfer),
        );
        expect(
          'WIRETRANSFER'.toMoneyTransactionMethod(),
          equals(MoneyTransactionMethod.wiretransfer),
        );
        expect(
          ' wiretransfer '.toMoneyTransactionMethod(),
          equals(MoneyTransactionMethod.wiretransfer),
        );
        expect(
          ' WIRETRANSFER '.toMoneyTransactionMethod(),
          equals(MoneyTransactionMethod.wiretransfer),
        );
        expect(
          'wire transfer'.toMoneyTransactionMethod(),
          equals(MoneyTransactionMethod.wiretransfer),
        );
        expect(
          'WIRE TRANSFER'.toMoneyTransactionMethod(),
          equals(MoneyTransactionMethod.wiretransfer),
        );
        expect(
          ' wire transfer '.toMoneyTransactionMethod(),
          equals(MoneyTransactionMethod.wiretransfer),
        );
        expect(
          ' WIRE TRANSFER '.toMoneyTransactionMethod(),
          equals(MoneyTransactionMethod.wiretransfer),
        );
      },
    );
  });
}
