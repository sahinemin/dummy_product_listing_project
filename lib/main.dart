import 'package:dummy_clean_project/app.dart';
import 'package:dummy_clean_project/bootstrap.dart';

Future<void> main() async {
  await bootstrap(
    () async => const DummyApp(),
  );
}
