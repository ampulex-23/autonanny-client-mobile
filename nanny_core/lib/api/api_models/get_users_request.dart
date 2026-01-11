import 'package:nanny_core/api/api_models/search_query_request.dart';

class GetUsersRequest extends SearchQueryRequest {
  GetUsersRequest({
    this.sort = 0,
    this.statuses = const [],
    
    int offset = 0,
    int limit = 50,
    String search = "",
  }) : super(
    offset: offset,
    limit: limit,
    search: search,
  );

  final int sort;
  final List<String> statuses;

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "sort": sort,
        "statuses": statuses,
      });
  }

  @override
  GetUsersRequest copyWith({
    int? sort,
    List<String>? statuses,

    int? offset,
    int? limit,
    String? search,
  }) => GetUsersRequest(
    sort: sort ?? this.sort,
    statuses: statuses ?? this.statuses,

    offset: offset ?? this.offset,
    limit: limit ?? this.limit,
    search: search ?? this.search,
  );
}