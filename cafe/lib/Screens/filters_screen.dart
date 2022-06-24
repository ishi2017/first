import 'package:flutter/material.dart';
import '../Widgets/main_drawer.dart';
import '../Models/filters_status.dart';

class FiltersScreen extends StatefulWidget {
  static final String RouteName = '/Filter_Screen';
  final Function saveFilter;
  final filterStatus currentFilter;
  const FiltersScreen({Key key, this.saveFilter, this.currentFilter})
      : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Widget _buildSwitchTiles(
      {String title,
      String description,
      bool currentState,
      Function makeChange}) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(
        description,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      value: currentState,
      onChanged: makeChange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
            onPressed: () {
              widget.saveFilter(widget.currentFilter);
            },
            icon: Icon(
              Icons.save,
              color: Colors.amber,
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(children: [
        _buildSwitchTiles(
          title: 'Gluten Free',
          description: 'Only include Gluten Free Meal',
          currentState: widget.currentFilter.glutenFree,
          makeChange: (newValue) {
            setState(() {
              widget.currentFilter.glutenFree = newValue;
              widget.saveFilter(widget.currentFilter);
            });
          },
        ),
        _buildSwitchTiles(
          title: 'Vegan',
          description: 'Only include Vegan meals',
          currentState: widget.currentFilter.vegan,
          makeChange: (newValue) {
            setState(() {
              widget.currentFilter.vegan = newValue;
              widget.saveFilter(widget.currentFilter);
            });
          },
        ),
        _buildSwitchTiles(
          title: 'Lactose Free',
          description: 'Only include Lactose Free Meal',
          currentState: widget.currentFilter.lactoseFree,
          makeChange: (newValue) {
            setState(() {
              widget.currentFilter.lactoseFree = newValue;
              widget.saveFilter(widget.currentFilter);
            });
          },
        ),
        _buildSwitchTiles(
          title: 'Vegitarian',
          description: 'Only include Vegitarian Meal',
          currentState: widget.currentFilter.vegetarian,
          makeChange: (newValue) {
            setState(() {
              widget.currentFilter.vegetarian = newValue;
              widget.saveFilter(widget.currentFilter);
            });
          },
        ),
      ]),
    );
  }
}
