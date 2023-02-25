import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sillicon_films/src/config/app_styles.dart';
import 'package:sillicon_films/src/config/navigation/navigator_routes.dart';
import 'package:sillicon_films/src/ui/widgets/auth/inputText.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: _content(),
      ),
    );
  }

  Widget _content(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
        child: Column(
          children: [
            _logo(),
            _welcomeText(),
            _signInForm(),
            Spacer(),
            _loginButton(),
            SizedBox(height: 40,),
            _registerNav(),
            SizedBox(height: 40,)
          ],
        ),
        )],
      ),
    );
  }

  Widget _logo(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 60),
      child: CircleAvatar(
        foregroundImage: AssetImage("assets/images/logo.png"),
        backgroundColor: Colors.transparent,
        radius: 68,
      ),
    );
  }
  Widget _welcomeText(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text("Bienvenido a Sillicon series"
      ),
    );
  }
  Widget _signInForm(){
    return Form(
      child: Column(
        children: [
         InputText("email",_email,(value){},prefixIcon: Icons.mail,),
          InputText("password",_password,(value){},password: true,prefixIcon: Icons.lock, suffixIcon: Icons.remove_red_eye_outlined,),
        ],
      ),
    );
  }
  Widget _loginButton(){
    return ElevatedButton(onPressed: (){
      Navigator.pushReplacementNamed(context, NavigationRoutes.home);
    }, child: Text("Iniciar Sesión"));
  }
  Widget _registerNav(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: RichText(text: TextSpan(children: [
        TextSpan(text: "Puedes registrarte  ",style: AppStyles.textTheme.bodyMedium!.copyWith(color: AppStyles.onBackground)),
        TextSpan(text: "aquí",style: AppStyles.textTheme.bodyMedium!.copyWith(color: AppStyles.primary),recognizer: TapGestureRecognizer()..onTap=(){
          print("move");
        })
      ])),
    );
  }



}
