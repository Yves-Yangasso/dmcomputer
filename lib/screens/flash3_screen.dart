import 'package:flutter/material.dart';

import 'flash_screen.dart';
import 'menu_screen.dart';

class Flash3Screen extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Fond vert
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ Colors.black, Colors.green.shade700, Colors.black],
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Profitez des Promos.",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            // Texte secondaire
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Acheté des matériels infomartique de qualité"
                    "\nau meilleur prix du marché...N'oubliez pas de"
                    "\nProfitez de nos réductions jusqu'à -50",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            // Image (remplacez par une vraie image si disponible)
            SizedBox(
              height: 300,
              child: Image(
                image: AssetImage('images/img2.png'),
                fit: BoxFit.cover,
              ),

            ),
            const SizedBox(height: 40),
            // Bouton avec pagination
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, size: 10, color: Colors.grey),
                const SizedBox(width: 10),
                Icon(Icons.circle, size: 10, color: Colors.grey),
                const SizedBox(width: 10),
                Icon(Icons.circle, size: 10, color: Colors.white),
              ],
            ),
            const SizedBox(height: 20),
            // Boutons Passer et Terminer
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context)=>MenuScreen()));
                    },
                    child: Text(
                      "Passer",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context)=>FlashScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(15),
                      //  primary: Colors.white,
                    ),
                    child: Icon(Icons.arrow_forward, color: Colors.green),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context)=>MenuScreen()));
                    },
                    child: Text(
                      "Terminer",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
