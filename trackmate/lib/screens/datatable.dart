import 'package:flutter/material.dart';

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

  final List<String> _col1FilterOptions = ['All', 'Option 1', 'Option 2'];
  final List<String> _col2FilterOptions = ['All', 'Option A', 'Option B'];
  final List<String> _col3FilterOptions = ['All', 'Item X', 'Item Y'];

  @override
  void initState() {
    super.initState();
    // Generate your data rows here or load them from a data source.
    _rows = [
      DataRow(cells: [
        DataCell(Text('Option 1')),
        DataCell(Text('Option A')),
        DataCell(Text('Item X'))
      ]),
      DataRow(cells: [
        DataCell(Text('Option 2')),
        DataCell(Text('Option B')),
        DataCell(Text('Item Y'))
      ]),
      // Add more data rows as needed.
    ];
    _filteredRows = _rows;
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
            padding: const EdgeInsets.all(32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _selectedValueCol1,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedValueCol1 = newValue!;
                      _filterData();
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
                      _filterData();
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
                      _filterData();
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('Column 1'),
                  ),
                ),
                DataColumn(
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('Column 2'),
                  ),
                ),
                DataColumn(
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('Column 3'),
                  ),
                ),
              ],
              rows: _filteredRows,
            ),
          ),
        ],
      ),
    );
  }
}
