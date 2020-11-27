import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expense/models/transcations.dart';
import 'package:personal_expense/widgets/chart.dart';
import 'package:personal_expense/widgets/new_transcations.dart';
import 'package:personal_expense/widgets/transcations_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transcations> _transcation = [
    // Transcations(
    //   id: 'fgg',
    //   title: 'New Shoes',
    //   amount: 3999.0,
    //   dateTime: DateTime.now(),
    // ),
    // Transcations(
    //   id: 'gd',
    //   title: 'New Jacket',
    //   amount: 4999.0,
    //   dateTime: DateTime.now(),
    // )
  ];

  void _addNewTranscation(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transcations(
        title: txTitle,
        amount: txAmount,
        dateTime: chosenDate,
        id: DateTime.now().toString());
    setState(() {
      _transcation.add(newTx);
    });
  }

  void _startAddNewTranscation(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTranscations(_addNewTranscation);
        });
  }

  List<Transcations> get _recentTranscations {
    return _transcation.where((element) {
      return element.dateTime
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void deleteTranscation(String id) {
    setState(() {
      _transcation.removeWhere((element) => element.id == id);
    });
  }

  final appBar = AppBar(
    title: Text('Expense App'),
    centerTitle: true,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(_recentTranscations)),
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.7,
                  child: TranscationsList(_transcation, deleteTranscation)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewTranscation(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
