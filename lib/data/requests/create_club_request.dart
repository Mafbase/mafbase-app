import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class CreateClubRequest extends BaseRequest<Club> {
  CreateClubRequest({
    required String name,
    String? description,
    String? groupLink,
  }) : super(
          '/api/club',
          data: Club(
            name: name,
            description: description ?? '',
            groupLink: groupLink ?? '',
          ),
        );

  @override
  FutureOr<Club> parse(List<int> bytes) {
    return compute(Club.fromBuffer, bytes);
  }
}
