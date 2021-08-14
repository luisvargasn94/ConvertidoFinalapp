import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String> _medidas = [
    'Metros',
    'Kilometros',
    'Gramos',
    'Kilogramos',
    'Pies',
    'Millas',
    'Libras',
    'Onzas',
  ];

  late String _startM;
  late String _endM;

  late String endValue = '0';

  late int _startI;
  late int _endI;

  final _formulas = [
    [1, 0.001, 0, 0, 3.281, 0.000621371, 0, 0],
    [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    [0, 0, 1, 0.001, 0, 0, 0.0022, 0.035274],
    [0, 0, 1000, 1, 0, 0, 220.462, 35.274],
    [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    [0.000621371, 1.60934, 0, 0, 5280, 1, 0, 0],
    [0, 0, 453.592, 0.45359, 0, 0, 1, 16],
    [0, 0, 28.3495, 0, 0, 0, 0, 1],
  ];

  final valueController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    this._startI = 0;
    this._endI = 1;

    this._startM = this._medidas[this._startI];
    this._endM = this._medidas[this._endI];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(color: Colors.white, fontSize: 20);
    final medidaStyle = TextStyle(color: Colors.black, fontSize: 18);

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(18, 16, 64, 1),
          title: Text('ConvertidorApp', style: labelStyle)),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blue[50],
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Valor',
                    style: TextStyle(color: Color.fromRGBO(18, 16, 64, 1))),
              ),
              TextField(
                controller: valueController,
                decoration: InputDecoration(
                    hintText: 'Digite el valor inicial',
                    contentPadding: EdgeInsets.all(8)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('De'),
              ),
              DropdownButton<String>(
                  isExpanded: true,
                  value: _startM,
                  items: _medidas.map((m) {
                    return DropdownMenuItem(
                        value: m,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            m,
                            style: medidaStyle,
                          ),
                        ));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _startM = value!;
                      _startI = _medidas.indexOf(_startM);
                    });
                  }),
              SizedBox(
                height: 12,
              ),
              Text('Para'),
              DropdownButton<String>(
                  isExpanded: true,
                  value: _endM,
                  items: _medidas.map((m) {
                    return DropdownMenuItem(
                        value: m,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            m,
                            style: medidaStyle,
                          ),
                        ));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _endM = value!;
                      _endI = _medidas.indexOf(_endM);
                    });
                  }),

              /* TextButton(
                //onPressed:null,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: null,
                child: const Text('Convertidor'),
              ),

               RaisedButton(
                onPressed: null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Convertir',
                    style: medidaStyle,
                  ),
                ),
              ),
              */
              //Spacer(),

              MaterialButton(
                minWidth: 200.0,
                height: 40.0,
                onPressed: () {
                  try {
                    final value = double.parse(valueController.text.trim());
                    _formulas[_startI][_endI];
                    print('$_startI $_endI ${_formulas[_startI][_endI]}');
                    this.endValue = '${_formulas[_startI][_endI]}';
                    setState(() {});
                    FocusScope.of(context).requestFocus(FocusNode());
                  } catch (e) {
                    print('Revisar conversion');
                  }

                  //print(valueController.text);
                },
                color: Color.fromRGBO(18, 16, 64, 1),
                child: Text('Convertir', style: TextStyle(color: Colors.white)),
              ),

              SizedBox(
                height: 20,
              ),
              Text(endValue, style: medidaStyle),
            ],
          ),
        ),
      ),
    ));
  }
}
