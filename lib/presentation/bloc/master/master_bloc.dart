import 'dart:async';
import 'package:asset_management/domain/entities/master/asset_brand.dart';
import 'package:asset_management/domain/entities/master/asset_category.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/master/asset_type.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/entities/master/preparation_template.dart';
import 'package:asset_management/domain/entities/master/preparation_template_item.dart';
import 'package:asset_management/domain/entities/master/vendor.dart';
import 'package:asset_management/domain/usecases/master/create_asset_brand_use_case.dart';
import 'package:asset_management/domain/usecases/master/create_asset_category_use_case.dart';
import 'package:asset_management/domain/usecases/master/create_asset_model_use_case.dart';
import 'package:asset_management/domain/usecases/master/create_asset_type_use_case.dart';
import 'package:asset_management/domain/usecases/master/create_location_use_case.dart';
import 'package:asset_management/domain/usecases/master/create_preparation_template_item_use_case.dart';
import 'package:asset_management/domain/usecases/master/create_preparation_template_use_case.dart';
import 'package:asset_management/domain/usecases/master/create_vendor_use_case.dart';
import 'package:asset_management/domain/usecases/master/delete_preparation_template_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_asset_brand_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_asset_category_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_asset_model_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_asset_type_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_location_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_preparation_template_item_by_template_id_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_preparation_template_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_vendor_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'master_event.dart';
part 'master_state.dart';

class MasterBloc extends Bloc<MasterEvent, MasterState> {
  final FindAllAssetBrandUseCase _allAssetBrandUseCase;
  final FindAllAssetCategoryUseCase _allAssetCategoryUseCase;
  final FindAllAssetModelUseCase _allAssetModelUseCase;
  final FindAllAssetTypeUseCase _allAssetTypeUseCase;
  final FindAllLocationUseCase _allLocationUseCase;
  final FindAllVendorUseCase _allVendorUseCase;
  final CreateAssetBrandUseCase _assetBrandUseCase;
  final CreateAssetCategoryUseCase _assetCategoryUseCase;
  final CreateAssetModelUseCase _assetModelUseCase;
  final CreateAssetTypeUseCase _assetTypeUseCase;
  final CreateLocationUseCase _createLocationUseCase;
  final CreateVendorUseCase _createVendorUseCase;
  final FindAllPreparationTemplateUseCase _allPreparationTemplateUseCase;
  final FindAllPreparationTemplateItemByTemplateIdUseCase
  _allPreparationTemplateItemByTemplateIdUseCase;
  final DeletePreparationTemplateUseCase _deletePreparationTemplateUseCase;
  final CreatePreparationTemplateUseCase _createPreparationTemplateUseCase;
  final CreatePreparationTemplateItemUseCase
  _createPreparationTemplateItemUseCase;

  MasterBloc(
    this._allAssetBrandUseCase,
    this._allAssetCategoryUseCase,
    this._allAssetModelUseCase,
    this._allAssetTypeUseCase,
    this._allLocationUseCase,
    this._allVendorUseCase,
    this._assetBrandUseCase,
    this._assetCategoryUseCase,
    this._assetModelUseCase,
    this._assetTypeUseCase,
    this._createLocationUseCase,
    this._createVendorUseCase,
    this._allPreparationTemplateUseCase,
    this._allPreparationTemplateItemByTemplateIdUseCase,
    this._deletePreparationTemplateUseCase,
    this._createPreparationTemplateUseCase,
    this._createPreparationTemplateItemUseCase,
  ) : super(MasterState()) {
    on<OnFindAllPreparationTemplateEvent>(_findAllPreparationTemplate);
    on<OnFindAllPreparationTemplateItemByIdEvent>(
      _findAllPreparationTemplateItems,
    );
    on<OnDeletePreparationTemplateEvent>(_deletePreparationTemplate);
    on<OnCreatePreparationTemplateItemEvent>(_createPreparationTemplateItems);
    on<OnFindAllBrandEvent>(_findAllBrand);
    on<OnFindAllCategoryEvent>(_findAllCategory);
    on<OnFindAllModelEvent>(_findAllModel);
    on<OnFindAllTypesEvent>(_findAllTypes);
    on<OnFindAllLocationEvent>(_findAllLocation);
    on<OnFindAllVendorEvent>(_findAllVendor);
    on<OnCreateBrandEvent>(_createBrand);
    on<OnCreateCategoryEvent>(_createCategory);
    on<OnCreateModelEvent>(_createModel);
    on<OnCreateTypeEvent>(_createType);
    on<OnCreateLocationEvent>(_createLocation);
    on<OnCreateVendorEvent>(_createVendor);
    on<OnInitializeMasterEvent>(_initializeMaster);
  }

  void _createPreparationTemplateItems(
    OnCreatePreparationTemplateItemEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(state.copyWith(status: StatusMaster.loading));

    final failureOrTemplates = await _createPreparationTemplateUseCase(
      event.template,
    );

    return failureOrTemplates.fold(
      (failure) => emit(
        state.copyWith(status: StatusMaster.failed, message: failure.message),
      ),
      (template) async {
        final failureOrResponse = await _createPreparationTemplateItemUseCase(
          event.params,
          template.id!,
        );

        return failureOrResponse.fold(
          (failure) => emit(
            state.copyWith(
              status: StatusMaster.failed,
              message: failure.message,
            ),
          ),
          (response) => emit(
            state.copyWith(
              status: StatusMaster.success,
              preparationTemplates: [...?state.preparationTemplates, template],
              preparationTemplateItems: response,
            ),
          ),
        );
      },
    );
  }

  void _deletePreparationTemplate(
    OnDeletePreparationTemplateEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(state.copyWith(status: StatusMaster.loading));

    final failureOrResponse = await _deletePreparationTemplateUseCase(
      event.params,
    );

    return failureOrResponse.fold(
      (failure) => emit(
        state.copyWith(status: StatusMaster.failed, message: failure.message),
      ),
      (_) => emit(
        state.copyWith(
          status: StatusMaster.success,
          preparationTemplates: state.preparationTemplates
            ?..removeWhere((element) => element.id == event.params),
        ),
      ),
    );
  }

  void _findAllPreparationTemplateItems(
    OnFindAllPreparationTemplateItemByIdEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(state.copyWith(status: StatusMaster.loading));

    final failureOrItems = await _allPreparationTemplateItemByTemplateIdUseCase(
      event.params,
    );

    return failureOrItems.fold(
      (failure) => emit(
        state.copyWith(status: StatusMaster.failed, message: failure.message),
      ),
      (items) => emit(
        state.copyWith(
          status: StatusMaster.success,
          preparationTemplateItems: items,
        ),
      ),
    );
  }

  void _findAllPreparationTemplate(
    OnFindAllPreparationTemplateEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(state.copyWith(status: StatusMaster.loading));

    final failureOrTemplates = await _allPreparationTemplateUseCase();

    return failureOrTemplates.fold(
      (failure) => emit(
        state.copyWith(status: StatusMaster.failed, message: failure.message),
      ),
      (templates) => emit(
        state.copyWith(
          status: StatusMaster.success,
          preparationTemplates: templates,
        ),
      ),
    );
  }

  void _initializeMaster(
    OnInitializeMasterEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(state.copyWith(status: StatusMaster.loading));

    final results = await Future.wait([
      _allAssetBrandUseCase(),
      _allAssetCategoryUseCase(),
      _allAssetModelUseCase(),
      _allAssetTypeUseCase(),
      _allLocationUseCase(),
      _allVendorUseCase(),
      _allPreparationTemplateUseCase(),
    ]);

    final brands = results[0].fold<List<AssetBrand>>(
      (failure) => [],
      (right) => right as List<AssetBrand>,
    );
    final categories = results[1].fold<List<AssetCategory>>(
      (failure) => [],
      (right) => right as List<AssetCategory>,
    );
    final models = results[2].fold<List<AssetModel>>(
      (failure) => [],
      (right) => right as List<AssetModel>,
    );
    final types = results[3].fold<List<AssetType>>(
      (failure) => [],
      (right) => right as List<AssetType>,
    );
    final locations = results[4].fold<List<Location>>(
      (failure) => [],
      (right) => right as List<Location>,
    );
    final vendors = results[5].fold<List<Vendor>>(
      (failure) => [],
      (right) => right as List<Vendor>,
    );
    final templates = results[6].fold<List<PreparationTemplate>>(
      (failure) => [],
      (right) => right as List<PreparationTemplate>,
    );

    emit(
      state.copyWith(
        brands: brands,
        categories: categories,
        models: models,
        types: types,
        locations: locations,
        vendors: vendors,
        preparationTemplates: templates,
        status: StatusMaster.success,
      ),
    );
  }

  void _createBrand(OnCreateBrandEvent event, Emitter<MasterState> emit) async {
    emit(state.copyWith(status: StatusMaster.loading));

    final failureOrBrand = await _assetBrandUseCase(event.params);

    return failureOrBrand.fold(
      (failure) => emit(
        state.copyWith(status: StatusMaster.failed, message: failure.message),
      ),
      (brand) => emit(
        state.copyWith(
          status: StatusMaster.success,
          brands: [...?state.brands, brand],
        ),
      ),
    );
  }

  void _createCategory(
    OnCreateCategoryEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(state.copyWith(status: StatusMaster.loading));

    final failureOrCategory = await _assetCategoryUseCase(event.params);

    return failureOrCategory.fold(
      (failure) => emit(
        state.copyWith(status: StatusMaster.failed, message: failure.message),
      ),
      (category) => emit(
        state.copyWith(
          status: StatusMaster.success,
          categories: [...?state.categories, category],
        ),
      ),
    );
  }

  void _createModel(OnCreateModelEvent event, Emitter<MasterState> emit) async {
    emit(state.copyWith(status: StatusMaster.loading));

    final failureOrModel = await _assetModelUseCase(event.params);

    return failureOrModel.fold(
      (failure) => emit(
        state.copyWith(status: StatusMaster.failed, message: failure.message),
      ),
      (model) => emit(
        state.copyWith(
          status: StatusMaster.success,
          models: [...?state.models, model],
        ),
      ),
    );
  }

  void _createType(OnCreateTypeEvent event, Emitter<MasterState> emit) async {
    emit(state.copyWith(status: StatusMaster.loading));

    final failureOrType = await _assetTypeUseCase(event.params);

    return failureOrType.fold(
      (failure) => emit(
        state.copyWith(status: StatusMaster.failed, message: failure.message),
      ),
      (type) => emit(
        state.copyWith(
          status: StatusMaster.success,
          types: [...?state.types, type],
        ),
      ),
    );
  }

  void _createLocation(
    OnCreateLocationEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(state.copyWith(status: StatusMaster.loading));

    final failureOrLocation = await _createLocationUseCase(event.params);

    return failureOrLocation.fold(
      (failure) => emit(
        state.copyWith(status: StatusMaster.failed, message: failure.message),
      ),
      (location) => emit(
        state.copyWith(
          status: StatusMaster.success,
          locations: [...?state.locations, location],
        ),
      ),
    );
  }

  void _createVendor(
    OnCreateVendorEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(state.copyWith(status: StatusMaster.loading));

    final failureOrVendor = await _createVendorUseCase(event.params);

    return failureOrVendor.fold(
      (failure) => emit(
        state.copyWith(status: StatusMaster.failed, message: failure.message),
      ),
      (vendor) => emit(
        state.copyWith(
          status: StatusMaster.success,
          vendors: [...?state.vendors, vendor],
        ),
      ),
    );
  }

  void _findAllBrand(
    OnFindAllBrandEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(state.copyWith(status: StatusMaster.loading));

    final failureOrBrand = await _allAssetBrandUseCase();

    return failureOrBrand.fold(
      (failure) => emit(
        state.copyWith(status: StatusMaster.failed, message: failure.message),
      ),
      (brands) => emit(state.copyWith(brands: brands)),
    );
  }

  void _findAllCategory(
    OnFindAllCategoryEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(state.copyWith(status: StatusMaster.loading));

    final failureOrCategory = await _allAssetCategoryUseCase();

    return failureOrCategory.fold(
      (failure) => emit(
        state.copyWith(status: StatusMaster.failed, message: failure.message),
      ),
      (categories) => emit(state.copyWith(categories: categories)),
    );
  }

  void _findAllModel(
    OnFindAllModelEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(state.copyWith(status: StatusMaster.loading));

    final failureOrModel = await _allAssetModelUseCase();

    return failureOrModel.fold(
      (failure) => emit(
        state.copyWith(status: StatusMaster.failed, message: failure.message),
      ),
      (models) => emit(state.copyWith(models: models)),
    );
  }

  void _findAllTypes(
    OnFindAllTypesEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(state.copyWith(status: StatusMaster.loading));

    final failureOrTypes = await _allAssetTypeUseCase();

    return failureOrTypes.fold(
      (failure) => emit(
        state.copyWith(status: StatusMaster.failed, message: failure.message),
      ),
      (types) => emit(state.copyWith(types: types)),
    );
  }

  void _findAllLocation(
    OnFindAllLocationEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(state.copyWith(status: StatusMaster.loading));

    final failureOrLocations = await _allLocationUseCase();

    return failureOrLocations.fold(
      (failure) => emit(
        state.copyWith(status: StatusMaster.failed, message: failure.message),
      ),
      (locations) => emit(state.copyWith(locations: locations)),
    );
  }

  void _findAllVendor(
    OnFindAllVendorEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(state.copyWith(status: StatusMaster.loading));

    final failureOrVendors = await _allVendorUseCase();

    return failureOrVendors.fold(
      (failure) => emit(
        state.copyWith(status: StatusMaster.failed, message: failure.message),
      ),
      (vendors) => emit(state.copyWith(vendors: vendors)),
    );
  }
}
