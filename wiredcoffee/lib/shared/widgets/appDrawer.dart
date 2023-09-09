import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiredcoffee/models/user.dart';
import 'package:wiredcoffee/providers/userProvider.dart';
import 'package:wiredcoffee/screens/business/profilePage.dart';

import '../constants.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isHome = true;
  bool isCart = false;
  bool isAbout = false;
  bool isContactUs = false;
  bool isProfile = false;
  bool isLogout = false;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context, listen: false).user;
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.deepOrange[100]),
              accountName: Text(userData == null ? EMPTY : userData.userName,
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87)),
              accountEmail: Text(userData == null ? EMPTY : userData.email,
                  style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black38)),
              currentAccountPicture: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
                  },
                  child: userData != null &&
                          userData.imageUrl != null &&
                          userData.imageUrl!.isNotEmpty
                      ? CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(userData.imageUrl!))
                      : const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage("assets/defaultUser.jpg")))),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    setState(() {
                      isHome = true;
                      isCart = false;
                      isAbout = false;
                      isContactUs = false;
                      isProfile = false;
                      isLogout = false;
                    });
                  },
                  selected: isHome,
                  selectedTileColor: Colors.black,
                  selectedColor: Colors.deepOrange[100],
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      isHome = false;
                      isCart = true;
                      isAbout = false;
                      isContactUs = false;
                      isProfile = false;
                      isLogout = false;
                    });
                  },
                  selected: isCart,
                  selectedTileColor: Colors.black,
                  selectedColor: Colors.deepOrange[100],
                  leading: const Icon(Icons.shopping_cart),
                  title: const Text('Cart'),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      isHome = false;
                      isCart = false;
                      isAbout = true;
                      isContactUs = false;
                      isProfile = false;
                      isLogout = false;
                    });
                  },
                  selected: isAbout,
                  selectedTileColor: Colors.black,
                  selectedColor: Colors.deepOrange[100],
                  leading: const Icon(Icons.info),
                  title: const Text('About Us'),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      isHome = false;
                      isCart = false;
                      isAbout = false;
                      isContactUs = true;
                      isProfile = false;
                      isLogout = false;
                    });
                  },
                  selected: isContactUs,
                  selectedTileColor: Colors.black,
                  selectedColor: Colors.deepOrange[100],
                  leading: const Icon(Icons.phone),
                  title: const Text('Contact Us'),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      isHome = false;
                      isCart = false;
                      isAbout = false;
                      isContactUs = false;
                      isProfile = true;
                      isLogout = false;
                    });
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (ctx) => const ProfilePage()));
                  },
                  selected: isContactUs,
                  selectedTileColor: Colors.black,
                  selectedColor: Colors.deepOrange[100],
                  leading: const Icon(Icons.phone),
                  title: const Text('Profile'),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      isHome = false;
                      isCart = false;
                      isAbout = false;
                      isContactUs = false;
                      isLogout = true;
                    });
                    FirebaseAuth.instance.signOut();
                  },
                  selected: isLogout,
                  selectedTileColor: Colors.black,
                  selectedColor: Colors.deepOrange[100],
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
