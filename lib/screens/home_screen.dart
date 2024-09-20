import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ledger_book_app/models/nav_model.dart';
import 'package:ledger_book_app/widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<NavigatorState> _recordListNavKey =
      GlobalKey<NavigatorState>();

  DateTime _currentTime = DateTime.now();

  int selectedTab = 0;
  List<NavModel> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      NavModel(
        page: const InOutRecordListWidget(),
        navKey: _recordListNavKey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          items[selectedTab].navKey.currentState?.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              InkWell(
                onTap: () => {
                  setState(() {
                    _currentTime = DateTime(
                      _currentTime.year,
                      _currentTime.month - 1,
                      _currentTime.day,
                    );
                  })
                },
                child: const Icon(
                  Icons.arrow_left_rounded,
                  size: 50,
                ),
              ),
              Text(
                DateFormat('MMM yyyy').format(_currentTime),
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () => {
                  setState(() {
                    _currentTime = DateTime(
                      _currentTime.year,
                      _currentTime.month + 1,
                      _currentTime.day,
                    );
                  })
                },
                child: const Icon(
                  Icons.arrow_right_rounded,
                  size: 50,
                ),
              ),
            ],
          ),
        ),
        body: IndexedStack(
          index: selectedTab,
          children: items
              .map((page) => Navigator(
                    key: page.navKey,
                    onGenerateInitialRoutes: (navigator, initialRoute) {
                      return [
                        MaterialPageRoute(builder: (context) => page.page)
                      ];
                    },
                  ))
              .toList(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.only(top: 10),
          height: 64,
          width: 64,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 0,
            onPressed: () => debugPrint("Add Button pressed"),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: Colors.blue),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.camera_alt_rounded,
              color: Colors.blue,
            ),
          ),
        ),
        bottomNavigationBar: NavBarWidget(
          pageIndex: selectedTab,
          onTap: (index) {
            if (index == selectedTab) {
              items[index]
                  .navKey
                  .currentState
                  ?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                selectedTab = index;
              });
            }
          },
        ),
      ),
    );
  }
}

class T {
  final String name;
  final String cost;

  const T(this.name, this.cost);
}

class InOutRecordListWidget extends StatefulWidget {
  const InOutRecordListWidget({super.key});

  @override
  State<InOutRecordListWidget> createState() => _InOutRecordListWidgetState();
}

class _InOutRecordListWidgetState extends State<InOutRecordListWidget> {
  final List<T> records = <T>[
    const T('A', '10'),
    const T('B', '20'),
    const T('C', '100'),
    const T('A', '10'),
    const T('B', '20'),
    const T('C', '100'),
    const T('A', '10'),
    const T('B', '20'),
    const T('C', '100'),
    const T('A', '10'),
    const T('B', '20'),
    const T('C', '100'),
    const T('A', '10'),
    const T('B', '20'),
    const T('C', '100'),
    const T('A', '10'),
    const T('B', '20'),
    const T('C', '100'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: ListView.builder(
          controller: ScrollController(),
          itemCount: records.length + 1,
          itemBuilder: (context, index) {
            if (records.length == index) {
              return const SizedBox();
            }
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey, // Border color
                    width: 1.0, // Border width
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(records[index].name),
                  Text(records[index].cost),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
