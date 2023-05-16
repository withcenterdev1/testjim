import 'dart:developer';
// import 'dart:ffi';
// import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:go_router/go_router.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({
    super.key,
  });

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  late FixedExtentScrollController _controller;

  User? user;
  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController();
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
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.blue,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text(
          'Reminder',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: (Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: Text(
                          'Please select reminder time',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey, width: 1),
                            bottom: BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        height: 40,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          SizedBox(
                            width: 70,
                            child: ListWheelScrollView.useDelegate(
                              controller: _controller,
                              itemExtent: 35,
                              perspective: 0.005,
                              diameterRatio: 1.2,
                              physics: const FixedExtentScrollPhysics(),
                              childDelegate: ListWheelChildLoopingListDelegate(
                                children: List<Widget>.generate(
                                  12,
                                  (index) => Text(
                                    index.toString(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: ListWheelScrollView.useDelegate(
                              itemExtent: 40,
                              perspective: 0.005,
                              diameterRatio: 1.2,
                              physics: const FixedExtentScrollPhysics(),
                              childDelegate: ListWheelChildLoopingListDelegate(
                                children: List<Widget>.generate(
                                  60,
                                  (index) => Text(
                                    (index < 10 ? '0$index' : index.toString()),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: ListWheelScrollView(
                              itemExtent: 40,
                              children: const [
                                Text(
                                  'AM',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'PM',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    'How often repeat',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 488,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.purple,
                              shape: const StadiumBorder()),
                          child: const Text('Everyday'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: null,
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.purple,
                              disabledBackgroundColor: Colors.grey,
                              shape: const StadiumBorder()),
                          child: const Text('Mon-Fri'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: null,
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.purple,
                              disabledBackgroundColor: Colors.grey,
                              shape: const StadiumBorder()),
                          child: const Text('Weekends'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 488,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: null,
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.purple,
                              disabledBackgroundColor: Colors.grey,
                              shape: const StadiumBorder()),
                          child: const Text('Mon'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: null,
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.purple,
                              disabledBackgroundColor: Colors.grey,
                              shape: const StadiumBorder()),
                          child: const Text('Tue'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: null,
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.purple,
                              disabledBackgroundColor: Colors.grey,
                              shape: const StadiumBorder()),
                          child: const Text('Wed'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: null,
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.purple,
                              disabledBackgroundColor: Colors.grey,
                              shape: const StadiumBorder()),
                          child: const Text('Thu'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: null,
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.purple,
                              disabledBackgroundColor: Colors.grey,
                              shape: const StadiumBorder()),
                          child: const Text('Fri'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 488,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: null,
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.purple,
                            disabledBackgroundColor: Colors.grey,
                            shape: const StadiumBorder()),
                        child: const Text('Sat'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: null,
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.purple,
                            disabledBackgroundColor: Colors.grey,
                            shape: const StadiumBorder()),
                        child: const Text('Sun'),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 400,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.purple,
                          shape: const StadiumBorder()),
                      onPressed: () {},
                      child: const Text("Save"),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
