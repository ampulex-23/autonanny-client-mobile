class UserMoney {
    UserMoney({
      required this.balance,
      required this.history,
    });

    final double balance;
    final List<History> history;

    factory UserMoney.fromJson(Map<String, dynamic> json){ 
      return UserMoney(
        balance: json["balance"] ?? 0,
        history: json["history"] == null ? [] : List<History>.from(json["history"]!.map((x) => History.fromJson(x))),
      );
    }

    Map<String, dynamic> toJson() => {
      "balance": balance,
      "history": history.map((x) => x.toJson()).toList(),
    };

}

class History {
    History({
      required this.title,
      required this.amount,
      required this.description,
    });

    final String title;
    final String amount;
    final String description;

    factory History.fromJson(Map<String, dynamic> json){ 
      return History(
        title: json["title"] ?? "",
        amount: json["amount"] ?? "",
        description: json["description"] ?? "",
      );
    }

    Map<String, dynamic> toJson() => {
      "title": title,
      "amount": amount,
      "description": description,
    };

}

/*
{
	"balance": 0,
	"history": [
		{
			"title": "string",
			"amount": "string",
			"description": "string"
		}
	]
}*/