// a callback that returns a future
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_tester/test_case.dart';

// a callback that returns a future
typedef FutureCallback = Future Function();

// a callback that returns a future of bool
typedef FutureBoolCallback = Future<bool> Function();

// a callback that returns a list of test cases given a tester
// the test cases are used to test the integration test
typedef TestCasesBuilder = List<TestCase> Function(WidgetTester tester);