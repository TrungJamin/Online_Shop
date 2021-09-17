import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:online_shop_udemy/consts/colors.dart';
import 'package:online_shop_udemy/screens/auth/component/auth_divider.dart';
import 'package:online_shop_udemy/screens/auth/sign_up/sign_up.dart';
import 'package:online_shop_udemy/screens/components/custom_outline_button.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _passwordFocusNode = FocusNode();
  bool _obscureText = true;
  String? _emailAddress = '';
  String? _password = '';
  bool isSignIn = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isSignIn
        ? SignUpScreen()
        : SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.95,
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: WaveWidget(
                          config: CustomConfig(
                            gradients: [
                              [
                                ColorsConsts.gradiendFStart,
                                ColorsConsts.gradiendLStart
                              ],
                              [
                                ColorsConsts.gradiendFEnd,
                                ColorsConsts.gradiendLEnd
                              ],
                            ],
                            durations: [19440, 10800],
                            heightPercentages: [0.20, 0.25],
                            blur: MaskFilter.blur(BlurStyle.solid, 10),
                            gradientBegin: Alignment.bottomLeft,
                            gradientEnd: Alignment.topRight,
                          ),
                          waveAmplitude: 0,
                          size: Size(
                            double.infinity,
                            double.infinity,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 80),
                          height: 120.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                            //  color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://image.flaticon.com/icons/png/128/869/869636.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextFormField(
                                  key: ValueKey('email'),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !value.contains('@')) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () =>
                                      FocusScope.of(context)
                                          .requestFocus(_passwordFocusNode),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      border: const UnderlineInputBorder(),
                                      filled: true,
                                      prefixIcon: Icon(Icons.email),
                                      labelText: 'Email Address',
                                      fillColor:
                                          Theme.of(context).backgroundColor),
                                  onSaved: (value) {
                                    _emailAddress = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextFormField(
                                  key: ValueKey('Password'),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 7) {
                                      return 'Please enter a valid Password';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  focusNode: _passwordFocusNode,
                                  decoration: InputDecoration(
                                      border: const UnderlineInputBorder(),
                                      filled: true,
                                      prefixIcon: Icon(Icons.lock),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                        child: Icon(_obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                      ),
                                      labelText: 'Password',
                                      fillColor:
                                          Theme.of(context).backgroundColor),
                                  onSaved: (value) {
                                    _password = value;
                                  },
                                  obscureText: _obscureText,
                                  onEditingComplete: _submitForm,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          side: BorderSide(
                                              color:
                                                  ColorsConsts.backgroundColor),
                                        ),
                                      )),
                                      onPressed: _submitForm,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Login',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Feather.user,
                                            size: 18,
                                          )
                                        ],
                                      )),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            AuthDivider(),
                            Text(
                              'Or continue with',
                              style: TextStyle(color: Colors.black),
                            ),
                            AuthDivider(),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 90,
                            ),
                            CustomOutlineButton(
                              title: "Google",
                              imgUrl: "assets/images/google_plus_logo.png",
                              shape: StadiumBorder(),
                              highlightedBorderColor: Colors.red.shade200,
                              titleColor: Colors.red,
                              borderColor: Colors.red,
                              onPressed: () {},
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            CustomOutlineButton(
                              title: "Facebook",
                              imgUrl: "assets/images/facebook_logo.png",
                              shape: StadiumBorder(),
                              highlightedBorderColor: Color(0xFF3B5998),
                              titleColor: Color(0xFF3B5998),
                              borderColor: Color(0xFF3B5998),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account?     ',
                            style: TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    setState(() {
                                      isSignIn = !isSignIn;
                                    });
                                  },
                                text: 'Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3B5998),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
