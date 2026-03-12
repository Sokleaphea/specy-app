class Species {
  final int? id;
  final String? scientificName;
  final String? conservationStatus;
  final String? group;
  final String? isoCode;
  final String? commonName;
  final String? image;
  const Species({
    this.id,
    this.scientificName,
    this.conservationStatus,
    this.group,
    this.isoCode,
    this.commonName,
    this.image,
  });

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      id: json['id'],
      scientificName: json['scientific_name'],
      conservationStatus: json['conservation_status'],
      group: json['group'],
      isoCode: json['iso_code'],
      commonName: json['common_name'],
      image: json['image'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'scientificName': scientificName,
      'conservationStatus': conservationStatus,
      'group': group,
      'isoCode': isoCode,
      'commonName': commonName,
      'image': image,
    };
  }
}
