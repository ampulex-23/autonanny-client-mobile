import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/constants.dart';

class GeocodeData {
  GeocodeData({
    required this.plusCode,
    required this.geocodeResults,
    required this.status,
  });

  final PlusCode? plusCode;
  final List<GeocodeResult> geocodeResults;
  final String status;

  factory GeocodeData.fromJson(Map<String, dynamic> json) {
    return GeocodeData(
      plusCode: json["plus_code"] == null
          ? null
          : PlusCode.fromJson(json["plus_code"]),
      geocodeResults: json["results"] == null
          ? []
          : List<GeocodeResult>.from(
              json["results"]!.map((x) => GeocodeResult.fromJson(x))),
      status: json["status"] ?? "",
    );
  }
}

class GeocodeResult {
  GeocodeResult({
    required this.addressComponents,
    required this.formattedAddress,
    required this.geometry,
    required this.placeId,
    required this.plusCode,
    required this.types,
  });

  final List<AddressComponent> addressComponents;
  final String formattedAddress;
  final Geometry? geometry;
  final String placeId;
  final PlusCode? plusCode;
  final List<AddressType> types;

  factory GeocodeResult.fromJson(Map<String, dynamic> json) {
    return GeocodeResult(
      addressComponents: json["address_components"] == null
          ? []
          : List<AddressComponent>.from(json["address_components"]!
              .map((x) => AddressComponent.fromJson(x))),
      formattedAddress: json["formatted_address"] ?? "",
      geometry:
          json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
      placeId: json["place_id"] ?? "",
      plusCode: json["plus_code"] == null
          ? null
          : PlusCode.fromJson(json["plus_code"]),
      types: json["types"] == null
          ? []
          : List<AddressType>.from(
              json["types"]!.map((x) => AddressType.fromJsonKey(x))),
    );
  }
}

class AddressComponent {
  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  final String longName;
  final String shortName;
  final List<AddressType> types;

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    return AddressComponent(
      longName: json["long_name"] ?? "",
      shortName: json["short_name"] ?? "",
      types: json["types"] == null
          ? []
          : List<AddressType>.from(
              json["types"]!.map((x) => AddressType.fromJsonKey(x))),
    );
  }
}

class Geometry {
  Geometry({
    required this.location,
    this.locationType,
    this.viewport,
    this.bounds,
  });

  final LatLng? location;
  final LocationType? locationType;
  final Bounds? viewport;
  final Bounds? bounds;

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: json["location"] == null
          ? null
          : LatLng.fromJson((json["location"] as Map<String, dynamic>)
              .values
              .map((e) => e as double)
              .toList()),
      locationType: LocationType.fromJsonKey(json["location_type"]),
      viewport:
          json["viewport"] == null ? null : Bounds.fromJson(json["viewport"]),
      bounds: json["bounds"] == null ? null : Bounds.fromJson(json["bounds"]),
    );
  }
}

class Bounds {
  Bounds({
    required this.northeast,
    required this.southwest,
  });

  final LatLng northeast;
  final LatLng southwest;

  factory Bounds.fromJson(Map<String, dynamic> json) {
    return Bounds(
      northeast: LatLng.fromJson((json["northeast"] as Map<String, dynamic>)
          .values
          .map((e) => (e as num).toDouble())
          .toList())!,
      southwest: LatLng.fromJson((json["southwest"] as Map<String, dynamic>)
          .values
          .map((e) => (e as num).toDouble())
          .toList())!,
    );
  }
}

// class Location {
//     Location({
//         required this.lat,
//         required this.lng,
//     });

//     final double lat;
//     final double lng;

//     factory Location.fromJson(Map<String, dynamic> json){
//         return Location(
//             lat: json["lat"] ?? 0.0,
//             lng: json["lng"] ?? 0.0,
//         );
//     }

// }

class PlusCode {
  PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });

  final String compoundCode;
  final String globalCode;

  factory PlusCode.fromJson(Map<String, dynamic> json) {
    return PlusCode(
      compoundCode: json["compound_code"] ?? "",
      globalCode: json["global_code"] ?? "",
    );
  }
}

/*
{
	"plus_code": {
		"compound_code": "P27Q+MCM Нью-Йорк, США",
		"global_code": "87G8P27Q+MCM"
	},
	"results": [
		{
			"address_components": [
				{
					"long_name": "277",
					"short_name": "277",
					"types": [
						"street_number"
					]
				},
				{
					"long_name": "Bedford Avenue",
					"short_name": "Bedford Ave",
					"types": [
						"route"
					]
				},
				{
					"long_name": "Williamsburg",
					"short_name": "Williamsburg",
					"types": [
						"neighborhood",
						"political"
					]
				},
				{
					"long_name": "Brooklyn",
					"short_name": "Brooklyn",
					"types": [
						"political",
						"sublocality",
						"sublocality_level_1"
					]
				},
				{
					"long_name": "Kings County",
					"short_name": "Kings County",
					"types": [
						"administrative_area_level_2",
						"political"
					]
				},
				{
					"long_name": "New York",
					"short_name": "NY",
					"types": [
						"administrative_area_level_1",
						"political"
					]
				},
				{
					"long_name": "Соединенные Штаты Америки",
					"short_name": "US",
					"types": [
						"country",
						"political"
					]
				},
				{
					"long_name": "11211",
					"short_name": "11211",
					"types": [
						"postal_code"
					]
				}
			],
			"formatted_address": "277 Bedford Ave, Brooklyn, NY 11211, США",
			"geometry": {
				"location": {
					"lat": 40.7142205,
					"lng": -73.9612903
				},
				"location_type": "ROOFTOP",
				"viewport": {
					"northeast": {
						"lat": 40.71556948029149,
						"lng": -73.95994131970849
					},
					"southwest": {
						"lat": 40.7128715197085,
						"lng": -73.9626392802915
					}
				}
			},
			"place_id": "ChIJd8BlQ2BZwokRAFUEcm_qrcA",
			"plus_code": {
				"compound_code": "P27Q+MF Нью-Йорк, США",
				"global_code": "87G8P27Q+MF"
			},
			"types": [
				"street_address"
			]
		},
		{
			"address_components": [
				{
					"long_name": "279",
					"short_name": "279",
					"types": [
						"street_number"
					]
				},
				{
					"long_name": "Bedford Avenue",
					"short_name": "Bedford Ave",
					"types": [
						"route"
					]
				},
				{
					"long_name": "Williamsburg",
					"short_name": "Williamsburg",
					"types": [
						"neighborhood",
						"political"
					]
				},
				{
					"long_name": "Brooklyn",
					"short_name": "Brooklyn",
					"types": [
						"political",
						"sublocality",
						"sublocality_level_1"
					]
				},
				{
					"long_name": "Kings County",
					"short_name": "Kings County",
					"types": [
						"administrative_area_level_2",
						"political"
					]
				},
				{
					"long_name": "New York",
					"short_name": "NY",
					"types": [
						"administrative_area_level_1",
						"political"
					]
				},
				{
					"long_name": "Соединенные Штаты Америки",
					"short_name": "US",
					"types": [
						"country",
						"political"
					]
				},
				{
					"long_name": "11211",
					"short_name": "11211",
					"types": [
						"postal_code"
					]
				},
				{
					"long_name": "4203",
					"short_name": "4203",
					"types": [
						"postal_code_suffix"
					]
				}
			],
			"formatted_address": "279 Bedford Ave, Brooklyn, NY 11211, США",
			"geometry": {
				"bounds": {
					"northeast": {
						"lat": 40.7142628,
						"lng": -73.9612131
					},
					"southwest": {
						"lat": 40.7141534,
						"lng": -73.9613792
					}
				},
				"location": {
					"lat": 40.7142015,
					"lng": -73.96130769999999
				},
				"location_type": "ROOFTOP",
				"viewport": {
					"northeast": {
						"lat": 40.7155570802915,
						"lng": -73.95994716970849
					},
					"southwest": {
						"lat": 40.7128591197085,
						"lng": -73.96264513029149
					}
				}
			},
			"place_id": "ChIJRYYERGBZwokRAM4n1GlcYX4",
			"types": [
				"premise"
			]
		},
		{
			"address_components": [
				{
					"long_name": "277",
					"short_name": "277",
					"types": [
						"street_number"
					]
				},
				{
					"long_name": "Bedford Avenue",
					"short_name": "Bedford Ave",
					"types": [
						"route"
					]
				},
				{
					"long_name": "Williamsburg",
					"short_name": "Williamsburg",
					"types": [
						"neighborhood",
						"political"
					]
				},
				{
					"long_name": "Brooklyn",
					"short_name": "Brooklyn",
					"types": [
						"political",
						"sublocality",
						"sublocality_level_1"
					]
				},
				{
					"long_name": "Kings County",
					"short_name": "Kings County",
					"types": [
						"administrative_area_level_2",
						"political"
					]
				},
				{
					"long_name": "New York",
					"short_name": "NY",
					"types": [
						"administrative_area_level_1",
						"political"
					]
				},
				{
					"long_name": "Соединенные Штаты Америки",
					"short_name": "US",
					"types": [
						"country",
						"political"
					]
				},
				{
					"long_name": "11211",
					"short_name": "11211",
					"types": [
						"postal_code"
					]
				}
			],
			"formatted_address": "277 Bedford Ave, Brooklyn, NY 11211, США",
			"geometry": {
				"location": {
					"lat": 40.7142205,
					"lng": -73.9612903
				},
				"location_type": "ROOFTOP",
				"viewport": {
					"northeast": {
						"lat": 40.71556948029149,
						"lng": -73.95994131970849
					},
					"southwest": {
						"lat": 40.7128715197085,
						"lng": -73.9626392802915
					}
				}
			},
			"place_id": "ChIJF0hlQ2BZwokRsrY2RAlFbAE",
			"plus_code": {
				"compound_code": "P27Q+MF Бруклин, Нью-Йорк, США",
				"global_code": "87G8P27Q+MF"
			},
			"types": [
				"establishment",
				"point_of_interest"
			]
		},
		{
			"address_components": [
				{
					"long_name": "291-275",
					"short_name": "291-275",
					"types": [
						"street_number"
					]
				},
				{
					"long_name": "Bedford Avenue",
					"short_name": "Bedford Ave",
					"types": [
						"route"
					]
				},
				{
					"long_name": "Williamsburg",
					"short_name": "Williamsburg",
					"types": [
						"neighborhood",
						"political"
					]
				},
				{
					"long_name": "Brooklyn",
					"short_name": "Brooklyn",
					"types": [
						"political",
						"sublocality",
						"sublocality_level_1"
					]
				},
				{
					"long_name": "Kings County",
					"short_name": "Kings County",
					"types": [
						"administrative_area_level_2",
						"political"
					]
				},
				{
					"long_name": "New York",
					"short_name": "NY",
					"types": [
						"administrative_area_level_1",
						"political"
					]
				},
				{
					"long_name": "Соединенные Штаты Америки",
					"short_name": "US",
					"types": [
						"country",
						"political"
					]
				},
				{
					"long_name": "11211",
					"short_name": "11211",
					"types": [
						"postal_code"
					]
				}
			],
			"formatted_address": "291-275 Bedford Ave, Brooklyn, NY 11211, США",
			"geometry": {
				"bounds": {
					"northeast": {
						"lat": 40.7145065,
						"lng": -73.9612923
					},
					"southwest": {
						"lat": 40.7139055,
						"lng": -73.96168349999999
					}
				},
				"location": {
					"lat": 40.7142045,
					"lng": -73.9614845
				},
				"location_type": "GEOMETRIC_CENTER",
				"viewport": {
					"northeast": {
						"lat": 40.7155549802915,
						"lng": -73.96013891970848
					},
					"southwest": {
						"lat": 40.7128570197085,
						"lng": -73.96283688029149
					}
				}
			},
			"place_id": "ChIJ8ThWRGBZwokR3E1zUisk3LU",
			"types": [
				"route"
			]
		},
		{
			"address_components": [
				{
					"long_name": "P27Q+MC",
					"short_name": "P27Q+MC",
					"types": [
						"plus_code"
					]
				},
				{
					"long_name": "Нью-Йорк",
					"short_name": "Нью-Йорк",
					"types": [
						"locality",
						"political"
					]
				},
				{
					"long_name": "Нью-Йорк",
					"short_name": "NY",
					"types": [
						"administrative_area_level_1",
						"political"
					]
				},
				{
					"long_name": "Соединенные Штаты Америки",
					"short_name": "US",
					"types": [
						"country",
						"political"
					]
				}
			],
			"formatted_address": "P27Q+MC Нью-Йорк, США",
			"geometry": {
				"bounds": {
					"northeast": {
						"lat": 40.71425,
						"lng": -73.96137499999999
					},
					"southwest": {
						"lat": 40.714125,
						"lng": -73.9615
					}
				},
				"location": {
					"lat": 40.714224,
					"lng": -73.961452
				},
				"location_type": "GEOMETRIC_CENTER",
				"viewport": {
					"northeast": {
						"lat": 40.71553648029149,
						"lng": -73.96008851970849
					},
					"southwest": {
						"lat": 40.71283851970849,
						"lng": -73.96278648029151
					}
				}
			},
			"place_id": "GhIJWAIpsWtbREARHyv4bYh9UsA",
			"plus_code": {
				"compound_code": "P27Q+MC Нью-Йорк, США",
				"global_code": "87G8P27Q+MC"
			},
			"types": [
				"plus_code"
			]
		},
		{
			"address_components": [
				{
					"long_name": "Юг Уильямсберг",
					"short_name": "Юг Уильямсберг",
					"types": [
						"neighborhood",
						"political"
					]
				},
				{
					"long_name": "Бруклин",
					"short_name": "Бруклин",
					"types": [
						"political",
						"sublocality",
						"sublocality_level_1"
					]
				},
				{
					"long_name": "Кингс Каунти",
					"short_name": "Кингс Каунти",
					"types": [
						"administrative_area_level_2",
						"political"
					]
				},
				{
					"long_name": "Нью-Йорк",
					"short_name": "NY",
					"types": [
						"administrative_area_level_1",
						"political"
					]
				},
				{
					"long_name": "Соединенные Штаты Америки",
					"short_name": "US",
					"types": [
						"country",
						"political"
					]
				}
			],
			"formatted_address": "Юг Уильямсберг, Бруклин, Нью-Йорк, США",
			"geometry": {
				"bounds": {
					"northeast": {
						"lat": 40.7167119,
						"lng": -73.9420904
					},
					"southwest": {
						"lat": 40.6984866,
						"lng": -73.9699432
					}
				},
				"location": {
					"lat": 40.7043921,
					"lng": -73.9565551
				},
				"location_type": "APPROXIMATE",
				"viewport": {
					"northeast": {
						"lat": 40.7167119,
						"lng": -73.9420904
					},
					"southwest": {
						"lat": 40.6984866,
						"lng": -73.9699432
					}
				}
			},
			"place_id": "ChIJR3_ODdlbwokRYtN19kNtcuk",
			"types": [
				"neighborhood",
				"political"
			]
		},
		{
			"address_components": [
				{
					"long_name": "11211",
					"short_name": "11211",
					"types": [
						"postal_code"
					]
				},
				{
					"long_name": "Бруклин",
					"short_name": "Бруклин",
					"types": [
						"political",
						"sublocality",
						"sublocality_level_1"
					]
				},
				{
					"long_name": "Нью-Йорк",
					"short_name": "Нью-Йорк",
					"types": [
						"locality",
						"political"
					]
				},
				{
					"long_name": "Нью-Йорк",
					"short_name": "NY",
					"types": [
						"administrative_area_level_1",
						"political"
					]
				},
				{
					"long_name": "Соединенные Штаты Америки",
					"short_name": "US",
					"types": [
						"country",
						"political"
					]
				}
			],
			"formatted_address": "Бруклин, Нью-Йорк 11211, США",
			"geometry": {
				"bounds": {
					"northeast": {
						"lat": 40.7280089,
						"lng": -73.9207299
					},
					"southwest": {
						"lat": 40.7008331,
						"lng": -73.9644697
					}
				},
				"location": {
					"lat": 40.7093358,
					"lng": -73.9565551
				},
				"location_type": "APPROXIMATE",
				"viewport": {
					"northeast": {
						"lat": 40.7280089,
						"lng": -73.9207299
					},
					"southwest": {
						"lat": 40.7008331,
						"lng": -73.9644697
					}
				}
			},
			"place_id": "ChIJvbEjlVdZwokR4KapM3WCFRw",
			"types": [
				"postal_code"
			]
		},
		{
			"address_components": [
				{
					"long_name": "Уильямсберг",
					"short_name": "Уильямсберг",
					"types": [
						"neighborhood",
						"political"
					]
				},
				{
					"long_name": "Бруклин",
					"short_name": "Бруклин",
					"types": [
						"political",
						"sublocality",
						"sublocality_level_1"
					]
				},
				{
					"long_name": "Кингс Каунти",
					"short_name": "Кингс Каунти",
					"types": [
						"administrative_area_level_2",
						"political"
					]
				},
				{
					"long_name": "Нью-Йорк",
					"short_name": "NY",
					"types": [
						"administrative_area_level_1",
						"political"
					]
				},
				{
					"long_name": "Соединенные Штаты Америки",
					"short_name": "US",
					"types": [
						"country",
						"political"
					]
				}
			],
			"formatted_address": "Уильямсберг, Бруклин, Нью-Йорк, США",
			"geometry": {
				"bounds": {
					"northeast": {
						"lat": 40.7251773,
						"lng": -73.936498
					},
					"southwest": {
						"lat": 40.6979329,
						"lng": -73.96984499999999
					}
				},
				"location": {
					"lat": 40.7081156,
					"lng": -73.9570696
				},
				"location_type": "APPROXIMATE",
				"viewport": {
					"northeast": {
						"lat": 40.7251773,
						"lng": -73.936498
					},
					"southwest": {
						"lat": 40.6979329,
						"lng": -73.96984499999999
					}
				}
			},
			"place_id": "ChIJQSrBBv1bwokRbNfFHCnyeYI",
			"types": [
				"neighborhood",
				"political"
			]
		},
		{
			"address_components": [
				{
					"long_name": "Кингс Каунти",
					"short_name": "Кингс Каунти",
					"types": [
						"administrative_area_level_2",
						"political"
					]
				},
				{
					"long_name": "Бруклин",
					"short_name": "Бруклин",
					"types": [
						"political",
						"sublocality",
						"sublocality_level_1"
					]
				},
				{
					"long_name": "Нью-Йорк",
					"short_name": "NY",
					"types": [
						"administrative_area_level_1",
						"political"
					]
				},
				{
					"long_name": "Соединенные Штаты Америки",
					"short_name": "US",
					"types": [
						"country",
						"political"
					]
				}
			],
			"formatted_address": "Кингс Каунти, Бруклин, Нью-Йорк, США",
			"geometry": {
				"bounds": {
					"northeast": {
						"lat": 40.7394209,
						"lng": -73.8330411
					},
					"southwest": {
						"lat": 40.551042,
						"lng": -74.05663
					}
				},
				"location": {
					"lat": 40.6528762,
					"lng": -73.95949399999999
				},
				"location_type": "APPROXIMATE",
				"viewport": {
					"northeast": {
						"lat": 40.7394209,
						"lng": -73.8330411
					},
					"southwest": {
						"lat": 40.551042,
						"lng": -74.05663
					}
				}
			},
			"place_id": "ChIJOwE7_GTtwokRs75rhW4_I6M",
			"types": [
				"administrative_area_level_2",
				"political"
			]
		},
		{
			"address_components": [
				{
					"long_name": "Бруклин",
					"short_name": "Бруклин",
					"types": [
						"political",
						"sublocality",
						"sublocality_level_1"
					]
				},
				{
					"long_name": "Кингс Каунти",
					"short_name": "Кингс Каунти",
					"types": [
						"administrative_area_level_2",
						"political"
					]
				},
				{
					"long_name": "Нью-Йорк",
					"short_name": "NY",
					"types": [
						"administrative_area_level_1",
						"political"
					]
				},
				{
					"long_name": "Соединенные Штаты Америки",
					"short_name": "US",
					"types": [
						"country",
						"political"
					]
				}
			],
			"formatted_address": "Бруклин, Нью-Йорк, США",
			"geometry": {
				"bounds": {
					"northeast": {
						"lat": 40.739446,
						"lng": -73.8333651
					},
					"southwest": {
						"lat": 40.551042,
						"lng": -74.05663
					}
				},
				"location": {
					"lat": 40.6781784,
					"lng": -73.9441579
				},
				"location_type": "APPROXIMATE",
				"viewport": {
					"northeast": {
						"lat": 40.739446,
						"lng": -73.8333651
					},
					"southwest": {
						"lat": 40.551042,
						"lng": -74.05663
					}
				}
			},
			"place_id": "ChIJCSF8lBZEwokRhngABHRcdoI",
			"types": [
				"political",
				"sublocality",
				"sublocality_level_1"
			]
		},
		{
			"address_components": [
				{
					"long_name": "Нью-Йорк",
					"short_name": "Нью-Йорк",
					"types": [
						"locality",
						"political"
					]
				},
				{
					"long_name": "Нью-Йорк",
					"short_name": "NY",
					"types": [
						"administrative_area_level_1",
						"political"
					]
				},
				{
					"long_name": "Соединенные Штаты Америки",
					"short_name": "US",
					"types": [
						"country",
						"political"
					]
				}
			],
			"formatted_address": "Нью-Йорк, США",
			"geometry": {
				"bounds": {
					"northeast": {
						"lat": 40.9175771,
						"lng": -73.70027209999999
					},
					"southwest": {
						"lat": 40.4773991,
						"lng": -74.25908989999999
					}
				},
				"location": {
					"lat": 40.7127753,
					"lng": -74.0059728
				},
				"location_type": "APPROXIMATE",
				"viewport": {
					"northeast": {
						"lat": 40.9175771,
						"lng": -73.70027209999999
					},
					"southwest": {
						"lat": 40.4773991,
						"lng": -74.25908989999999
					}
				}
			},
			"place_id": "ChIJOwg_06VPwokRYv534QaPC8g",
			"types": [
				"locality",
				"political"
			]
		},
		{
			"address_components": [
				{
					"long_name": "Нью-Йорк",
					"short_name": "NY",
					"types": [
						"administrative_area_level_1",
						"political"
					]
				},
				{
					"long_name": "Соединенные Штаты Америки",
					"short_name": "US",
					"types": [
						"country",
						"political"
					]
				}
			],
			"formatted_address": "Нью-Йорк, США",
			"geometry": {
				"bounds": {
					"northeast": {
						"lat": 45.015861,
						"lng": -71.777491
					},
					"southwest": {
						"lat": 40.476578,
						"lng": -79.7625901
					}
				},
				"location": {
					"lat": 43.2994285,
					"lng": -74.21793260000001
				},
				"location_type": "APPROXIMATE",
				"viewport": {
					"northeast": {
						"lat": 45.015861,
						"lng": -71.777491
					},
					"southwest": {
						"lat": 40.476578,
						"lng": -79.7625901
					}
				}
			},
			"place_id": "ChIJqaUj8fBLzEwRZ5UY3sHGz90",
			"types": [
				"administrative_area_level_1",
				"political"
			]
		},
		{
			"address_components": [
				{
					"long_name": "Соединенные Штаты Америки",
					"short_name": "US",
					"types": [
						"country",
						"political"
					]
				}
			],
			"formatted_address": "Соединенные Штаты Америки",
			"geometry": {
				"bounds": {
					"northeast": {
						"lat": 74.071038,
						"lng": -66.885417
					},
					"southwest": {
						"lat": 18.7763,
						"lng": 166.9999999
					}
				},
				"location": {
					"lat": 37.09024,
					"lng": -95.712891
				},
				"location_type": "APPROXIMATE",
				"viewport": {
					"northeast": {
						"lat": 74.071038,
						"lng": -66.885417
					},
					"southwest": {
						"lat": 18.7763,
						"lng": 166.9999999
					}
				}
			},
			"place_id": "ChIJCzYy5IS16lQRQrfeQ5K5Oxw",
			"types": [
				"country",
				"political"
			]
		}
	],
	"status": "OK"
}*/
