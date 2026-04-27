import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

Future<void> initDotenv(GetIt sl) async {
  await dotenv.load();
}
