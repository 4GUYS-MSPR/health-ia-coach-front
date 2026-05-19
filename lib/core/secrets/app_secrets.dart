import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppSecrets {
  static String baseUrl = dotenv.get('BASE_URL');
}
