import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:portfolio/app.dart';
import 'package:portfolio/providers/locale_provider.dart';
import 'package:portfolio/providers/theme_provider.dart';

void main() {
  testWidgets('Portfolio app loads hero section', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const PortfolioApp(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Ali Baziar'), findsOneWidget);
  });
}
