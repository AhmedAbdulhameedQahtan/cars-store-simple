import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:simple_car_store/view/login_view.dart';

class FirbaseAuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // تحقق من صحة تنسيق البريد الإلكتروني
  bool isEmailValid(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }


  Future<User?> signUpWithEmailAndPassword(String email,String password) async{
    if (isEmailValid(email)) {

      try{
        UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
        return credential.user;
      }catch(e){
        print("error ==================$e");
      }
    }
    print("البريد الإلكتروني غير صحيح. الرجاء التحقق من تنسيقه.");
    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email,String password) async{
    if (isEmailValid(email)) {
      try{
        UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
        return credential.user;
      }catch(e){
        print("error ==================$e");
      }
    }
    print("البريد الإلكتروني غير صحيح. الرجاء التحقق من تنسيقه.");
    return null;
  }

}



class NetworkChecker extends StatefulWidget {
  @override
  _NetworkCheckerState createState() => _NetworkCheckerState();
}

class _NetworkCheckerState extends State<NetworkChecker> {
  late Stream<ConnectivityResult> _connectivityStream;
  bool _isDialogOpen = false;

  @override
  void initState() {
    super.initState();
    _connectivityStream = Connectivity().onConnectivityChanged.map((resultList) => resultList.isNotEmpty ? resultList.first : ConnectivityResult.none);
    _connectivityStream.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _showNoConnectionDialog();
      } else {
        _closeNoConnectionDialog();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginView()));
      }
    });
  }

  void _showNoConnectionDialog() {
    if (!_isDialogOpen) {
      _isDialogOpen = true;
      showDialog(
        context: context,
        barrierDismissible: false,  // لمنع إغلاق التنبيه بالضغط خارج النافذة
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('No Internet Connection'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _isDialogOpen = false;  // لضبط الحالة عند إغلاق النافذة
              },
              child: const Text('ok'),
            ),
          ],
        ),
      ).then((_) {
        _isDialogOpen = false;
      });
    }
  }

  void _closeNoConnectionDialog() {
    if (_isDialogOpen) {
      Navigator.of(context, rootNavigator: true).pop();
      _isDialogOpen = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Connection'),
      ),
      body:const Center(
        child: Text('Welcome!'),
      ),
    );
  }
}
