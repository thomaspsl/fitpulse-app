import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Instances Firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle() async {
    // Démarrer le processus de connexion
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtenir les détails d'authentification de la requête
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    // Créer un nouveau identifiant pour l'utilisateur
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Se connecter avec les identifiants
    UserCredential result = await _auth.signInWithCredential(credential);

    // Si l'utilisateur est nouveau, ajouter ses informations à Firestore
    if (result.additionalUserInfo!.isNewUser) {
      var user = _auth.currentUser!.uid;
      var name = googleUser.displayName.toString();
      var email = googleUser.email.toString();
      await _addGoogleUser(user, name, email);
    }
  }

  Future<void> _addGoogleUser(String userID, String name, String email) {
    return _firestore
        .collection('Users')
        .doc(userID)
        .set({
      'name': name,
      'email': email,
    })
        .then((value) => print('Utilisateur ajouté'))
        .catchError((error) => print('Erreur : $error'));
  }
}