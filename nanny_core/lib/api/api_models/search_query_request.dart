import 'package:nanny_core/api/api_models/base_models/base_request.dart';

class SearchQueryRequest implements NannyBaseRequest {
  SearchQueryRequest({
    this.offset = 0,
    this.limit = 50,
    this.search = "",
  });

  final int offset;
  final int limit;
  final String search;

  SearchQueryRequest.fromJson(Map<String, dynamic> json)
    : offset = json['offset'],
      limit = json['limit'],
      search = json['search'];
  
  @override
  Map<String, dynamic> toJson() => {
    "offset":offset,
    "limit": limit,
    "search": search,
  };

  Map<String, dynamic> toJsonWithoutQuery() => {
    "offset":offset,
    "limit": limit,
  };

  SearchQueryRequest copyWith({
    int? offset,
    int? limit,
    String? search    
  }) {
    return SearchQueryRequest(
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      search: search ?? this.search
    );
  }
}