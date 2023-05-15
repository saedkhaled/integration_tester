import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_tester/extensions.dart';

import 'helper.dart';
import 'test_case.dart';

class IntegrationTester {
  // a flag that indicates whether the integration test is initialized or not
  bool _isInitialized = false;

  // the init function of the integration test that is used to prepare the integration test
  final VoidCallback init;

  // the description of the integration test
  final String description;

  // the tester of the integration test that is used to test the integration test
  // the tester is set when the integration test is started
  late final WidgetTester tester;

  // the test cases of the integration test that are used to test the integration test
  // the test cases are set when the integration test is started
  late final List<TestCase> testCases;

  // the builder of the integration test that is used to build the test cases
  // the builder is set when the integration test is created
  // the builder is called when the integration test is started to build the test
  // cases and set them to the testCases variable
  late final TestCasesBuilder _builder;

  // the binding of the integration test that is used to take screenshots of the integration test
  // and to close the integration test when it is finished testing it and return the result of the integration test as a future
  late final IntegrationTestWidgetsFlutterBinding binding;

  final bool enableScreenshots;

  IntegrationTester({
    required this.description,
    required this.init,
    required TestCasesBuilder builder,
    this.enableScreenshots = true,
  }) {
    // init the test cases builder
    _builder = builder;
    // init the integration test
    init();
    // make sure IntegrationTestWidgetsFlutterBinding is initialized
    binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    // set the flag to true to indicate that the integration test is ready
    _isInitialized = true;
  }

  // start the integration test with the given MaterialApp and return a future of void that completes when the integration test is finished
  // @param app: the MaterialApp of the integration test
  void start(MaterialApp app) async {
    // make sure the integration test is initialized
    assert(_isInitialized, 'The integration test is not initialized');
    // run the integration test with the given description
    testWidgets(description, (tester) async {
      this.tester = tester;
      // run the app with the given MaterialApp
      await tester.runApp(app);
      // build the test cases
      testCases = _builder(tester);
      // run the test cases one by one and wait for each one to finish
      for (var testCase in testCases) {
        if (enableScreenshots) {
          await binding.takeScreenshot(testCase.name);
        }
        await testCase.run();
        if (enableScreenshots) {
          await binding.takeScreenshot(testCase.name);
        }
        await testCase.test();
      }
      print(binding.reportData);

      print(generateHtmlReport(testCases));
    });
  }
}
