import 'package:flutter_test/flutter_test.dart';
import 'package:rc_bykaantium/main.dart';

void main() {
  testWidgets('Widget test example', (WidgetTester tester) async {
    // MyApp sınıfını kullanarak test yapılacaksa doğru sınıf adını kullanın
    await tester.pumpWidget(MyApp());

    // Test kodları buraya eklenecek
  });
}
