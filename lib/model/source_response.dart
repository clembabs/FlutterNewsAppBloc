
// class SourceResponse {
//   final List <SourceModel> sources;
//   final String error;

//   SourceResponse(this.sources, this.error);
  
//   SourceResponse.fromJson(Map<String, dynamic> json) :
//   sources =(json["sources"] as List).map((e) => SourceModel.fromJson(e)).toList(),
//   error = "";

//   SourceResponse.withError(String errorValue) :
//   sources = List(),
//   error = errorValue;
// }