import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/state_model.dart';
import '../widgets/state_table.dart';
import '../config/config.dart';

class HomeScreen extends StatefulWidget {
  final String env;
  const HomeScreen({super.key, required this.env});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<StateModel> states = [];
  List<StateModel> filteredStates = [];
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchStates();
    _searchController.addListener(_filterStates);
  }

  Future<void> fetchStates() async {
    try {
      final apiService = ApiService();
      final fetchedStates = await apiService.fetchStates();
      setState(() {
        states = fetchedStates;
        filteredStates = states;
      });
    } catch (e) {
      // Handle error
    }
  }

  void _filterStates() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredStates = states.where((state) {
        final name = state.nome.toLowerCase();
        return name.startsWith(query);
      }).toList();
    });
  }

  void _sort<T>(Comparable<T> Function(StateModel state) getField, int columnIndex, bool ascending) {
    filteredStates.sort((a, b) {
      if (!ascending) {
        final StateModel c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estados do Brasil'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Buscar por Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: StateTable(
                  states: filteredStates,
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  onSort: (columnIndex, ascending) {
                    if (columnIndex == 0) {
                      _sort<num>((state) => state.id, columnIndex, ascending);
                    } else if (columnIndex == 1) {
                      _sort<String>((state) => state.sigla, columnIndex, ascending);
                    } else if (columnIndex == 2) {
                      _sort<String>((state) => state.nome, columnIndex, ascending);
                    } else if (columnIndex == 3) {
                      _sort<String>((state) => state.regiao, columnIndex, ascending);
                    }
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Ambiente: ${widget.env}\nBase URL: ${Config.baseUrl}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}