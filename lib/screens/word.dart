import "package:flutter/material.dart";
import "package:speech_to_text/speech_to_text.dart" as stt;

class Word extends StatefulWidget {
  final String word;
  const Word({super.key, required this.word});

  @override
  State<Word> createState() => _WordState();
}

class _WordState extends State<Word> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  String _recognisedText = "Press the Button below to Start";
  bool _isListening = false;
  String? result = null;

  void dispose() {
    super.dispose();
    _speech.stop();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.word),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ),
                child: const Center(
                  child: Text("Image"),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      widget.word,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                  Flexible(
                    flex:1,
                    child: Text(
                      _recognisedText,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                  if(result != null) Flexible(
                    flex: 1,
                    child: Text(
                      result!,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () async {
                        if(!_isListening){
                          bool available = await _speech.initialize(
                            onStatus: (v) {
                              print("status: $v");
                              if(v == "listening") {
                                setState(() {
                                  _recognisedText = "Listening...";
                                });
                              }else if (v == "done"){
                                setState(() {
                                  _isListening = false;
                                  _speech.stop();
                                  if(_recognisedText == widget.word){
                                    result = "Your pronunciation is correct";
                                  }else{
                                    result = "Your pronunciation is wrong, give it another try";
                                  }
                                });
                              }
                            },
                            onError: (e) => print("onerror: $e"),
                          );

                          if(available) {
                            setState(() {
                              _isListening = true;
                            });

                            _speech.listen(
                                localeId: "ta_In",
                                onResult: (val) => setState(() {
                                  _recognisedText = val.recognizedWords;
                                })
                            );
                          }else{
                            setState(() {
                              _isListening = false;
                              _speech.stop();
                            });
                          }
                        }
                      },
                      child: Icon(_isListening ? Icons.mic: Icons.mic_none),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

