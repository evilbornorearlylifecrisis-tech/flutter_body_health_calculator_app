import 'package:flutter/material.dart';

class BmrUi extends StatefulWidget {
  const BmrUi({super.key});

  @override
  State<BmrUi> createState() => _BmrUiState();
}

class _BmrUiState extends State<BmrUi> {
  final TextEditingController weightCtrl = TextEditingController();
  final TextEditingController heightCtrl = TextEditingController();
  final TextEditingController ageCtrl = TextEditingController();
  bool isMale = true;
  double bmrResult = 0.00;

  double? _parseInput(String value) {
    return double.tryParse(value.trim().replaceAll(',', '.'));
  }

  void _showInvalidMessage() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('กรุณากรอกข้อมูลให้ถูกต้อง'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _calculateBmr() {
    final double? weight = _parseInput(weightCtrl.text);
    final double? height = _parseInput(heightCtrl.text);
    final double? age = _parseInput(ageCtrl.text);

    if (weight == null || height == null || age == null || weight <= 0 || height <= 0 || age <= 0) {
      _showInvalidMessage();
      return;
    }

    final double bmr = isMale
        ? 66 + (13.7 * weight) + (5 * height) - (6.8 * age)
        : 655 + (9.6 * weight) + (1.8 * height) - (4.7 * age);

    setState(() {
      bmrResult = bmr;
    });
  }

  void _clearBmrData() {
    weightCtrl.clear();
    heightCtrl.clear();
    ageCtrl.clear();
    setState(() {
      isMale = true;
      bmrResult = 0.00;
    });
  }

  @override
  void dispose() {
    weightCtrl.dispose();
    heightCtrl.dispose();
    ageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 40,
            left: 30,
            right: 30,
            bottom: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'คำนวณหาอัตราการเผาผลาญที่\nร่างกายต้องการ (BMR)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'assets/images/bmr.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20),
              Text('เพศ'),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isMale = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isMale ? Colors.blue : Colors.grey[400],
                        foregroundColor: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width,
                          45,
                        ),
                      ),
                      child: Text(
                        'ชาย',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isMale = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isMale ? Colors.grey[400] : Colors.pink,
                        foregroundColor: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width,
                          45,
                        ),
                      ),
                      child: Text(
                        'หญิง',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('น้ำหนัก (kg.)'),
              SizedBox(height: 8),
              TextField(
                controller: weightCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'กรอกน้ำหนักของคุณ',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              Text('ส่วนสูง (cm.)'),
              SizedBox(height: 8),
              TextField(
                controller: heightCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'กรอกส่วนสูงของคุณ',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              Text('อายุ (ปี)'),
              SizedBox(height: 8),
              TextField(
                controller: ageCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'กรอกอายุของคุณ',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateBmr,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    50,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'คำนวณ BMR',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _clearBmrData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    50,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'ล้างข้อมูล',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      'BMR',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      bmrResult.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'kcal/day',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
