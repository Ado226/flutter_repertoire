import 'package:flutter/foundation.dart';

class Note {
  final int? id;
  final String libelle;
  final String description;
  final String date;

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

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      libelle: map['libelle'],
      description: map['description'],
      date: map['date'],
    );
  }

  Note copy({int? id}) {
    return Note(
      id: id ?? this.id,
      libelle: this.libelle,
      description: this.description,
      date: this.date,
    );
  }
}
