class EmergencyContact {
  EmergencyContact({
    this.id,
    required this.idChild,
    required this.name,
    required this.relationship,
    required this.phone,
    this.priority,
  });

  final int? id;
  final int idChild;
  final String name;
  final String relationship;
  final String phone;
  final int? priority;

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      id: json['id'],
      idChild: json['id_child'],
      name: json['name'],
      relationship: json['relationship'],
      phone: json['phone'],
      priority: json['priority'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'id_child': idChild,
      'name': name,
      'relationship': relationship,
      'phone': phone,
      if (priority != null) 'priority': priority,
    };
  }
}
