/// Indicates which discount must be applied first.
///
enum DiscountSequence {
  /// The **absolute** discount must be applied first.
  absoluteFirst,

  /// The **percentage** discount must be applied first.
  percentageFirst,
}

extension DiscountSequenceExtension on DiscountSequence {}
