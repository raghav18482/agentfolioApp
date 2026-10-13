import 'package:agentfolio/core/presentation/privacy/privacy_provider.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// How a money amount is written.
enum MoneyStyle {
  /// `₹1,23,456.78`
  full,

  /// `₹1,23,457`
  rupees,

  /// `₹1.23 L`
  compact,

  /// `+₹1,234.50`, coloured green or red.
  change,

  /// `+₹1,235`, coloured: a change where paise are noise.
  changeRupees,
}

const _masked = '₹ ••••';

String _format(num? value, MoneyStyle style) => switch (style) {
  MoneyStyle.full => Fmt.money(value),
  MoneyStyle.rupees => Fmt.rupees(value),
  MoneyStyle.compact => Fmt.compact(value),
  MoneyStyle.change => Fmt.signedMoney(value),
  MoneyStyle.changeRupees => Fmt.signedRupees(value),
};

/// An amount of money. Tabular digits, honours "Hide balances", and for
/// [MoneyStyle.change] carries its colour plus a sign, never colour alone.
class MoneyText extends StatelessWidget {
  const MoneyText(
    this.value, {
    super.key,
    this.style,
    this.format = MoneyStyle.full,
    this.textAlign,
  });

  final num? value;
  final TextStyle? style;
  final MoneyStyle format;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final hidden = context.select<PrivacyProvider, bool>((p) => p.hideBalances);
    final base = (style ?? DefaultTextStyle.of(context).style).tabular;
    final color = format == MoneyStyle.change || format == MoneyStyle.changeRupees
        ? context.palette.pnl(value)
        : null;
    final text = hidden ? _masked : _format(value, format);
    return Text(
      text,
      style: color == null ? base : base.copyWith(color: color),
      textAlign: textAlign,
      maxLines: 1,
      overflow: TextOverflow.fade,
      softWrap: false,
      semanticsLabel: hidden ? 'Hidden amount' : null,
    );
  }
}

/// A large amount that counts to its new value when it changes, and up from
/// zero the first time it appears. The headline number on Home.
class AnimatedMoney extends StatelessWidget {
  const AnimatedMoney(this.value, {super.key, this.style, this.format = MoneyStyle.rupees});

  final double value;
  final TextStyle? style;
  final MoneyStyle format;

  @override
  Widget build(BuildContext context) {
    final hidden = context.select<PrivacyProvider, bool>((p) => p.hideBalances);
    final base = (style ?? DefaultTextStyle.of(context).style).tabular;
    if (hidden) return Text(_masked, style: base, semanticsLabel: 'Hidden amount');
    return Semantics(
      label: _format(value, format),
      excludeSemantics: true,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: value),
        duration: AppMotion.of(context, const Duration(milliseconds: 900)),
        curve: Curves.easeOutCubic,
        builder: (context, v, _) => Text(_format(v, format), style: base, maxLines: 1),
      ),
    );
  }
}

/// A percentage change with arrow, sign and colour: `▲ +2.40%`.
class PnlPercent extends StatelessWidget {
  const PnlPercent(this.value, {super.key, this.style, this.decimals = 2, this.showArrow = true});

  final num? value;
  final TextStyle? style;
  final int decimals;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    final color = context.palette.pnl(value);
    final base = (style ?? DefaultTextStyle.of(context).style).tabular.copyWith(color: color);
    final v = value;
    final arrow = !showArrow || v == null || v == 0 ? '' : (v > 0 ? '▲ ' : '▼ ');
    return Text('$arrow${Fmt.signedPct(v, decimals: decimals)}', style: base, maxLines: 1);
  }
}
