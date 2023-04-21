import 'package:boxmusic2/ui/Auth/signUpUI.dart';
import 'package:boxmusic2/ui/mainUI.dart';
import 'package:boxmusic2/ui/profile/profileUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/theme.dart';

class SignInUi extends StatefulWidget {
  const SignInUi({Key? key}) : super(key: key);

  @override
  State<SignInUi> createState() => _SignInUiState();
}

class _SignInUiState extends State<SignInUi> with WidgetsBindingObserver{
  bool _rememberMe = false;

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: aLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: aBoxDecorationStyle,
          height: 60.0,
          child: const TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: aHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
          style: aLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: aBoxDecorationStyle,
          height: 60.0,
          child: const TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: aHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.only(right: 0.0)),
        ),
        child: const Text(
          'Forgot Password?',
          style: aLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return SizedBox(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          const Text(
            'Remember me',
            style: aLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Naviguer vers le Main
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfileUi()),);
        },
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Colors.white,
        ),
        child: const Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF1F1F2E),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return const Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: aLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(VoidCallback onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildSocialBtn(
                () => print('Login with Google'),
            const AssetImage(
              'lib/assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        // Naviguer vers la page SignUp
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SignUpUI()),);
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF4A4A58),
                  Color(0xFF3C3C4C),
                  Color(0xFF2E2E3D),
                  Color(0xFF1F1F2E),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildEmailTF(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
                      _buildRememberMeCheckbox(),
                      _buildLoginBtn(),
                      _buildSignInWithText(),
                      _buildSocialBtnRow(),
                      _buildSignupBtn(),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom,
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