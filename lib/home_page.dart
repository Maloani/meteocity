// home_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'widgets/meteo_actuelle.dart';
import 'widgets/prevision_5jours.dart';

class MeteoHomePage extends StatefulWidget {
  const MeteoHomePage({super.key});

  @override
  State<MeteoHomePage> createState() => _MeteoHomePageState();
}

class _MeteoHomePageState extends State<MeteoHomePage> {
  final TextEditingController _villeController = TextEditingController();
  Map<String, dynamic>? meteo;
  List<dynamic>? previsions;
  bool loading = false;

  static const apiKey = "5732637e8bfc76054731c91c50134ada";

  Future<void> chargerMeteo() async {
    setState(() => loading = true);

    final currentUrl = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=${_villeController.text}&appid=$apiKey&units=metric&lang=fr",
    );

    final forecastUrl = Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast?q=${_villeController.text}&appid=$apiKey&units=metric&lang=fr",
    );

    final current = await http.get(currentUrl);
    final forecast = await http.get(forecastUrl);

    if (current.statusCode == 200 && forecast.statusCode == 200) {
      setState(() {
        meteo = json.decode(current.body);
        previsions = json.decode(forecast.body)['list'];
        loading = false;
      });
    } else {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meteo Georges City")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _villeController,
              decoration: const InputDecoration(
                labelText: "Ville",
                prefixIcon: Icon(Icons.location_city),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: chargerMeteo,
              child: const Text("Obtenir la météo"),
            ),
            const SizedBox(height: 20),
            if (loading) const Center(child: CircularProgressIndicator()),
            if (meteo != null) MeteoActuelleWidget(meteo: meteo!),
            if (previsions != null)
              Prevision5JoursWidget(previsions: previsions!),
          ],
        ),
      ),
    );
  }
}
