

// an extension on WidgetTester that contains some useful functions
// the functions are used to make the integration test easier
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension TesterExtensions on WidgetTester {
  // scroll to a widget with the given key and make sure it
  // is visible on the screen before continuing the test case execution
  // then enter the given text into the widget and wait for the widget to update
  // @param key the key of the widget to scroll to and enter the text into
  // @param value the text to enter into the widget
  Future fillField({required Key key, required String value}) async {
    await ensureVisible(find.byKey(key, skipOffstage: false));
    await enterText(find.byKey(key, skipOffstage: false), value);
  }

  // scroll to a widget with the given key and make sure it is visible
  // on the screen before continuing the test case execution
  // then enter an empty text into the widget and wait for the widget to update
  // @param key the key of the widget to scroll and enter an empty text into
  Future fillFieldEmptyString({required Key key}) async {
    await ensureVisible(find.byKey(key, skipOffstage: false));
    await enterText(find.byKey(key, skipOffstage: false), '');
  }

  // scroll to a widget with the given key and make sure it is visible on the screen
  // before continuing the test case execution then enter a random text
  // into the widget and wait for the widget to update
  // @param key the key of the widget to scroll to and enter a random text into
  Future fillFieldRandomString({required Key key}) async {
    await ensureVisible(find.byKey(key, skipOffstage: false));
    await enterText(find.byKey(key, skipOffstage: false), Faker().lorem.word());
  }

  // pump the given MaterialApp and wait for it to finish
  // @param app the MaterialApp to pump
  Future runApp(MaterialApp app) async {
    await pumpWidget(app);
    await pumpAndSettle();
  }

  // scroll to the given widget and make sure it is visible on the screen
  // before tapping it and wait for it to finish
  // @param key the key of the widget to scroll to and tap
  Future pressButton({required Key key}) async {
    await pumpAndSettle(const Duration(milliseconds: 500));
    await ensureVisible(find.byKey(key, skipOffstage: false));
    await tap(find.byKey(key, skipOffstage: false));

    await pumpAndSettle(const Duration(seconds: 1));
  }
}