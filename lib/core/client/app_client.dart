import 'package:chopper/chopper.dart';
import 'package:dummy_clean_project/core/constants.dart';

import 'package:dummy_clean_project/features/products/data/service/product_service.dart';

class AppClient extends ChopperClient {
  AppClient()
      : super(
          baseUrl: Uri.parse(AppConstants.baseUrl),
          services: [
            ProductListService.create(),
          ],
          interceptors: [
            const HeadersInterceptor(
              {'Content-Type': 'application/json'},
            )
          ],
        );
}
