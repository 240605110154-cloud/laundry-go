
import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_go/main.dart';

void main() {
  testWidgets('LaundryGo tampil dengan benar', (
      WidgetTester tester,
      ) async {
    await tester.pumpWidget(const LaundryGoApp());

    expect(find.text('LaundryGo'), findsOneWidget);
    expect(find.text('Layanan Kami'), findsOneWidget);
    expect(find.text('Pesanan Terbaru'), findsOneWidget);
  });
}
