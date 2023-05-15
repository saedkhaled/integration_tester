import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_tester/tester.dart';

main() {
  late IntegrationTester integrationTester;
  setUp(() {
    integrationTester = IntegrationTester(
      description: 'test',
      init: () {},
      builder: (tester) => [],
    );
  });

  group('start function', () {
    test(
        'should throw error if the integration tester class was not initialized first',
        () {
      // arrange
      final app = MaterialApp(home: Container());
      // assert
      expect(
        () => integrationTester.start(app),
        throwsA(isA<AssertionError>()),
      );
    });

    test(
        'should run the integration test with the given description and the given MaterialApp',
        () async {
      // arrange
      final app = MaterialApp(home: Container());
      // act
      integrationTester.start(app);
      // assert
      expect(find.byType(Container), findsOneWidget);
    });

  });
}
