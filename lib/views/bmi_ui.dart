import 'package:flutter/material.dart';

class BmiUi extends StatefulWidget {
  const BmiUi({super.key});

  @override
  State<BmiUi> createState() => _BmiUiState();
}

class _BmiUiState extends State<BmiUi> {
  final TextEditingController wCtrl = TextEditingController();
  final TextEditingController hCtrl = TextEditingController();
  double bmiResult = 0.00;
  String bmiResultText = 'การแปลผล';

  void _clearBmiData() {
    wCtrl.clear();
    hCtrl.clear();
    setState(() {
      bmiResult = 0.00;
      bmiResultText = 'การแปลผล';
    });
  }

  @override
  void dispose() {
    wCtrl.dispose();
    hCtrl.dispose();
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
                  controller: wCtrl,
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
                  controller: hCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'กรุณากรอกส่วนสูง',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                // ส่วนปุ่ม
                ElevatedButton(
                  onPressed: () {
                    if (wCtrl.text.isEmpty || hCtrl.text.isEmpty) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('กรุณากรอกข้อมูลให้ครบ'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    final double? weight = double.tryParse(
                      wCtrl.text.trim().replaceAll(',', '.'),
                    );
                    final double? heightCm = double.tryParse(
                      hCtrl.text.trim().replaceAll(',', '.'),
                    );

                    if (weight == null ||
                        heightCm == null ||
                        weight <= 0 ||
                        heightCm <= 0) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('กรุณากรอกข้อมูลให้ถูกต้อง'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    final double bmi =
                        weight / ((heightCm / 100) * (heightCm / 100));
                    String bmiText = '';

                    if (bmi < 18.5) {
                      bmiText = 'ผอมเกินไป';
                    } else if (bmi <= 22.9) {
                      bmiText = 'สมส่วน';
                    } else if (bmi <= 24.9) {
                      bmiText = 'ท้วม';
                    } else if (bmi <= 29.9) {
                      bmiText = 'โรคอ้วนระดับ 1';
                    } else {
                      bmiText = 'โรคอ้วนระดับ 2';
                    }

                    setState(() {
                      bmiResult = bmi;
                      bmiResultText = bmiText;
                    });
                  },
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
