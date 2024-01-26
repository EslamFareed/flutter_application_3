import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Database database;

  createDataBase() async {
    String path = await getDatabasesPath();

    String dbPath = join(path, "test.db");

    database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE Todo ( id INTEGER PRIMARY KEY, title TEXT, body TEXT )");
      },
    );
  }

  @override
  void initState() {
    createDataBase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                int id = await database.insert("Todo", {
                  "id": 2,
                  "title": "Sqflite session",
                  "body": "This session is so important"
                });

                print(id);
              },
              child: Text("Insert data"),
            ),
            ElevatedButton(
              onPressed: () async {
                var list = await database.query("Todo");

                print(list);
              },
              child: Text("Get data"),
            ),
            ElevatedButton(
              onPressed: () async {
                int no = await database
                    .delete("Todo", where: "id = ?", whereArgs: [1]);
                print(no);
              },
              child: Text("Delete data"),
            ),
            ElevatedButton(
              onPressed: () async {
                int no = await database.update(
                    "Todo",
                    {
                      "title": "Edited",
                      "body": "This session is h5a!!!",
                    },
                    where: "id = ?",
                    whereArgs: [2]);

                print(no);
              },
              child: Text("Update data"),
            ),
          ],
        ),
      ),
    );
  }
}
