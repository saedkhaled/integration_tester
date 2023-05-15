import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

// an extended version of integrationDriver that takes a screenshot of each test case
// and saves it in screenshots folder in the root of the project directory with the name
// of the test case as the name of the screenshot file and the png extension
Future extendedTestDriver() async {
  await integrationDriver(
      onScreenshot: (String screenshotName, List<int> screenshotBytes,
      [_]) async {
    final File image = await File('screenshots/$screenshotName.png')
        .create(recursive: true);
    image.writeAsBytesSync(screenshotBytes);
    return true;
  },
  );
}