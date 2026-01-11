class UserCards {
    UserCards({
      required this.cards,
      required this.total,
    });

    final List<UserCardData> cards;
    final int total;

    factory UserCards.fromJson(Map<String, dynamic> json){ 
      return UserCards(
        cards: json["cards"] == null ? [] : List<UserCardData>.from(json["cards"]!.map((x) => UserCardData.fromJson(x))),
        total: json["total"] ?? 0,
      );
    }

    Map<String, dynamic> toJson() => {
      "cards": cards.map((x) => x.toJson()).toList(),
      "total": total,
    };

}

class UserCardData {
    UserCardData({
      required this.id,
      required this.cardNumber,
      required this.fullNumber,
      required this.expDate,
      required this.name,
      required this.bank,
      required this.isActive,
    });

    final int id;
    final String cardNumber;
    final String fullNumber;
    final String expDate;
    final String name;
    final String bank;
    final bool isActive;

    factory UserCardData.fromJson(Map<String, dynamic> json){ 
      return UserCardData(
        id: json["id"] ?? 0,
        cardNumber: json["card_number"] ?? "",
        fullNumber: json["full_number"] ?? "",
        expDate: json["exp_date"] ?? "",
        name: json["name"] ?? "",
        bank: json["bank"] ?? "",
        isActive: json["isActive"] ?? false,
      );
    }

    Map<String, dynamic> toJson() => {
      "id": id,
      "card_number": cardNumber,
      "full_number": fullNumber,
      "exp_date": expDate,
      "name": name,
      "bank": bank,
      "isActive": isActive,
    };

}

/*
{
	"cards": [
		{
			"id": 0,
			"card_number": "string",
			"full_number": "string",
			"exp_date": "string",
			"name": "string",
			"isActive": true
		}
	],
	"total": 0
}*/