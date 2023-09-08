import 'dart:convert';

class SearchLocationResponse {
  List<dynamic>? items; 
  SearchLocationResponse({
    this.items,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(items != null){
      result.addAll({'items': items});
    }
  
    return result;
  }

  factory SearchLocationResponse.fromMap(Map<String, dynamic> map) {
    return SearchLocationResponse(
      items: List<dynamic>.from(map['items']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchLocationResponse.fromJson(String source) => SearchLocationResponse.fromMap(json.decode(source));
}
