import 'package:flutter/material.dart';

/// Bilingual text helper — edit [en] and [fa] for your own content.
class L {
  const L(this.en, this.fa);

  final String en;
  final String fa;

  String of(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'fa' ? fa : en;
  }
}
