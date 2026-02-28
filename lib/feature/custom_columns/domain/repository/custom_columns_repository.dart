import 'package:seating_generator_web/feature/custom_columns/domain/models/custom_column_model.dart';
import 'package:seating_generator_web/feature/custom_columns/domain/models/formula_validation_result.dart';

abstract interface class CustomColumnsRepository {
  Future<List<CustomColumnModel>> getColumns({required int clubId});

  Future<CustomColumnModel> createColumn({
    required int clubId,
    required String title,
    required String formula,
  });

  Future<void> updateColumn({
    required int clubId,
    required int columnId,
    required String title,
    required String formula,
  });

  Future<void> deleteColumn({
    required int clubId,
    required int columnId,
  });

  Future<FormulaValidationResult> validateFormula({
    required int clubId,
    required String formula,
  });
}
