import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_pertemuan4/main.dart';

void main() {
  testWidgets('Home screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    // Halaman utama menampilkan TabBar dengan dua storage: SQFlite & Drift
    expect(find.text('SQFlite'), findsOneWidget);
    expect(find.text('Drift'), findsOneWidget);
  });
}
