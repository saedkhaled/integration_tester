import 'test_case.dart';

class ReportGenerator {
  final List<TestCase> testCases;

  ReportGenerator({required this.testCases});

  String generate() {
    StringBuffer buffer = StringBuffer();

    buffer.write('<html>');
    buffer.write('<body>');
    buffer.write('<h1>Integration Test Cases Report</h1>');
    buffer.write('<table border="1">');
    buffer.write('<tr><th>Test Case</th><th>Result</th></tr>');

    for (var testCase in testCases) {
      buffer.write('<tr>');
      buffer.write('<td>${testCase.name}</td>');
      buffer.write('<td>${testCase.result}</td>');
      buffer.write('</tr>');
    }

    buffer.write('</table>');
    buffer.write('</body>');
    buffer.write('</html>');

    return buffer.toString();
  }
}
