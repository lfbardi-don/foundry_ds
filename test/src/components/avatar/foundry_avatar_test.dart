import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/avatar/foundry_avatar.dart';
import 'package:foundry_ds/src/foundations/icons.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundryAvatar', () {
    Widget buildTestWidget(Widget child) {
      return FoundryTheme(
        data: FoundryLightTheme(),
        child: MaterialApp(
          home: Scaffold(body: Center(child: child)),
        ),
      );
    }

    testWidgets('renders with initials fallback', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryAvatar(initials: 'AB')));

      expect(find.text('AB'), findsOneWidget);
    });

    testWidgets('renders with icon fallback when no image or initials', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryAvatar()));

      expect(find.byIcon(FIcons.user), findsOneWidget);
    });

    testWidgets('renders with custom fallback icon', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryAvatar(fallbackIcon: Icons.person)));

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    group('size variants', () {
      testWidgets('renders all size variants', (tester) async {
        for (final size in FoundryAvatarSize.values) {
          await tester.pumpWidget(buildTestWidget(FoundryAvatar(size: size, initials: 'T')));
          expect(find.byType(FoundryAvatar), findsOneWidget);
        }
      });

      testWidgets('xs constructor creates xs size', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryAvatar.xs(initials: 'XS')));
        final avatar = tester.widget<FoundryAvatar>(find.byType(FoundryAvatar));
        expect(avatar.size, FoundryAvatarSize.xs);
      });

      testWidgets('lg constructor creates lg size', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryAvatar.lg(initials: 'LG')));
        final avatar = tester.widget<FoundryAvatar>(find.byType(FoundryAvatar));
        expect(avatar.size, FoundryAvatarSize.lg);
      });
    });

    group('status indicator', () {
      testWidgets('hides status indicator by default', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryAvatar(initials: 'AB')));

        // Should not find a Stack within FoundryAvatar
        expect(find.descendant(of: find.byType(FoundryAvatar), matching: find.byType(Stack)), findsNothing);
      });

      testWidgets('shows status indicator when showStatus is true', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryAvatar(initials: 'AB', showStatus: true)));

        expect(find.descendant(of: find.byType(FoundryAvatar), matching: find.byType(Stack)), findsOneWidget);
      });
    });
  });
}
