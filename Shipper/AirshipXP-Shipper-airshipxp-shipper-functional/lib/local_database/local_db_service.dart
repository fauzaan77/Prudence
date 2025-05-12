import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE address(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        shortaddress TEXT,
        description TEXT,
        latitude NUMERIC,
        longitude NUMERIC
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'airshipShipper.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item
  static Future<int> createAddress(String? shortaddress, String? description,
      double lat, double long) async {
    final db = await DatabaseHelper.db();

    final data = {
      'shortaddress': shortaddress,
      'description': description,
      'latitude': lat,
      'longitude': long
    };
    final id = await db.insert('address', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getAddress() async {
    final db = await DatabaseHelper.db();
    return db.rawQuery(
        "SELECT DISTINCT shortaddress, description, latitude, longitude FROM address");
  }

  // Delete
  static Future<void> deleteAddress() async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("address");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
