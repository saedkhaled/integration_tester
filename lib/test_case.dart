// a test case that contains a name, a run function and a test function
// the run function is used to prepare the test case
// the test function is used to test the test case
// the test case is considered ready when the run function is finished
// the test case is considered passed when the test function returns true
// the test case is considered failed when the test function returns false
// the test case is considered not ready when the test function is called before the run function is finished
import 'package:flutter_test/flutter_test.dart';

import 'helper.dart';

class TestCase {
  // the name of the test case
  final String name;

  // the run function of the test case that is used to prepare the test case
  late final FutureCallback run;

  // the actual values of the test case that are used to test the test case
  final List actuals;

  // the expects of the test case that are used to test the test case
  final List expects;

  // a flag that indicates whether the test case is ready or not
  bool _isReady = false;

  TestCase({
    required this.name,
    required FutureCallback run,
    required this.actuals,
    required this.expects,
  }) {
    this.run = () async {
      await run();
      _isReady = true;
    };
  }

  // test the result of the test case and return true if the tests
  // are passed and false otherwise
  test() {
    assert(_isReady, 'Test case not prepared yet');
    for (var i = 0; i < actuals.length; i++) {
      try {
        expect(actuals[i], expects[i]);
      } catch (e) {
        return false;
      }
    }
    return true;
  }
}