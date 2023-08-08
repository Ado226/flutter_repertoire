class Note {
  int? id;
  String libelle;
  String description;
  String date;

  Note({
    this.id,
    required this.libelle,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'libelle': libelle,
      'description': description,
      'date': date,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      libelle: map['libelle'],
      description: map['description'],
      date: map['date'],
    );
  }
}
