import 'dart:convert';

class SearchLocationResponse {
  List<dynamic>? results; 
  SearchLocationResponse({
    this.results,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(results != null){
      result.addAll({'results': results});
    }
  
    return result;
  }

  factory SearchLocationResponse.fromMap(Map<String, dynamic> map) {
    return SearchLocationResponse(
      results: List<dynamic>.from(map['results']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchLocationResponse.fromJson(String source) => SearchLocationResponse.fromMap(json.decode(source));
}
