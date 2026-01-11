class ChildMedicalInfo {
  ChildMedicalInfo({
    this.id,
    required this.idChild,
    this.allergies,
    this.chronicDiseases,
    this.medications,
    this.bloodType,
    this.insuranceNumber,
    this.insuranceScanPath,
    this.doctorNotes,
  });

  final int? id;
  final int idChild;
  final String? allergies;
  final String? chronicDiseases;
  final String? medications;
  final String? bloodType;
  final String? insuranceNumber;
  final String? insuranceScanPath;
  final String? doctorNotes;

  factory ChildMedicalInfo.fromJson(Map<String, dynamic> json) {
    return ChildMedicalInfo(
      id: json['id'],
      idChild: json['id_child'],
      allergies: json['allergies'],
      chronicDiseases: json['chronic_diseases'],
      medications: json['medications'],
      bloodType: json['blood_type'],
      insuranceNumber: json['insurance_number'],
      insuranceScanPath: json['insurance_scan_path'],
      doctorNotes: json['doctor_notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'id_child': idChild,
      if (allergies != null) 'allergies': allergies,
      if (chronicDiseases != null) 'chronic_diseases': chronicDiseases,
      if (medications != null) 'medications': medications,
      if (bloodType != null) 'blood_type': bloodType,
      if (insuranceNumber != null) 'insurance_number': insuranceNumber,
      if (insuranceScanPath != null) 'insurance_scan_path': insuranceScanPath,
      if (doctorNotes != null) 'doctor_notes': doctorNotes,
    };
  }
}
