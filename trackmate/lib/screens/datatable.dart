import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lottie/lottie.dart';

class FilterableDataTable extends StatefulWidget {
  @override
  _FilterableDataTableState createState() => _FilterableDataTableState();
}

class _FilterableDataTableState extends State<FilterableDataTable> {
  List<DataRow> _rows = [];
  List<DataRow> _filteredRows = [];

  String _selectedValueCol1 = 'All';
  String _selectedValueCol2 = 'All';
  String _selectedValueCol3 = 'All';

  final List<String> _col1FilterOptions = [
    'All',
    'Janhavi Baikerikar',
    'Prasad Padalkar',
    "Mrudul ma'am"
  ];
  final List<String> _col2FilterOptions = ['All', 'IOE', 'MIS', 'STQA'];
  final List<String> _col3FilterOptions = [
    'All',
    '09:00-10:00',
    '10:00-11:00',
    '11:15-12:15',
    '12:15-01:15'
  ];

  @override
  void initState() {
    super.initState();
    // Fetch data from the API and populate _rows
    fetchDataFromAPI();
  }

  Future<List<DataRow>> fetchDataFromAPI() async {
    await Future.delayed(Duration(seconds: 2));
    final response = await http.get(Uri.parse(
        'https://gist.githubusercontent.com/tushar4303/7e79e4d1e06e7c6a122315524c64d8ee/raw/ca4a42ddbe5360cd52ecc73851166a5b41da6ae6/studentAttendance'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((row) {
        return DataRow(cells: [
          DataCell(Text(row['name'])),
          DataCell(Text(row['roll_no'].toString())),
          DataCell(Text(row['branch'])),
        ]);
      }).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  void _filterData() {
    _filteredRows = _rows.where((row) {
      final col1Value = row.cells[0].child.toString();
      final col2Value = row.cells[1].child.toString();
      final col3Value = row.cells[2].child.toString();

      return (_selectedValueCol1 == 'All' ||
              col1Value.contains(_selectedValueCol1)) &&
          (_selectedValueCol2 == 'All' ||
              col2Value.contains(_selectedValueCol2)) &&
          (_selectedValueCol3 == 'All' ||
              col3Value.contains(_selectedValueCol3));
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filterable DataTable'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: _selectedValueCol1,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedValueCol1 = newValue!;
                    });
                  },
                  items: _col1FilterOptions.map((option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: _selectedValueCol2,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedValueCol2 = newValue!;
                    });
                  },
                  items: _col2FilterOptions.map((option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: _selectedValueCol3,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedValueCol3 = newValue!;
                    });
                  },
                  items: _col3FilterOptions.map((option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          FutureBuilder<List<DataRow>>(
            future: fetchDataFromAPI(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Lottie.asset('assets/animation_lnsgqs58.json'),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Roll No.')),
                      DataColumn(label: Text('Branch')),
                    ],
                    rows: snapshot.data ?? [],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
