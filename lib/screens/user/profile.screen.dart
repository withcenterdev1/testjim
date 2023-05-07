import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;
  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        log('User is currently signed out!');
      } else {
        log('User is signed in!');
      }
      setState(() {
        this.user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Account',
          style: TextStyle(
              color: Colors.black, textBaseline: TextBaseline.ideographic),
        ),
        backgroundColor: Colors.white,
      ),
      body: (Column(
        children: [
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CircleAvatar(
                radius: 56,
                backgroundColor: Colors.blue.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(8), // Border radius
                  child: ClipOval(
                      child: Image.network(
                          'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAq1BMVEX///9fyvhdx/cxufUFWp0HWpwwuPb///3///v+/v9gyfn//v2HpcUAUJj8//7k9f1Ow/ZRxvZfx/uF1Phey/VXyPra8f34/P9Tx/MJVppSxPkyu/H3+/9jxvxoyexlyvWf2vgstfsARZAssesOTZbX8/uC0fm4z+Mvse4JV58ARJUAQY3t+vvo9P5MwflczPMYqfKE1PMIW5cKT5EMSZBxmcC5zOMAN4yZtNDzrsdYAAAKF0lEQVR4nO2d63LbOBKFCeoCkBgjJCRaFB2tfI/lzDiTxM7u+z/ZdoOkRPEKTaokdg1OpSqJ4x/40n3Q3SAoe56Tk5OTk5OTk5OTk5OTk5OTk5OTk5OTk5OTk5OTk5PTv1dcyqBDje+VQlxghb8r5QWyQ41vlU3o8UsEHu/6N16oJObSa1CPX/zPT399stafxAiVCMR1/BZHHcoKmb+8ZdHbojPcIxX3AJAx7VtI+0m88AJ16TWfJoygZhsbQF/rbCEUsSTFCPrLkC2tEOOFgH2XEGIgJH9Kwy1jw3CQxwl4kBAdKuDoQYigBaH2dbyQnNo2I66zcKmZDaGvo2fBqbUz/DqFCC7tCMGDklS1VzyQT7FGvEFC3IZgFyVEh5JSPOUeHCb0GdRB7hGrg7DJZHppF0M/iRaC2jYKHsQ6uGVWhBBBKRWhoSLgppMp4tdPyLTGCBILIOz611FSAeyLIXqQYh2ETUaHVoQJ1EFFENDfhku7LDUe9Ah50MyDWVhN0W5C7TN6ddDMg8kytCHULEkXpPoYFO6im61mVjFMcFyi1osaDzJtlaUsNilKyIN4ZIi9aFjL0bCNjrQHbQjNmQxJD2qmtzaEND0IKYq9qFUM6XkQxiXvKQKaBl9zn8GzRXoelMp4UNsQQiajB4m1ahI6mc1SW8UQD53oedCDgZctDeAwIQByRWoe9ARsMpscr8F3DEjTg4LDRJ+E2oYw9yDBZxPRJuyKYa1WoAcDah7k15kPm8w2bEWsEWIdVJTqIM6DT1GRoAP7TOHBSy/5RMGufx3prRVh4UFiddD0otuNFSF6kJPzIAIC1tKKkFwdBA9yjGA3XYVPM4J1EFu1OGHahlD7OqVXB6HQv2nWt49WYxhhHSSUoSgOu+iyCtjX0KRYB0kBwjwIncyyF49RroM4D0Kh1zaEpg5ych7EeTDc9KdomaMke1EzDx57sJuQXC8acGk2mX66MCw8yOh5UAhu4cF8qDDnouSe0Xv5PDiQoUWKJhQ9KAFw2IM5IaPnQeHxw5lMvwtpPpsQ5hpJDbCN8OBBYvMgetBnG7s6gbcsFCe2y+QPX9jShhA9CM3PpZd8gpTx4HGKtuwweY6S9CDMg09Zwgail0cwwXGJXB2EQv8GdXCgl8kJQ/SgJ4gRYifzbXAXLQjNnW1KgIHI76rZeJBmL2qe0YfboV7UENLsRc09GbbZ9tPlGeqT9KC4Tn28s21DyPJz0Usv+QShB58qHuxiWwIezV40f0bPBvxX8aAk50EsE+BBROimyy1I2YPbXrgCMMw9SGgcNHe2n+L6TbyW/Ay76yAPuOAD2r8XfPYnN5ybOtifnSyfeDvvqinZ+R5w/X1ggDzzPFncVRuMod/tQYig6n53uyb41jM3Q3mrZuXB4q5aM8tW2ziJLZUtP59xl8qf0dfvbLdkqDkXDVufTXAlVv/J/F4lpXSaLVfnTNL8vui3Xg+GRfxyDzafTahgtc1YmloRxmm4kvyMOw16kH3b9BPulxm1PqMXAOin/e8Bl4BpulH8rA/68c42MPRmaUnIIvMOb/3/XyIgS/3eN59KwixUAaTBGTu+Tynrp8sfTXTWQcWNBwfe68rp/IRl31bnPpeTt/Gg/3IP6qitDsKICB5c9nqwkqNs5Z3TgyglbrPu+B3WGCZ+ay8q1LAHS8I41Uqd/7KN5J1RrK4x7KyDGfMHPFgSZgy6gUs8Jm4ghmF4dBWvax7kst2DSQsf08mZ6+CRbqPO7ER19aLSeLC/Du4jmEIdPLsH9yvdbzd1tnKJ7fOgnQdzwjg2dfBSMyXPE7VziT0eHKqDJSHUQe/sDXdVgJi0xg89GLXUQYipRR3M6cCYWAcvgHWk26j182XyezLNMxkYY0NIUTsPnr0XbRP3buP2GMatd9WgF01sPYi9qLj4jT7F5W3UtkTzbKI51a6WyWAvWhLmdXAEp4/gxeNE7XpvAmK6unnz8eR0kC/vRcdybCVriMW7Sw3CQKibu5sMCvvQJyngJgO9qBzLB7Q1vIgeVG3z4GQ+mUwiiNBgt8bSJLhgHawLvHh0GNH+/qD8fDMHxPkcfDtImDEVqNEAehUvdt0XhZiuIEUnqDmUi748jRM8kxnbhynwoi52vbukOHjQJCmqtcDsA6jjeAR1sC5ZerHj/UGhJvObeUk4yRLdlanowYv2oh1SgBgVHmyeyQTeynjQ5ChacR7DZtkB6KMHAXBkhF7eo/Z5cB9Awxn5WBabHV8SYy86Mg/udZtlC9n8v1ei6sGCELzY0tBirxaOpw7WJcXtdz7swYJw8qYbXsReVJ/5XPQUCe4FrfPgcYIa3WBd1LoOaDx43nPR3xV48HPdg/s4ZnjQUTmeGbcHO9Tmwcp2cxRFcy46ujo4pNyDdQseopjo/RaD56KBGl0dHFLTg4ct5wajWNTFYh70aAHCPPi57EW7ZLxo7kql2TdF7f21QDY82GLIyNTFyzyb+E3hwFv3YJtgu0mYD3VQ0EpRUDEP9sQv/3qEp/+XPhc9WTCgd9bBIzzQJGZQ6Kl9apLyTLNtRQjdDQtI3dtHBeI77KKWgJO/v3h8BKeGJ0kJbwH7aG+pmJd6mN1/ofT6Uyn5/c7Cg/DrZfpjCohS8bGdzQzqudeHefzuJg/T2WyKUeRihHN9r4T3/WUwQyGCMyCc7t6/mPmLlLjHnzuLYAn4ACk63UeRWAxBfNHixT0dRnCHeLkAUdDzolj0ZOgdpOh6tiek6UXPq0VxXtXLblbRdHdP04uLeQcgpOhsvatAkvXi810LHQKu17v1+uBD1CsikvOiXLQkKHQyV1dIWEMk6UUOXpw39PD4MydcT6uMU4p1UXjiuY44edkDAuIB8Md6+krTi8dRnMxfrn5eoQrG9T6EoKJHpTQOe+jFWoo+PhrCqwrftNDu9RceQxKLI5eHKE7mD/cA+FgAzqrxM4Qke1TJD1GcPNy/A6BJ0+o+WhLCH2h6MY8iFI2Xx/dHVCV8e7pSWDTwZyNeetGnST6/zCd3kKLvQHhVwWshnN7/grpI7XSRezD1zx9e7++vdqZH6yHcYaKO4cbXSQIvPt89vL6X5mvz4EFrSFRq+6mHifq6+zGrqUl38KKSlJ6WGn38tKIze+rXL+YTJi+95FP18WhLuN59xbpILIaBOEbsJzSTxqWX/A/08TgdpDvyIrl50ft4n9oSohfpzYuYqDZ0RrkXicVQnYAInflXkj2q8aIt5NdfnggkPS9aRHFd/PaKdfHSCz5V8gQvznbQhgfkvMgHEdflH35MzSHjpZf8D3SCF3HSENCjUstVqIvWmWqKBrXPtjnFizuSPWqnF9fNL83WJorEYoj6eL2y1eN/f9H7IUKg//1hr4+/CG6oJy6ZYJaaGtD+L+WFcTxwU/hZQ5zcgYaTk5OTk5OTk5OTk5OTk5OTk5OTk5OTk5OTk5OTk5PTv1z/B9HF/yI7lL+9AAAAAElFTkSuQmCC')),
                ),
              ),
            ],
          ),
          Divider(),
          Text(
            'Edit Photo',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Full name',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  textBaseline: TextBaseline.ideographic),
            ),
          ),
          Divider(),
          Container(
            width: 400,
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Enter your full name",
                  fillColor: Colors.white70),
            ),
          ),
          Divider(),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Email',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          Container(
            width: 400,
            child: Material(
              elevation: 20,
              shadowColor: Colors.black,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.black),
                    hintText: "Enter your email",
                    fillColor: Colors.white70),
              ),
            ),
          ),
          Divider(),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Change password',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Save"),
          ),
        ],
      )),
    );
  }
}
