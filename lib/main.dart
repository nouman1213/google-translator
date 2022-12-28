import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Translator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController myController = TextEditingController();
  GoogleTranslator translator = GoogleTranslator();
  String? dropdownValue = 'ur';
  String output = '';

  static const Map<String, String> lang = {
    "Afrikaans": "af",
    "Albanian": "sq",
    "Arabic": "ar",
    "Armenian": "hy",
    "Bengali": "bn",
    "Belarusian": "be",
    "Bulgarian": "bg",
    "Catalan": "ca",
    "Chinese": "zh-CN",
    "Croatian": "hr",
    "Czech": "cs",
    "Danish": "da",
    "Dutch": "nl",
    "English": "en",
    "Estonian": "et",
    "Finnish": "fi",
    "French": "fr",
    "Georgian": "ka",
    "German": "de",
    "Greek": "el",
    "Hebrew": "he",
    "Hindi": "hi",
    "Hungarian": "hu",
    "Icelandic": "is",
    "Indonesian": "id",
    "Irish ": "ga",
    "Italian": "it",
    "Japanese": "ja",
    "Kazakh": "kk",
    "Korean": "ko",
    "Kyrgyz": "ky",
    "Lao": "lo",
    "Latvian": "lv",
    "Lithuanian": "lt",
    "Macedonian": "mk",
    "Malay": "ms",
    "Maltese": "mt",
    "Mongolian": "mn",
    "Norwegian": "no",
    "Persian": "fa",
    "Pashto": "ps",
    "Polish": "pl",
    "Portuguese": "pt-PT",
    "Romanian": "ro",
    "Russian": "ru",
    "Serbian": "sr",
    "Slovak": "sk",
    "Slovenian": "sl",
    "Spanish": "es",
    "Swahili": "sw",
    "Swedish": "sv",
    "Tajik": "tg",
    "Tamil": "ta",
    "Thai": "th",
    "Turkish": "tr",
    "Ukrainian": "uk",
    "Urdu": "ur",
    "Uzbek": "uz",
    "Vietnamese": "vi",
  };

  void trans() {
    translator.translate(myController.text, to: "$dropdownValue").then((value) {
      setState(() {
        output = value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Translator"),
      ),
      body: Padding(
        padding: EdgeInsets.all(height * 0.012),
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: TextFormField(
                        //focusNode: FocusNode(canRequestFocus: false),
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          if (value.isEmpty || value == '') {
                            setState(() {
                              myController.clear();
                            });
                          } else {
                            trans();
                          }
                        },
                        style: TextStyle(fontSize: height * 0.03),
                        controller: myController,
                        onTap: () {
                          trans();
                        },
                        decoration: InputDecoration(
                            labelText: 'Type Here',
                            labelStyle: TextStyle(fontSize: height * 0.035)),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.shade200),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            myController.clear();
                          });
                        },
                        icon: const Icon(Icons.clear)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Select Language",
                  style: TextStyle(fontSize: height * 0.025),
                ),
                DropdownButton<String>(
                  isDense: true,
                  value: dropdownValue,
                  elevation: 10,
                  style: const TextStyle(color: Colors.blue),
                  underline: Container(
                    height: 2,
                    color: Colors.blue,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      trans();
                    });
                  },
                  items: lang
                      .map((string, value) {
                        return MapEntry(
                          string,
                          DropdownMenuItem<String>(
                            value: value,
                            child: Text(string),
                          ),
                        );
                      })
                      .values
                      .toList(),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.019,
            ),
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    myController.text.isEmpty
                        ? const Text('')
                        : Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Translated Text",
                                  style: TextStyle(
                                      fontSize: height * 0.025,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: output));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Text Copied')));
                                  },
                                  icon: const Icon(Icons.copy))
                            ],
                          ),
                    SizedBox(
                      height: height * 0.019,
                    ),
                    Text(
                      myController.text.isEmpty ? "" : output.toString(),
                      style: TextStyle(
                          fontSize: height * 0.03,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Developed by Nouman Ashraf',
                style: TextStyle(color: Colors.black87),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
