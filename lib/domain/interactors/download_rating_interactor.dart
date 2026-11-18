import 'package:flutter/material.dart';
import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/shared/club/domain/club_repository.dart';

class DownloadRatingInteractor extends BaseInteractor {
  final ClubRepository _clubRepository;

  DownloadRatingInteractor(this._clubRepository);

  Future run({required int clubId, required DateTimeRange range}) {
    return wrap(
      () => _clubRepository.downloadRating(
        clubId: clubId,
        range: range,
      ),
    );
  }

  @override
  String get interactorName => 'DownloadRatingInteractor';
}
