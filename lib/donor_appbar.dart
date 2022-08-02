// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:dashboard_final/pendingdonation.dart';
import 'package:dashboard_final/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';
import 'Services/donationServices.dart';
import 'donationHistory.dart';
import 'contacts.dart';
import 'my_drawer_header.dart';
import 'notification.dart';
import './myprofile.dart';
import 'griddashboard.dart';

import 'EditProfile.dart';

final List<DonationData> donations = [];

class DonorAppBar extends StatefulWidget {
  int donorId;
  final username;
  final address;
  final contact;
  final email;
  final password;
  final image;
  DonorAppBar(this.donorId, this.address, this.username, this.contact,
      this.email, this.password, this.image);
  @override
  _DonorAppBar createState() => _DonorAppBar();
}

class _DonorAppBar extends State<DonorAppBar> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    Dashboard(widget.donorId, widget.username, widget.image);
  }

  var currentPage = DrawerSections.griddashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.griddashboard) {
      container = Dashboard(widget.donorId, widget.username, widget.image);
    } else if (currentPage == DrawerSections.myprofile) {
      container = EditProfile(widget.address, widget.username, widget.contact,
          widget.email, widget.image, widget.donorId, widget.password);
    } else if (currentPage == DrawerSections.donations) {
      container = DonartionHistory(widget.donorId);
    } else if (currentPage == DrawerSections.settings) {
      container = ChangePassword(widget.donorId, widget.password, widget.email);
    } else if (currentPage == DrawerSections.pendingdonation) {
      container = PendingDonations(widget.donorId);
    } else if (currentPage == DrawerSections.home) {
      container = Dashboard(widget.donorId, widget.username, widget.image);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFF7643),
        title: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text('Donors Dashboard'),
        ),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(widget.email, widget.username, widget.image),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSections.home ? true : false),
          menuItem(2, "My Profile", Icons.image,
              currentPage == DrawerSections.myprofile ? true : false),
          menuItem(3, "Donations", Icons.dashboard,
              currentPage == DrawerSections.donations ? true : false),
          menuItem(4, "Pending Donations", Icons.pending_actions_rounded,
              currentPage == DrawerSections.pendingdonation ? true : false),
          Divider(),
          menuItem(5, "Settings", Icons.settings_outlined,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(6, "Notifications", Icons.notifications_outlined,
              currentPage == DrawerSections.notifications ? true : false),
          logout('Logout', Icons.logout),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.home;
            } else if (id == 2) {
              currentPage = DrawerSections.myprofile;
            } else if (id == 3) {
              currentPage = DrawerSections.donations;
            } else if (id == 4) {
              currentPage = DrawerSections.pendingdonation;
            } else if (id == 5) {
              currentPage = DrawerSections.settings;
            } else if (id == 6) {
              currentPage = DrawerSections.notifications;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget logout(String title, IconData icon) {
    return Material(
      child: InkWell(
        onTap: () async {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => Login()),
              ModalRoute.withName('/login'));
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  myprofile,
  donations,
  settings,
  notifications,
  notes,
  griddashboard,
  pendingdonation,
  home,
}
