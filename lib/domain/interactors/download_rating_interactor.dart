import 'package:flutter/material.dart';
import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';

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
