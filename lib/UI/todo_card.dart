import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Card todoCard(
  QuerySnapshot<Object?> data,
  int index,
  context,
  todoDate,
  todo,
  List<String> todos
) {
  return Card(
      elevation: 3.00,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      key: Key(data.docs[index]['task']),
      child: ExpansionTile(
          leading: checktodo(data, index),
          title: Text(todo
            ,style: TextStyle(
                decoration: data.docs[index]['isChecked'] == true
                    ? TextDecoration.lineThrough
                    : null,
                fontSize: 22),
          ),
          children: [
            ListTile(
              title: Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const TextField(
                    decoration: InputDecoration(
                        hintText: 'Add a sub-task',
                        constraints:
                            BoxConstraints(maxHeight: 100, maxWidth: 160)),
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
                    //delete from firebase
                    FirebaseFirestore.instance
                        .runTransaction((Transaction myTransaction) async {
                      myTransaction.delete(data.docs[index].reference);
                    });
                    //delete from todos
                    
                    // todos.remove(todo);

                  }),
            ),
          ]));
}

Widget checktodo(data, index) {
  return Padding(
    padding: const EdgeInsets.all(3),
    child: Checkbox(
        value: data.docs[index]['isChecked'],
        onChanged: (newValue) =>
            data.docs[index].reference.update({'isChecked': newValue})),
  );
}
