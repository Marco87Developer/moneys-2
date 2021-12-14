/// Indicates **which discount must be applied first**.
///
enum DiscountFirst {
  /// The **absolute** discount must be applied first.
  absolute,

  /// The **percentage** discount must be applied first.
  percentage,
}

/// This extension adds features to the [DiscountFirst] enum.
///
extension DiscountSequenceExtension on DiscountFirst {
  /// Compares this [DiscountFirst] value to [other].
  ///
  /// Returns a **negative** value if this [DiscountFirst] value is ordered
  /// before [other], a **positive** value if this [DiscountFirst] value is
  /// ordered after [other], or **zero** if this [DiscountFirst] value and
  /// [other] are equivalent.
  ///
  /// The comparison is made **based on the [name] property** of these two
  /// [DiscountFirst] values and is **not case sensitive**.
  ///
  /// Examples:
  ///
  /// ```dart
  /// DiscountFirst.absolute.compareTo(DiscountFirst.percentage) // isNegative
  /// DiscountFirst.absolute.compareTo(DiscountFirst.absolute) // isZero
  /// DiscountFirst.percentage.compareTo(DiscountFirst.absolute) // isPositive,
  /// ```
  ///
  int compareTo(final DiscountFirst other) =>
      name.toLowerCase().compareTo(other.name.toLowerCase());
}

/// This extension adds functionality to the [String] class so that **a string
/// can be converted to the corresponding [DiscountFirst] value**.
///
extension StringToDiscountFirstExtension on String {
  /// Returns **the value of [DiscountFirst] corresponding to this string**.
  ///
  /// Throws a [FormatException] if this string is not a valid representation of
  /// a value of [DiscountFirst]. This string is a valid representation of a
  /// value of [DiscountFirst] if it matches the result of `DiscountFirst.name`.
  ///
  /// This method is **not case sensitive** and **does not take into account
  /// leading and trailing white spaces**.
  ///
  /// Examples:
  ///
  /// ```dart
  /// 'percentage'.toDiscountFirst() // DiscountFirst.percentage
  /// 'PERCENTAGE'.toDiscountFirst() // DiscountFirst.percentage
  /// ' percentage '.toDiscountFirst() // DiscountFirst.percentage
  /// ' PERCENTAGE '.toDiscountFirst() // DiscountFirst.percentage
  /// 'NotValidString'.toDiscountFirst() // Throws a [FormatException]
  /// ```
  ///
  DiscountFirst toDiscountFirst() {
    final String trimmedLowerCase = trim().toLowerCase();
    for (final DiscountFirst discountFirst in DiscountFirst.values) {
      if (trimmedLowerCase == discountFirst.name.toLowerCase()) {
        return discountFirst;
      }
    }
    throw FormatException(
      'This string (${this}) contains no valid (or unique) representation of a'
      ' [DiscountFirst] value.',
    );
  }
}
