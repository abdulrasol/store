import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  TextEditingController emailControll = TextEditingController();
  TextEditingController passwordControll = TextEditingController();
  TextEditingController passwordControllConferm = TextEditingController();
  bool showPassword = false;
  bool createNewUser = false;

  @override
  Widget build(BuildContext context) {
    var inputDecoration = InputDecoration(
      prefixIcon: const Icon(
        CupertinoIcons.at,
        color: Colors.black87,
      ),
      label: const Text(
        'Email',
        style: TextStyle(color: Colors.black87),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red.shade300,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red.shade300,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(7.0),
        ),
      ),
    );
    return Scaffold(
      appBar: genericAppBar(
        title: createNewUser ? 'Sign up' : 'Log in',
        context: context,
        withBackAction: true,
        centerTitle: true,
        showSearchIcon: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              createNewUser ? 'Create' : 'Welcone',
              style: const TextStyle(fontSize: 38),
            ),
            Text(
              createNewUser ? 'Account' : 'Back',
              style: const TextStyle(fontSize: 38),
            ),
            sizedBox,
            createNewUser
                ? signupForm(inputDecoration)
                : loginForm(inputDecoration),
          ],
        ),
      ),
    );
  }

  Form loginForm(InputDecoration inputDecoration) {
    return Form(
      key: _fromKey,
      child: Column(
        children: [
          sizedBox,
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailControll,
            decoration: inputDecoration,
            validator: (value) {
              if (value == '') {
                return 'please write your email';
              }
              if (!GetUtils.isEmail(value!)) {
                return 'enter valide email';
              } else {
                return null;
              }
            },
            onChanged: (value) => btnController.reset(),
          ),
          sizedBox,
          TextFormField(
            obscureText: !showPassword,
            controller: passwordControll,
            decoration: inputDecoration.copyWith(
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Colors.black87,
              ),
              label: const Text(
                'Password',
                style: TextStyle(color: Colors.black87),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: Icon(
                  showPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black87,
                ),
              ),
            ),
            validator: (value) {
              if (value == '') {
                return 'please write your password';
              }
              return null;
              /*  if (GetUtils.isNumericOnly(value!)) {
                        return 'Please use text with number';
                      }
                      if (!GetUtils.isLengthLessThan(value, 8)) {
                        return 'password should be more thnn 8 char';
                      } else {
                        return null;
                      } */
            },
            onChanged: (value) => btnController.reset(),
          ),
          sizedBox,
          RoundedLoadingButton(
            borderRadius: 8,
            color: Colors.black87,
            successColor: Colors.black87,
            errorColor: Colors.red.shade300,
            controller: btnController,
            onPressed: () {
              if (_fromKey.currentState!.validate()) {
              } else {
                btnController.error();
              }
            },
            child: const Text('Log in'),
          ),
          Row(
            children: [
              const Expanded(child: sizedBox),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forget Password',
                    style: TextStyle(color: Colors.black87),
                  ))
            ],
          ),
          sizedBox,
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.black45)),
                  margin: const EdgeInsets.only(right: 10),
                ),
              ),
              const Text(
                'or',
                style: TextStyle(color: Colors.black45, fontSize: 24),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.black45)),
                  margin: const EdgeInsets.only(left: 10),
                ),
              ),
            ],
          ),
          sizedBox,
          ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(2),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Set the desired border radius here
                ),
              ),
              minimumSize: MaterialStateProperty.all(const Size(300, 50.0)),
            ),
            onPressed: () {
              setState(() {
                createNewUser = !createNewUser;
              });
            },
            child: const Text(
              'Sign up',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Form signupForm(InputDecoration inputDecoration) {
    return Form(
      key: _fromKey,
      child: Column(
        children: [
          sizedBox,
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailControll,
            decoration: inputDecoration,
            validator: (value) {
              if (value == '') {
                return 'please write your email';
              }
              if (!GetUtils.isEmail(value!)) {
                return 'enter valide email';
              } else {
                return null;
              }
            },
            onChanged: (value) => btnController.reset(),
          ),
          sizedBox,
          TextFormField(
            obscureText: !showPassword,
            controller: passwordControll,
            decoration: inputDecoration.copyWith(
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Colors.black87,
              ),
              label: const Text(
                'Password',
                style: TextStyle(color: Colors.black87),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: Icon(
                  showPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black87,
                ),
              ),
            ),
            validator: (value) {
              if (value == '') {
                return 'please write your password';
              }

              if (GetUtils.isNumericOnly(value!)) {
                return 'Please use text with number';
              }
              if (GetUtils.isLengthLessThan(value, 8)) {
                return 'password should be more thnn 8 char';
              } else {
                return null;
              }
            },
            onChanged: (value) => btnController.reset(),
          ),
          sizedBox,
          TextFormField(
            obscureText: !showPassword,
            controller: passwordControllConferm,
            decoration: inputDecoration.copyWith(
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Colors.black87,
              ),
              label: const Text(
                'Password',
                style: TextStyle(color: Colors.black87),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: Icon(
                  showPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black87,
                ),
              ),
            ),
            validator: (value) {
              if (value == '') {
                return 'please write your password again!';
              }

              if (passwordControll.text != passwordControllConferm.text) {
                return 'Password not match';
              } else {
                return null;
              }
            },
            onChanged: (value) => btnController.reset(),
          ),
          sizedBox,
          RoundedLoadingButton(
            borderRadius: 8,
            color: Colors.black87,
            successColor: Colors.black87,
            errorColor: Colors.red.shade300,
            controller: btnController,
            onPressed: () {
              if (_fromKey.currentState!.validate()) {
              } else {
                btnController.error();
              }
            },
            child: const Text('Sign up'),
          ),
          sizedBox,
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.black45)),
                  margin: const EdgeInsets.only(right: 10),
                ),
              ),
              const Text(
                'or',
                style: TextStyle(color: Colors.black45, fontSize: 24),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.black45)),
                  margin: const EdgeInsets.only(left: 10),
                ),
              ),
            ],
          ),
          sizedBox,
          ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(2),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Set the desired border radius here
                ),
              ),
              minimumSize: MaterialStateProperty.all(const Size(300, 50.0)),
            ),
            onPressed: () {
              setState(() {
                createNewUser = !createNewUser;
              });
            },
            child: const Text(
              'Log in',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
