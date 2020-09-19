import 'package:bodytime/api/get_reservations.dart';
import 'package:bodytime/models/reservation.dart';
import 'package:flutter/material.dart';

import 'configurations.dart';

class ReservationList extends StatefulWidget {
  ReservationList({Key key}) : super(key: key);

  @override
  _ReservationListState createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {
  List<Reservation> _reservations;

  int _currentIndex = 1;

  final List<String> _titles = [
    "Geçmiş",
    "Gelecek",
  ];

  @override
  void initState() {
    super.initState();

    GetReservations().call().then((value) {
      setState(() {
        _reservations = value;
      });
    });
  }

  _getDealDateString(DateTime date) {
    String mediaDateString = '';

    mediaDateString =
        (date.day < 10 ? '0' + date.day.toString() : date.day.toString());

    mediaDateString += '.';

    mediaDateString +=
        (date.month < 10 ? '0' + date.month.toString() : date.month.toString());

    mediaDateString += '.';
    mediaDateString += date.year.toString();

    mediaDateString += "  ";

    mediaDateString +=
        (date.hour < 10 ? '0' + date.hour.toString() : date.hour.toString());

    mediaDateString += ':';

    mediaDateString += (date.minute < 10
        ? '0' + date.minute.toString()
        : date.minute.toString());

    return mediaDateString;
  }

  Widget _buildTopNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x2C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 1,
          ),
        ],
      ),
      height: 48,
      child: Row(
        children: <Widget>[
          _buildTopNavigationBarItem(
            _titles[0],
            _currentIndex == 0,
                () => this.setState(() {
              _currentIndex = 0;
            }),
          ),
          _buildTopNavigationBarItem(
            _titles[1],
            _currentIndex == 1,
                () => this.setState(() {
              _currentIndex = 1;
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTopNavigationBarItem(
      String title, bool selected, Function onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? PRIMARY_COLOR : Colors.black,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildReservationItem(Reservation reservation) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color(0x2C000000),
              blurRadius: 1,
              offset: Offset(0, 0.5),
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reservation.instructor,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                reservation.branch,
                style: TextStyle(fontSize: 13),
              ),
              Container(
                padding: EdgeInsets.only(top: 6),
                alignment: Alignment.bottomRight,
                child: Text(
                  _getDealDateString(reservation.date),
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTopNavigationBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: _reservations == null
                ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
                : Column(
                    children: _reservations
                        .where((r) => _currentIndex == 0 ? !r.date.isAfter(DateTime.now()) : r.date.isAfter(DateTime.now()))
                        .map((r) => _buildReservationItem(r))
                        .toList(),
                  ),
          ),
        ),
      ],
    );
  }
}
