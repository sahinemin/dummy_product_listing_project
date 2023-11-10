import 'package:chopper/chopper.dart';
import 'package:dummy_clean_project/core/constants.dart';
import 'package:dummy_clean_project/features/products/service/product_service.dart';

final class AppClient extends ChopperClient {
  AppClient()
      : super(
          baseUrl: Uri.parse(AppConstants.kbaseUrl),
          services: [
            ProductService.create(),
          ],
          interceptors: [
            const HeadersInterceptor(
              {'Content-Type': 'application/json'},
            ),
          ],
          converter: const JsonConverter(),
        );
}
