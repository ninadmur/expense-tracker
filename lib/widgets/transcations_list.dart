import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/models/transcations.dart';

class TranscationsList extends StatelessWidget {
  TranscationsList(this.transcations, this.delete);

  final List<Transcations> transcations;
  Function delete;

  @override
  Widget build(BuildContext context) {
    return transcations.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                'No Transcations Found',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  height: 200.0,
                  child: Image.asset(
                    'images/waiting.png',
                    fit: BoxFit.cover,
                  ))
            ],
          )
        : ListView.builder(
            itemCount: transcations.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                elevation: 5.0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: 30.0,
                    child: Padding(
                      padding: EdgeInsets.all(
                        6.0,
                      ),
                      child: FittedBox(
                        child: Text('\$${transcations[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(transcations[index].title),
                  subtitle: Text(DateFormat.yMMMEd()
                      .format(transcations[index].dateTime)),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                    ),
                    onPressed: () => delete(transcations[index].id),
                  ),
                ),
              );
            },
          );
  }
}
