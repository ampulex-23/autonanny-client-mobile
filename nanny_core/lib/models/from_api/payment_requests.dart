class PaymentRequests {
    PaymentRequests({
        required this.id,
        required this.idUser,
        required this.money,
        required this.surname,
        required this.name,
        required this.photoPath,
    });

    final int id;
    final int idUser;
    final String money;
    final String surname;
    final String name;
    final String photoPath;

    factory PaymentRequests.fromJson(Map<String, dynamic> json){ 
        return PaymentRequests(
            id: json["id"] ?? 0,
            idUser: json["id_user"] ?? 0,
            money: json["money"] ?? "",
            surname: json["surname"] ?? "",
            name: json["name"] ?? "",
            photoPath: json["photo_path"] ?? "",
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "money": money,
        "surname": surname,
        "name": name,
        "photo_path": photoPath,
    };

}

/*
{
	"id": 0,
	"id_user": 0,
	"money": "string",
	"surname": "string",
	"name": "string",
	"photo_path": "string"
}*/