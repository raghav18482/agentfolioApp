/// Hides rupee amounts inside free text, for "Hide balances".
///
/// `MoneyText` masks the numbers the app formats itself; this covers the
/// ones an AI writes into prose (`Rs. 1,23,456`, `₹4.2L`, `INR 5 crore`).
/// Percentages stay visible, as they do everywhere else in the app.
abstract final class AmountMask {
  static const glyph = '••••';

  static final _amount = RegExp(
    r'(₹|\bRs\.?|\bINR)\s?-?\d[\d,]*(?:\.\d+)?'
    r'(?:\s?(?:lakhs?|crores?|cr|l|k)\b)?',
    caseSensitive: false,
  );

  static String apply(String text) => text.replaceAllMapped(_amount, (m) => '${m[1]} $glyph');
}
