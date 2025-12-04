import 'package:asset_management/presentation/bloc/picking/picking_bloc.dart';
import 'package:get_it/get_it.dart';

pickingInjection(GetIt locator) {
  locator.registerFactory(
    () => PickingBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
}
