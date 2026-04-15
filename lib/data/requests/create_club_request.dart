import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class CreateClubRequest extends BaseRequest<Club> {
  CreateClubRequest({
    required String name,
    String? description,
    String? groupLink,
  }) : super('/api/club', data: _buildClub(name, description, groupLink));

  static Club _buildClub(String name, String? description, String? groupLink) {
    final club = Club()..name = name;
    if (description != null) club.description = description;
    if (groupLink != null) club.groupLink = groupLink;
    return club;
  }

  @override
  FutureOr<Club> parse(List<int> bytes) {
    return compute(Club.fromBuffer, bytes);
  }
}
