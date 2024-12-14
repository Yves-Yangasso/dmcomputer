import 'package:flutter/material.dart';

import 'flash3_screen.dart';
import 'menu_screen.dart';

class Flash2Screen extends StatelessWidget {
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
                "L'App Tout en Un",
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "La solution unique pour vos achats informatique\nSimple, Sans Tracas",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            // Image (remplacez par une vraie image si disponible)
            SizedBox(
              height: 300,
              child: Image(
                image: AssetImage('images/img3.png'),
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
                          context, MaterialPageRoute(builder: (context)=>Flash3Screen()));
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
