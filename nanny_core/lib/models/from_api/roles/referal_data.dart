class Referal {
    Referal({
        required this.allIncoming,
        required this.getPercent,
    });

    final int allIncoming;
    final double getPercent;

    factory Referal.fromJson(Map<String, dynamic> json){ 
        return Referal(
            allIncoming: json["all_incoming"] ?? 0,
            getPercent: json["get_percent"] ?? 0,
        );
    }

    Map<String, dynamic> toJson() => {
        "all_incoming": allIncoming,
        "get_percent": getPercent,
    };

}