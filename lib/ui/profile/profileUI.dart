import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'editprofile.dart';

class ProfileUi extends StatefulWidget {
  const ProfileUi({Key? key}) : super(key: key);
  @override
  State<ProfileUi> createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {
  getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: const [
        IconButton(icon: Icon(Icons.logout, color: Colors.white,),
            onPressed: null)],
    iconTheme: const IconThemeData(color: Colors.white,),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF4A4A58),
                Color(0xFF3C3C4C),
                Color(0xFF2E2E3D),
                Color(0xFF1F1F2E),
              ],
              stops: [0.1, 0.4, 0.7, 1.0],
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: getAppBar(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  const Text(
                    'Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 34,),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: height * 0.40,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0, left: 0, right: 0,
                              child: Container(
                                height: innerHeight * 0.70,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 80,),
                                    const Text('Esk Lab',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 37,
                                      ),
                                    ),
                                    const SizedBox(height: 8,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text('Playlists',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 25,
                                              ),
                                            ),
                                            const Text('2',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25,
                                              ),
                                            ),],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8,),
                                          child: Container(
                                            height: 50, width: 3,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Artists',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 25,
                                              ),
                                            ),
                                            const Text(
                                              '7',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25,
                                              ),
                                            ),],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8,),
                                          child: Container(height: 50, width: 3,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Likes',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 25,
                                              ),
                                            ),
                                            const Text(
                                              '22',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25,
                                              ),
                                            ),],
                                        ),],
                                    ),],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              right: 10,
                              child: IconButton(
                              icon:const Icon(Icons.settings,color: Colors.grey,size: 32,),
                                onPressed: () {
                                  Navigator.push(context,
                                      PageTransition(
                                          alignment: Alignment.bottomCenter,
                                          child: const EditProfile(),
                                          type: PageTransitionType.scale));
                                  },),
                            ),
                            Positioned(top: 0, left: 0, right: 0,
                              child: Center(child: Image.asset(
                                'lib/assets/images/profile.png',
                                width: innerWidth * 0.4,
                                fit: BoxFit.fitWidth,
                              ),
                              ),
                            ),],
                        );
                      },),
                  ),
                  const SizedBox(height: 30,),
                  Container(height: height * 0.5, width: width,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white,
                    ),
                    child:Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(padding: EdgeInsets.only(left: 20),
                                child: Text('Packages',
                                  style: TextStyle(color: Colors.black, fontSize: 28,
                                  ),
                                ),
                              ),
                              Icon(Icons.add_business_rounded),
                            ],
                          ),
                          const Divider(thickness: 2.5,),
                          const SizedBox(height: 8,),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _boxDialog();
                                },
                                child: Container(
                                  height: height * 0.15,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [Colors.grey.withOpacity(0.3), Colors.grey.withOpacity(1.0)],
                                    ),
                                  ),
                                  child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(padding: EdgeInsets.only(left: 20),
                                        child: Text('You are Using a Free Package',
                                          style: TextStyle(color: Colors.black, fontSize: 24,),
                                        ),
                                      ), Icon(Icons.arrow_forward_ios),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              GestureDetector(
                                onTap: () {
                                 _boxDialog();
                                },
                                child: Container(
                                  height: height * 0.15,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [Colors.grey.withOpacity(0.3), Colors.grey.withOpacity(1.0)],
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text('Update to a Better Package',
                                          style: TextStyle(color: Colors.black, fontSize: 24,),),
                                      ), Icon(Icons.arrow_forward_ios),
                                    ],),
                                ),
                              ),
                            ],),
                        ],),
                    ),
                  ),
                ],),
            ),
          ),
        ),
      ],);
  }

  _boxDialog(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("En maintenance"),
        content: const Text("Cette option est actuellement en cours de maintenance."),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}