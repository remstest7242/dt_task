/// event venue details data model
class EventVenueRowModel {

  String displayLocation = "";


  EventVenueRowModel();

  // parsing json data to object class
  EventVenueRowModel.fromJson(Map<String, dynamic> json) {
    displayLocation = json['display_location'] != null ? json['display_location'] : "";
  }

  // parsing object class to json data
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['display_location'] = this.displayLocation;
    return data;
  }

}
