import 'package:e_commerce/data/repositories/user/user_repository.dart';
import 'package:e_commerce/features/authetication/screens/login_screen/login.dart';
import 'package:e_commerce/features/authetication/screens/onboarding/on_boarding.dart';
import 'package:e_commerce/features/authetication/screens/signup/verify_email.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:e_commerce/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce/utils/exceptions/format_exceptions.dart';
import 'package:e_commerce/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  ///When AuthenticationRepository called onReady method will run

  final localStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove(); //Means phele show hogi then remove hojaegi

    // Redirect to the right screen
    screenRedirect();

    // Get.put(BannerRepository()).uploadBanners(ZDummyData.banner);
    // Get.put(CategoryRepository()).uploadProductCategories(ZDummyData.productCategory);
    // Get.put(CategoryRepository()).uploadCategories(ZDummyData.categories);
  }

  Future<void> screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      //Check if user is verified
      if (user.emailVerified) {
        //If verified go to Navigation menu
        Get.offAll(() => NavigationMenu());

        // Initialize user specific box
        await GetStorage.init(user.uid);
      } else {
        //if not verified go to verify email screen
        Get.offAll(() => VerifyEmailScreen(email: user.email));
      }
    } else {
      ///To ab yahan par men ye karun ga onboarding screen sirf os user ko show ho
      ///jo first time aya ho app par 2nd ya 3rd time onboarding screen show na ho

      localStorage.writeIfNull("isFirstTime", true);

      localStorage.read("isFirstTime") != true
          ? Get.offAll(() => LoginScreen())
          : Get.offAll(() => OnBoardingScreen());
    }
  }

  /// [Authentication] - With Email and Password
  Future<UserCredential> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException {
      throw ZFormatExceptions();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong Please try again";
    }
  }

  /// [Authentication] - Sign In
  Future<UserCredential> loginWithEmailAndPassword(String email, String password,) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException {
      throw ZFormatExceptions();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong Please try again";
    }
  }

  /// [Google Authentication] - Sign In with Google
  Future<UserCredential> signInWithGoogle() async {
    try {
      //Show Popup to select google account
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //Get the Auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      //create credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      //Sign In using Google Credential
      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException {
      throw ZFormatExceptions();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong Please try again";
    }
  }

  /// [EmailVerification] - Send Mail
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException {
      throw ZFormatExceptions();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong Please try again";
    }
  }

  /// [ForgetPassword Verification] - Send Mail to Reset Password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException {
      throw ZFormatExceptions();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong Please try again";
    }
  }

  /// [ForgetPassword Verification] - Send Mail to Reset Password
  Future<void> reAuthenticateUserWithEmailAndPassword(String email, String password,) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      await currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException {
      throw ZFormatExceptions();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong Please try again";
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException {
      throw ZFormatExceptions();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong Please try again";
    }
  }

  /// [DeleteUser] - Delete User Account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(currentUser!.uid);

      //Remove Profile from cloudinary
      String publicId = UserController.instance.user.value.publicId;
      if (publicId.isNotEmpty) {
        await UserRepository.instance.deleteProfilePicture(publicId);
      }

      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException {
      throw ZFormatExceptions();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong Please try again";
    }
  }
}
