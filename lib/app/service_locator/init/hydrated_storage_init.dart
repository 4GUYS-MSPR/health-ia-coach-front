import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/logging/app_logger.dart';

Future<void> initHydratedStorage() async {
  final logger = AppLogger.instance.getLogger(
    'App.ServiceLocator.HydratedStorage',
  );

  logger.config('Initializing HydratedStorage...');

  try {
    final storageDirectory = kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path);

    logger.config(
      'Storage directory: ${kIsWeb ? "web" : (await getTemporaryDirectory()).path}',
    );

    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: storageDirectory,
    );

    logger.info('HydratedStorage initialized successfully');
  } catch (e, stackTrace) {
    logger.severe('Failed to initialize HydratedStorage', e, stackTrace);
    rethrow;
  }
}
