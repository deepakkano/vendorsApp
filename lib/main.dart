// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vendorapp/firebase_options.dart';
import 'package:vendorapp/vendordashboard.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    
);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            debugShowCheckedModeBanner: false,

      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (FirebaseAuth.instance.currentUser != null)
          ? VendorDashboard()
          : MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
   TextEditingController emailController=TextEditingController()  ;
 TextEditingController passwordController=TextEditingController()  ;  String? errorname;

void LoginFuntion() async{
  String Email=emailController.text.trim();
  String Password=passwordController.text.trim();
if(Email=="" || Password==""){
  print("Filed not be empty");
}



else {

try{



UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: Email, password: Password);
if(userCredential.user!=null){

if(Email=="shubash1234@gmail.com"){
print("Check YOur Email id password  login with admin app");
}
else{
  Navigator.popUntil(context, (route) => route.isFirst);
  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> VendorDashboard() ));
}}
}
on FirebaseAuthException catch(excpetion){
  print(excpetion.code.toString());
  switch (excpetion.code) {
          case "invalid-credential":
            showerror(excpetion.code);
            break;
          case "invalid-email":
            showerror(excpetion.code);
            break;
          case "invalid-credential":
            showerror(excpetion.code);
            break;
          case "invalid-email":
            showerror(excpetion.code);
            break;
          default:
            print("Unknown error.");
        }
}

}

}

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       
      ),
      body:Container(
        height: double.infinity,
        child: Column(
           children: [
            Padding(
              padding: const  EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Container(
              width:double.infinity,height: 100,
                
                  
                      child: Align( alignment:Alignment.center ,
                      child: Text("Statinory vender",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
              ),
            ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                  controller: emailController,
                      decoration: const InputDecoration(
                        
                          border: OutlineInputBorder(), labelText: "Email"),
                      
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                   controller:  passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Password"),
                     
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                         LoginFuntion();
                        
                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ),
                 
                ],
              ),
            ),
          
          
          
          
          
          
          
            
           ],
            
                ),
        
      )
    );
  }
  void showerror(String errortype) {
    errorname = errortype;
    final snackBar = SnackBar(
      content: Text("$errorname"),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
