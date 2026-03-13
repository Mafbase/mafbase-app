import 'package:flutter/material.dart';
import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/rating_model.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';

class GetRatingInteractor extends BaseInteractor {
  final ClubRepository _clubRepository;

  GetRatingInteractor(this._clubRepository);

  Future<RatingModel> run({
    required int clubId,
    required DateTimeRange range,
  }) {
    return wrap(() => _clubRepository.getRating(clubId: clubId, range: range));
  }

  @override
  String get interactorName => 'GetRatingInteractor';
}
