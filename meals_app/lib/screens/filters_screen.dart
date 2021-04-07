import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filter-scren';

  final Map<String, bool> currentFilters;
  final Function saveFilters;
  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegetarian = false;
  var _vegan = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    super.initState();
  }

  Widget buildSwitchListTile(title, subtitle, value, onChangeValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChangeValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters!'),
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  final selectedFilters = {
                    'gluten': _glutenFree,
                    'lactose': _lactoseFree,
                    'vegan': _vegan,
                    'vegetarian': _vegetarian,
                  };
                  widget.saveFilters(selectedFilters);
                })
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  buildSwitchListTile(
                    'Gluten-Free',
                    'Only include free meals',
                    _glutenFree,
                    (change) {
                      setState(() {
                        _glutenFree = change;
                      });
                    },
                  ),
                  buildSwitchListTile(
                    'Lactose-Free',
                    'Only include Lactose free meals',
                    _lactoseFree,
                    (change) {
                      setState(() {
                        _lactoseFree = change;
                      });
                    },
                  ),
                  buildSwitchListTile(
                    'Vegan',
                    'Only include vegan free meals',
                    _vegan,
                    (change) {
                      setState(() {
                        _vegan = change;
                      });
                    },
                  ),
                  buildSwitchListTile(
                    'Vegetarian',
                    'Only include vegeterian free meals',
                    _vegetarian,
                    (change) {
                      setState(() {
                        _vegetarian = change;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
