import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen(
      {Key? key, required this.onSettingChanged, required this.settings})
      : super(key: key);

  final Function(Settings) onSettingChanged;
  final Settings settings;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Widget _createWidget(
    String title,
    String subtitle,
    bool value,
    Function(bool value) function,
  ) {
    return SwitchListTile.adaptive(
      value: value,
      onChanged: (value) {
        function(value);
        // passando as configurações para quem criou o componente
        widget.onSettingChanged(widget.settings);
      },
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          _createWidget(
            'Sem lactose',
            'Só aparecerão alimentos sem lactose nas refeições',
            widget.settings.isLactoseFree,
            (value) => setState(() {
              widget.settings.isLactoseFree = value;
            }),
          ),
          _createWidget(
            'Sem glutem',
            'Só aparecerão alimentos sem glutem nas refeições',
            widget.settings.isGlutenFree,
            (value) => setState(() {
              widget.settings.isGlutenFree = value;
            }),
          ),
          _createWidget(
            'Vegano',
            'Só aparecerão alimentos veganos nas refeições',
            widget.settings.isVegan,
            (value) => setState(() {
              widget.settings.isVegan = value;
            }),
          ),
          _createWidget(
            'Vegetariano',
            'Só aparecerão alimentos vegetarianos nas refeições',
            widget.settings.isVegetarian,
            (value) => setState(() {
              widget.settings.isVegetarian = value;
            }),
          )
        ],
      ),
    );
  }
}
