import 'package:dmcomputer/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'flash2_screen.dart';

class FlashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: OnboardingScreen(),
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  // Styles de texte constants
  final TextStyle titleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.yellow,
  );

  final TextStyle subtitleStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // Utilisation de MediaQuery pour définir la hauteur
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Fond vert
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.green.shade700, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // Contenu
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Texte principal
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "C’est le Moment.",
                    style: titleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                // Texte secondaire
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Démarrons une expérience d’achat révolutionnaire\npour les passionnés de Technologie.",
                    style: subtitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                // Image
                SizedBox(
                  height: 300,
                  child: Image.asset(
                    'images/img1.png', // Assurez-vous que l'image est présente
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                // Indicateurs de pagination
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIndicator(isActive: false),
                    const SizedBox(width: 10),
                    _buildIndicator(isActive: false),
                    const SizedBox(width: 10),
                    _buildIndicator(isActive: true),
                  ],
                ),
                const SizedBox(height: 20),
                // Boutons Passer et Terminer
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTextButton(context, "Passer", MenuScreen()),
                      _buildElevatedButton(context, Flash2Screen()),
                      _buildTextButton(context, "Terminer", MenuScreen()),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator({required bool isActive}) {
    return Icon(
      Icons.circle,
      size: 10,
      color: isActive ? Colors.white : Colors.grey,
    );
  }

  Widget _buildTextButton(BuildContext context, String label, Widget screen) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildElevatedButton(BuildContext context, Widget screen) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen));
      },
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(15),
      ),
      child: Icon(Icons.arrow_forward, color: Colors.green),
    );
  }
}