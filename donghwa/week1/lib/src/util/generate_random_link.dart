import 'dart:math';

String generateRandomLink() {
  final random = Random();
  final int timestamp = DateTime.now().millisecondsSinceEpoch;
  const String alphabet =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final StringBuffer timeBuffer = StringBuffer();

  int timeValue = timestamp;

  while (timeValue > 0) {
    final int index = timeValue % 52;
    timeBuffer.write(alphabet[index]);
    timeValue ~/= 52;
  }

  final String timeString = timeBuffer.toString().split('').reversed.join();
  final String randomString =
      List.generate(8, (_) => alphabet[random.nextInt(alphabet.length)]).join();

  final String randomLink = "$randomString-$timeString";
  return randomLink;
}
