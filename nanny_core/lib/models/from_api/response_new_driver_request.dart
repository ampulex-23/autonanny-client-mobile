import 'package:nanny_core/nanny_core.dart';

class ResponseNewDriverRequest implements NannyBaseRequest {
    ResponseNewDriverRequest({
        required this.idDriver,
        required this.success,
        required this.idTariff,
    });

    final int idDriver;
    final bool success;
    final List<int> idTariff;

    @override
    Map<String, dynamic> toJson() => {
        "id_driver": idDriver,
        "success": success,
        "id_tariff": idTariff.map((x) => x).toList(),
    };

}

/*
{
	"id_driver": 0,
	"success": false,
	"id_tariff": [
		0
	]
}*/