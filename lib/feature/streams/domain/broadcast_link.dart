/// Хелпер построения диплинка оператора трансляции.
///
/// Универсален для турнирного и клубного контекста: передаётся ровно один из
/// [tournamentId]/[clubId] (заполненный > 0), второй оставляется null. Формат
/// URL совпадает с тем, что разбирает резолвер `/broadcast` и intent-filter в
/// AndroidManifest:
///
/// ```
/// https://mafbase.ru/broadcast?tournamentId=42&table=1&key=TOKEN
/// https://mafbase.ru/broadcast?clubId=7&table=1&key=TOKEN
/// ```
String buildBroadcastDeeplink({
  int? tournamentId,
  int? clubId,
  required int table,
  required String token,
}) {
  final params = <String, String>{
    if (tournamentId != null && tournamentId > 0) 'tournamentId': '$tournamentId',
    if (clubId != null && clubId > 0) 'clubId': '$clubId',
    'table': '$table',
    'key': token,
  };
  final uri = Uri.https('mafbase.ru', '/broadcast', params);
  return uri.toString();
}
