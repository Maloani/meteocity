// widgets/meteo_actuelle.dart
import 'package:flutter/material.dart';

class MeteoActuelleWidget extends StatelessWidget {
  final Map<String, dynamic> meteo;

  const MeteoActuelleWidget({super.key, required this.meteo});

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
    final temp = meteo['main']['temp'].round();
    final tempMin = meteo['main']['temp_min'].round();
    final tempMax = meteo['main']['temp_max'].round();
    final description = meteo['weather'][0]['description'];
    final condition = meteo['weather'][0]['main'];
    final humidity = meteo['main']['humidity'];
    final wind = meteo['wind']['speed'];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
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
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ICÔNE MÉTÉO
            Icon(
              _getWeatherIcon(condition),
              size: 70,
              color: Colors.white,
            ),

            const SizedBox(height: 12),

            // TEMPÉRATURE PRINCIPALE
            Text(
              "$temp°C",
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            // DESCRIPTION
            Text(
              description.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                letterSpacing: 1.1,
              ),
            ),

            const SizedBox(height: 12),

            // MIN / MAX
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_downward,
                    color: Colors.white70, size: 16),
                Text(
                  " $tempMin°  ",
                  style: const TextStyle(color: Colors.white70),
                ),
                const Icon(Icons.arrow_upward, color: Colors.white70, size: 16),
                Text(
                  " $tempMax°",
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // HUMIDITÉ & VENT
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _infoItem(
                  icon: Icons.water_drop,
                  label: "Humidité",
                  value: "$humidity%",
                ),
                _infoItem(
                  icon: Icons.air,
                  label: "Vent",
                  value: "$wind m/s",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
