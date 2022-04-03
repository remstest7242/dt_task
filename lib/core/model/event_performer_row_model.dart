/// country performer details data model
class EventPerformerRowModel {

  String image = "";

  // parsing json data to object class
  EventPerformerRowModel.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? json['image'] : "";
  }

  // parsing object class to json data
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }

}
