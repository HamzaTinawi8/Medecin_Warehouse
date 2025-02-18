import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:medecin_warehouse/controller/logout_controller.dart';
import 'package:medecin_warehouse/data/model/user_model.dart';
import 'package:medecin_warehouse/generated/l10n.dart';
import 'package:medecin_warehouse/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? status = 'en';

  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('name') ?? 'User';
    return userName;
  }

  @override
  Widget build(BuildContext context) {
    final logoutController = LogoutController();
    return FutureBuilder<String>(
      future: getUserName(),
      builder: (context, snapshot) {
        String userName = snapshot.data ?? 'User';
        return Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).Settings,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: const CircleAvatar(
                  radius: 25,
                ),
                title: Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  S.of(context).Profile,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                height: 10,
                thickness: 1,
              ),
              const SizedBox(height: 20),
              ListTile(
                onTap: () {},
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  radius: 25,
                  child: const Icon(
                    CupertinoIcons.person,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
                title: Text(
                  S.of(context).InfoProfile,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon((Icons.arrow_forward_ios_rounded)),
              ),
              const SizedBox(height: 10),
              ListTile(
                onTap: () {},
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple.shade100,
                  radius: 25,
                  child: const Icon(
                    Icons.notifications_none_outlined,
                    size: 30,
                    color: Colors.deepPurple,
                  ),
                ),
                title: Text(
                  S.of(context).Notifications,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon((Icons.arrow_forward_ios_rounded)),
              ),
              const SizedBox(height: 10),
              ListTile(
                onTap: () {},
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.indigo.shade100,
                  child: const Icon(
                    Icons.privacy_tip_outlined,
                    size: 30,
                    color: Colors.indigo,
                  ),
                ),
                title: Text(
                  S.of(context).Privacy,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon((Icons.arrow_forward_ios_rounded)),
              ),
              const SizedBox(height: 10),
              ListTile(
                  onTap: () {},
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.green.shade100,
                    child: const Icon(
                      Icons.language,
                      size: 30,
                      color: Colors.green,
                    ),
                  ),
                  title: Text(
                    S.of(context).language,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: DropdownButton(
                    hint: const Text("change lang"),
                    value: status,
                    icon: const Icon(Icons.menu),
                    items: [
                      DropdownMenuItem<String>(value: 'en', child: Text('eng')),
                      DropdownMenuItem<String>(value: 'ar', child: Text('arb'))
                    ],
                    onChanged: (String? val) {
                      setState(() {
                        status = val;
                        (status == 'en')
                            ? MyApp(
                                x: 'en',
                              )
                            // : MyApp(x: 'en');
                            : Phoenix(child: MyApp(x: 'ar'));

                        print(S.of(context).tittle);
                      });
                    },
                  )),
              const SizedBox(height: 10),
              // ListTile(
              //   onTap: () {},
              //   leading: CircleAvatar(
              //     radius: 25,
              //     backgroundColor: Colors.orange.shade100,
              //     child: const Icon(
              //       Icons.info_outline_rounded,
              //       size: 30,
              //       color: Colors.orange,
              //     ),
              //   ),
              //   title: const Text(
              //     "About Us",
              //     style: TextStyle(
              //       fontSize: 20,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              //   trailing: const Icon((Icons.arrow_forward_ios_rounded)),
              // ),
              const SizedBox(height: 10),
              const Divider(
                height: 10,
                thickness: 1,
              ),
              const SizedBox(height: 10),
              ListTile(
                onTap: () {
                  logoutController.logout(context);
                },
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.redAccent.shade100,
                  child: const Icon(
                    Icons.logout,
                    size: 30,
                    color: Colors.redAccent,
                  ),
                ),
                title: Text(
                  S.of(context).LogOut,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon((Icons.arrow_forward_ios_rounded)),
              ),
            ],
          ),
        );
      },
    );
  }
}
