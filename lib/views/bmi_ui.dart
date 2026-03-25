import 'package:flutter/material.dart';

class BmiUi extends StatefulWidget {
  const BmiUi({super.key});

  @override
  State<BmiUi> createState() => _BmiUiState();
}

class _BmiUiState extends State<BmiUi> {
  final TextEditingController weightCtrl = TextEditingController();
  final TextEditingController heightCtrl = TextEditingController();
  double bmiResult = 0.00;
  String bmiResultText = 'การแปลผล';

  double? _parseInput(String value) {
    return double.tryParse(value.trim().replaceAll(',', '.'));
  }

  String _getBmiResultText(double bmi) {
    if (bmi < 18.5) {
      return 'น้ำหนักน้อย';
    }
    if (bmi < 23) {
      return 'ปกติ';
    }
    if (bmi < 25) {
      return 'น้ำหนักเกิน';
    }
    if (bmi < 30) {
      return 'อ้วน';
    }
    return 'อ้วนมาก';
  }

  void _showInvalidMessage() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('กรุณากรอกข้อมูลให้ถูกต้อง'),
      ),
    );
  }

  void _calculateBmi() {
    final double? weight = _parseInput(weightCtrl.text);
    final double? heightCm = _parseInput(heightCtrl.text);

    if (weight == null || heightCm == null || weight <= 0 || heightCm <= 0) {
      _showInvalidMessage();
      return;
    }

    final double heightM = heightCm / 100;
    final double bmi = weight / (heightM * heightM);

    setState(() {
      bmiResult = bmi;
      bmiResultText = _getBmiResultText(bmi);
    });
  }

  void _clearBmiData() {
    weightCtrl.clear();
    heightCtrl.clear();
    setState(() {
      bmiResult = 0.00;
      bmiResultText = 'การแปลผล';
    });
  }

  @override
  void dispose() {
    weightCtrl.dispose();
    heightCtrl.dispose();
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
          child: Center(
            child: Column(
              children: [
                // ส่วนชื่อหน้าจอ และ รูป
                Text(
                  'คำนวณหาค่าดัชนีมวลกาย (BMI)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Image.asset(
                  'assets/images/bmi.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                // ส่วนรับป้อนข้อมูล
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'น้ำหนัก (kg.)',
                  ),
                ),
                TextField(
                  controller: weightCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'กรุณากรอกน้ำหนัก',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ส่วนสูง (cm.)',
                  ),
                ),
                TextField(
                  controller: heightCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'กรุณากรอกส่วนสูง',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                // ส่วนปุ่ม
                ElevatedButton(
                  onPressed: _calculateBmi,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      50,
                    ),
                  ),
                  child: Text(
                    'คำนวณ BMI',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _clearBmiData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      50,
                    ),
                  ),
                  child: Text(
                    'ล้างข้อมูล',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                //ส่วนแสดงผลข้อมูลที่ได้จากการคำนวณ
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'BMI',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        bmiResult.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        bmiResultText,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
