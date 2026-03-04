// widgets/prevision_5jours.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Prevision5JoursWidget extends StatelessWidget {
  final List<dynamic> previsions;

  const Prevision5JoursWidget({super.key, required this.previsions});

  IconData _getWeatherIcon(String condition) {
    condition = condition.toLowerCase();
    if (condition.contains("rain")) return Icons.grain;
    if (condition.contains("cloud")) return Icons.cloud;
    if (condition.contains("storm")) return Icons.flash_on;
    if (condition.contains("clear")) return Icons.wb_sunny;
    return Icons.wb_cloudy;
  }

  @override
  Widget build(BuildContext context) {
    final jours = previsions.where(
      (e) => e['dt_txt'].contains("12:00:00"),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),

        // TITRE
        Row(
          children: const [
            Icon(Icons.calendar_month, color: Colors.blue),
            SizedBox(width: 8),
            Text(
              "Prévisions sur 5 jours",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        // CARTES HORIZONTALES
        SizedBox(
          height: 185,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: jours.map((jour) {
              final date = DateTime.parse(jour['dt_txt']);
              final jourNom = DateFormat.EEEE('fr').format(date);
              final tempMin = jour['main']['temp_min'].round();
              final tempMax = jour['main']['temp_max'].round();
              final pluie = ((jour['pop'] ?? 0) * 100).round();
              final vent = jour['wind']['speed'];
              final condition = jour['weather'][0]['main'];

              return Container(
                width: 150,
                margin: const EdgeInsets.only(right: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade500,
                      Colors.blue.shade900,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // JOUR
                      Text(
                        jourNom.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // ICÔNE MÉTÉO
                      Icon(
                        _getWeatherIcon(condition),
                        color: Colors.white,
                        size: 42,
                      ),

                      // TEMPÉRATURE
                      Text(
                        "$tempMin° / $tempMax°",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // PLUIE & VENT
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.water_drop,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "$pluie%",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.air,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "$vent m/s",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
