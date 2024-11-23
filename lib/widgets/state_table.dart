import 'package:flutter/material.dart';
import '../models/state_model.dart';

class StateTable extends StatelessWidget {
  final List<StateModel> states;
  final int sortColumnIndex;
  final bool sortAscending;
  final Function(int, bool) onSort;

  const StateTable({
    Key? key,
    required this.states,
    required this.sortColumnIndex,
    required this.sortAscending,
    required this.onSort,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateColor.resolveWith(
            (states) => const Color.fromARGB(255, 54, 131, 194),
          ),
          sortColumnIndex: sortColumnIndex,
          sortAscending: sortAscending,
          columns: [
            DataColumn(
              label: const Text(
                'ID',
                style: TextStyle(color: Colors.white),
              ),
              onSort: (int columnIndex, bool ascending) => onSort(columnIndex, ascending),
            ),
            DataColumn(
              label: const Text(
                'Sigla',
                style: TextStyle(color: Colors.white),
              ),
              onSort: (int columnIndex, bool ascending) => onSort(columnIndex, ascending),
            ),
            DataColumn(
              label: const Text(
                'Nome',
                style: TextStyle(color: Colors.white),
              ),
              onSort: (int columnIndex, bool ascending) => onSort(columnIndex, ascending),
            ),
            DataColumn(
              label: const Text(
                'Região',
                style: TextStyle(color: Colors.white),
              ),
              onSort: (int columnIndex, bool ascending) => onSort(columnIndex, ascending),
            ),
          ],
          rows: states.map((state) {
            return DataRow(cells: [
              DataCell(Text(state.id.toString())),
              DataCell(Text(state.sigla)),
              DataCell(Text(state.nome)),
              DataCell(Text(state.regiao)),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}