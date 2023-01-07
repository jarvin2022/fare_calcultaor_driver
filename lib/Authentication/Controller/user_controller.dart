import 'dart:async';

import 'package:fair_calculator_driver/Home/Controller/home_controller.dart';
import 'package:fair_calculator_driver/main.dart';
import 'package:fair_calculator_driver/packages.dart';

class UserController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController profile = TextEditingController();
  final TextEditingController plateNumber = TextEditingController();

  RxString authSuccess = ''.obs;

  RxString authException = ''.obs;
  RxString exception = ''.obs;

  RxBool obscureStatus = true.obs;
  RxBool obscureStatus2 = true.obs;

  RxString success = ''.obs;
  RxBool newAccount = false.obs;

  Rxn<UserModel> user = Rxn<UserModel>().obs();

  final String weekPasswordException = 'The password provided is too weak.';
  final String emailExistException = 'Email already exist';
  final String invalidEmailException = "Email is invalid";

  FareController? fcontroller;
  HomeController? hcontroller;
  HistoryController? historyController;
  HistoryController? hicontroller;

  @override
  void onInit() {
    super.onInit();
    initControllers();
  }

  void initControllers() {
    try {
      firebaseAuth.authStateChanges().listen((data) {
        if (data == null) {
          Timer(const Duration(seconds: 3), () => Get.toNamed(loginRoute));
          return;
        }

        if (newAccount.isFalse) {
          requestGetUser();
        }
      });
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void navigateToLogin() => Get.toNamed(loginRoute);
  void navigateToHome() => Get.toNamed(homeRoute);

  Future<bool> sendEmailRecoveryLink() async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email.text);
      authSuccess.value = 'Recovery lint sent.';
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code.contains('auth/invalid-email')) {
        authException.value = 'Invalid email.';
      } else if (e.code.contains('auth/user-not-found')) {
        authException.value = 'User not found.';
      }

      authException.refresh();
    } catch (e) {
      authException.value = e.toString();
    }
    return false;
  }

  /// [currentUser] is safe from null Error Exception
  void changePassword() =>
      firebaseAuth.currentUser!.updatePassword(password.text);

  /// [verifyMatchPassword] on password and confirm password match will return true
  bool verifyMatchPassword() => password.text == confirmPassword.text;

  bool verifyIfEmptyControllers(bool isLogin) {
    if (isLogin) {
      bool emailCheck = email.text != '';
      bool passwordCheck = email.text != '';

      return emailCheck && passwordCheck;
    }

    bool emailCheck = email.text != '';
    bool passwordCheck = email.text != '';
    bool cpasswordCheck = email.text != '';

    return emailCheck && passwordCheck && cpasswordCheck;
  }

  bool verifyEmptyUserInformation() {
    bool fname = firstname.text != '';
    bool lname = lastname.text != '';
    bool addr = address.text != '';

    return fname && lname && addr;
  }

  //// Handle call for request Signin method
  void siginIn() => requestSignIn();

  //// Handle call for request Signup method
  void signup() => requestSignUp();

  //// Handle call for sign out method
  void signOut() => requestSignout();

  //// Handle call for Registration of user account
  void registerInformation() => requestPostUser();

  //// [verifyIfEmptyControllers]
  /// validating for empty [TextEditingController] any false state will return false response
  /// toggle response on true result return or stop process
  void requestSignIn() async {
    try {
      if (!verifyIfEmptyControllers(true)) {
        return;
      }

      await firebaseAuth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code.contains('user-not-found')) {
        authException.value = 'No user found for that email.';
      } else if (e.code.contains('wrong-password')) {
        authException.value = 'Wrong password.';
      } else if (e.code.contains('too-many-requests')) {
        authException.value = 'Your account has temporary blocked';
      }

      authException.refresh();
    }
  }

  void requestSignUp() async {
    try {
      if (!verifyIfEmptyControllers(false)) {
        return;
      }

      newAccount.value = true;
      UserCredential res = await firebaseAuth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      if (res.user != null) {
        Get.toNamed(userRoute);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        authException.value = invalidEmailException;
      } else if (e.code == 'weak-password') {
        authException.value = weekPasswordException;
      } else if (e.code == 'email-already-in-use') {
        authException.value = emailExistException;
      }
      authException.refresh();
      newAccount.value = false;
    }
  }

  void requestSignout() {
    try {
      firebaseAuth.signOut();
      disposeControllers();
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void requestGetUser() async {
    try {
      DocumentSnapshot document = await firebaseFirestore
          .collection(userCollection)
          .doc(firebaseAuth.currentUser!.uid)
          .get();

      if (document.exists == false) {
        exception.value = 'User information doesn`t exist';
        Get.toNamed(userRoute);
        throw Exception('Null document');
      }

      fcontroller = Get.put(FareController());
      hcontroller = Get.put(HomeController());
      hicontroller = Get.put(HistoryController());
      user.value = UserModel.fromJson(
          document.data() as Map<String, dynamic>, document.id);

      Timer(const Duration(milliseconds: 300), () => Get.toNamed(homeRoute));
    } catch (err) {
      if (err == Exception('Null document')) {
        exception.value = 'User information doesn`t exist';
        Get.toNamed(userRoute);
      }
      if (err == 'permission-denied') {
        exception.value = 'UnAuthorized';
      }
      exception.value = err.toString();
    }
  }

  void requestPostUser() async {
    try {
      if (!verifyEmptyUserInformation()) {
        return;
      }

      firebaseFirestore
          .collection(userCollection)
          .doc(firebaseAuth.currentUser!.uid)
          .set({
        'user_first_name': firstname.text,
        'user_last_name': lastname.text,
        'user_address': address.text,
        'user_profile': 'NONE',
        'user_plateNumber':plateNumber.text
      }).then((value) => requestGetUser());
    } catch (e) {
      exception.value = e.toString();
    }
  }

  //// On success response call [requestGetUser] to update fetch update user information
  void requestPutUser() async {
    try {
      firebaseFirestore
          .collection(userCollection)
          .doc(firebaseAuth.currentUser!.uid)
          .update({
        'user_first_name': firstname.text,
        'user_last_name': lastname.text,
        'user_address': address.text,
        'user_profile': profile.text,
        'user_plateNumber':plateNumber.text
      }).then((_) => requestGetUser());
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void disposeControllers() {
    try {
      hcontroller?.dispose();
      hcontroller?.dispose();
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void clearText(){
    firstname.clear();
    lastname.clear();
    address.clear();
    plateNumber.clear();
  }
}
