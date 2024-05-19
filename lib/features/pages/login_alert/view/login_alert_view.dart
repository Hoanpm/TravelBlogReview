import 'package:flutter/material.dart';
import 'package:travelblog/features/auth/view/getting_start_view.dart';

class LoginAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Container(
            width: 250,
            height: 200,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.25,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  )
                ],
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 15,),
                    Text(
                      "Bạn cần đăng nhập để sử dụng chức năng này !",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(120, 40),
                        backgroundColor: Color.fromRGBO(115, 115, 115, 1),
                        foregroundColor: Colors.white
                      ),
                      onPressed: () {
                        Navigator.push(context, StartView.route());
                      }, 
                      child: Center(child: Text("Đăng nhập"),)
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.orange),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 3),
                      child: Icon(
                          Icons.warning_rounded,
                          size: 16,
                          color: Colors.orange,
                        ),
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
