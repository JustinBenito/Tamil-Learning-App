import "package:flutter/material.dart";
import "package:tamil_padi/screens/words.dart";

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Tamil Padi"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Learn Words"),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Words()));
          },
        ),
      ),
    );
  }
}
