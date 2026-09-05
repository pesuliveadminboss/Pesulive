import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const PesuLiveApp());
}

class PesuLiveApp extends StatelessWidget {
  const PesuLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PesuLive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int coins = 1500; // ஆரம்ப இருப்பு காயின்ஸ்
  bool inCall = false;
  int callDuration = 0;
  Timer? callTimer;

  void startRandomCall() {
    if (coins < 500) {
      showRechargeDialog();
      return;
    }

    setState(() {
      inCall = true;
      callDuration = 0;
    });

    // ஒவ்வொரு 60 வினாடிக்கும் 500 காயின்ஸ் கழியும் டைமர்
    callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        callDuration++;
        if (callDuration % 60 == 0) {
          if (coins >= 500) {
            coins -= 500;
          } else {
            endCall();
            showRechargeDialog();
          }
        }
      });
    });
  }

  void endCall() {
    callTimer?.cancel();
    setState(() {
      inCall = false;
    });
  }

  void showRechargeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("ரீசார்ஜ் தேவை!"),
        content: const Text("1 நிமிடம் பேச 500 காயின்கள் தேவை.\n\nசிறப்பு சலுகை: ₹70 = 1500 காயின்கள்."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("ரத்து"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              setState(() {
                coins += 1500;
              });
              Navigator.pop(context);
            },
            child: const Text("₹70 செலுத்து (Add 1500)"),
          ),
        ],
      ),
    );
  }

  // அட்மின்கான சீக்ரெட் பேனல்
  void openAdminPanel() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Super Admin Access"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Add 5000 Coins (Free)"),
              trailing: ElevatedButton(
                onPressed: () {
                  setState(() => coins += 5000);
                  Navigator.pop(context);
                },
                child: const Text("+5000"),
              ),
            ),
            ListTile(
              title: const Text("Reset to 0 Coins"),
              trailing: ElevatedButton(
                onPressed: () {
                  setState(() => coins = 0);
                  Navigator.pop(context);
                },
                child: const Text("Reset"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    callTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PesuLive", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black45,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.amber.shade800,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.yellow, size: 20),
                const SizedBox(width: 5),
                Text("$coins Coins", style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.admin_panel_settings, color: Colors.redAccent),
            tooltip: 'Admin Access',
            onPressed: openAdminPanel,
          ),
        ],
      ),
      body: Center(
        child: inCall
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.deepPurple,
                    child: Icon(Icons.person, size: 80, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Text("கால் இயங்குகிறது...", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text("நேரம்: $callDuration விநாடிகள்", style: const TextStyle(fontSize: 18, color: Colors.grey)),
                  const SizedBox(height: 8),
                  const Text("கட்டணம்: 1 நிமிடம் = 500 Coins", style: TextStyle(color: Colors.orangeAccent)),
                  const SizedBox(height: 40),
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: endCall,
                    child: const Icon(Icons.call_end, size: 30),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.video_chat_rounded, size: 100, color: Colors.deepPurpleAccent),
                  const SizedBox(height: 20),
                  const Text("புதிய நபருடன் பேச தயாரா?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: startRandomCall,
                    icon: const Icon(Icons.video_call, size: 28),
                    label: const Text("Start Random Match", style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
      ),
    );
  }
}
