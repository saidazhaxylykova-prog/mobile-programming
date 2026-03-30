import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/api/rest_client.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    final dio = Dio();
    final restClient = RestClient(dio);
    await tester.pumpWidget(MyApp(restClient: restClient));

    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Load Profile'), findsOneWidget);
  });
}
