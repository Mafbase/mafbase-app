import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/feature/custom_columns/data/requests/create_custom_column_request.dart';
import 'package:seating_generator_web/feature/custom_columns/data/requests/delete_custom_column_request.dart';
import 'package:seating_generator_web/feature/custom_columns/data/requests/get_custom_columns_request.dart';
import 'package:seating_generator_web/feature/custom_columns/data/requests/update_custom_column_request.dart';
import 'package:seating_generator_web/feature/custom_columns/data/requests/validate_formula_request.dart';
import 'package:seating_generator_web/feature/custom_columns/domain/models/custom_column_model.dart';
import 'package:seating_generator_web/feature/custom_columns/domain/models/formula_validation_result.dart';
import 'package:seating_generator_web/feature/custom_columns/domain/repository/custom_columns_repository.dart';

class CustomColumnsRepositoryImpl extends BaseRepository
    implements CustomColumnsRepository {
  CustomColumnsRepositoryImpl(super.client);

  @override
  Future<List<CustomColumnModel>> getColumns({required int clubId}) async {
    final response =
        await GetCustomColumnsRequest(clubId: clubId).execute(client);
    return response.columns
        .map((e) => CustomColumnModel.fromProto(e))
        .toList();
  }

  @override
  Future<CustomColumnModel> createColumn({
    required int clubId,
    required String title,
    required String formula,
  }) async {
    final response = await CreateCustomColumnRequest(
      clubId: clubId,
      title: title,
      formula: formula,
    ).execute(client);
    return CustomColumnModel.fromProto(response);
  }

  @override
  Future<void> updateColumn({
    required int clubId,
    required int columnId,
    required String title,
    required String formula,
  }) async {
    await UpdateCustomColumnRequest(
      clubId: clubId,
      columnId: columnId,
      title: title,
      formula: formula,
    ).execute(client);
  }

  @override
  Future<void> deleteColumn({
    required int clubId,
    required int columnId,
  }) async {
    await DeleteCustomColumnRequest(
      clubId: clubId,
      columnId: columnId,
    ).execute(client);
  }

  @override
  Future<FormulaValidationResult> validateFormula({
    required int clubId,
    required String formula,
  }) async {
    final response = await ValidateFormulaRequest(
      clubId: clubId,
      formula: formula,
    ).execute(client);
    return FormulaValidationResult.fromProto(response);
  }
}
