import "package:flutter/material.dart";
import "package:tamil_padi/screens/word.dart";

const words = ["அம்மா", "ஆந்தை", "இலை", "ஈ", "உண்மை", "ஊசி", "எழுத்து", "ஏணி", "ஐந்து", "ஒன்று", "ஒளவை"];

class Words extends StatelessWidget {
  const Words({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Learn Words"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: words.map((word) {
                return Container(
                  width: MediaQuery.of(context).size.width*0.5 - 13,
                  height: MediaQuery.of(context).size.width*0.5 - 13,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Word(word: word)));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            word,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      )
    );
  }
}
