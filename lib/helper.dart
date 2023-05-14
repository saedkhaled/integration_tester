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


String generateHtmlReport(List<TestCase> testCases) {
  StringBuffer buffer = StringBuffer();

  buffer.write('<html>');
  buffer.write('<body>');
  buffer.write('<h1>Integration Test Cases Report</h1>');
  buffer.write('<table border="1">');
  buffer.write('<tr><th>Test Case</th><th>Result</th></tr>');

  for (var testCase in testCases) {
    buffer.write('<tr>');
    buffer.write('<td>${testCase.name}</td>');
    buffer.write('<td>${testCase.result ? 'success' : 'fail'}</td>');
    buffer.write('</tr>');
  }

  buffer.write('</table>');
  buffer.write('</body>');
  buffer.write('</html>');

  return buffer.toString();
}