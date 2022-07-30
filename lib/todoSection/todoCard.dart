import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:first_project/todoSection/toDo.dart';
import 'package:first_project/todoSection/Home.dart';

Card TodoCard(data, index, checktodo, context, todoDate) {
  return Card(
      elevation: 3.00,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      key: Key(data.docs[index]['task']),
      child: ExpansionTile(
          leading: checktodo(data, index),
          title: Text(
            // data.docs[index]['task'],
            todoDate[newToDo.date]![newToDo.task],
            style: TextStyle(
                decoration: newToDo.isChecked == true
                    ? TextDecoration.lineThrough
                    : null,
                fontSize: 22),
          ),
          children: [
            ListTile(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add a reminder',
                    style: TextStyle(fontSize: 18),
                  ),
                  InkResponse(
                    child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Icon(
                          Icons.add_circle_outline_outlined,
                          size: 30,
                        )),
                    onTap: () {},
                  )
                ],
              ),
              trailing: InkWell(
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  ),
                  onTap: () {
                    FirebaseFirestore.instance
                        .runTransaction((Transaction myTransaction) async {
                      myTransaction.delete(data.docs[index].reference);
                    });
                  }),
            ),
          ]));
}
