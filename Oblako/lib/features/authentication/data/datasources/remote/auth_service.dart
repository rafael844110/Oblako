import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cullinarium/features/profile/data/mappers/chef_mapper.dart';
import 'package:cullinarium/features/profile/data/mappers/user_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  // Cached domain model — set after signUp/signIn so authChanges doesn't
  // race against the Firestore write.
  dynamic _cachedUser;

  AuthService(this._auth, this._firestore);

  User? get currentUser => _auth.currentUser;

  Stream<dynamic> get authChanges =>
      _auth.authStateChanges().asyncMap((user) async {
        if (user == null) {
          _cachedUser = null;
          return null;
        }
        if (_cachedUser != null) return _cachedUser;
        return await _fetchUserData(user.uid);
      });

  Future<dynamic> _fetchUserData(String uid) async {
    try {
      final chefDoc = await _firestore.collection('chefs').doc(uid).get();
      if (chefDoc.exists) {
        final data = chefDoc.data()!;
        data['id'] = uid;
        return ChefMapper.fromJson(data);
      }

      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        final data = userDoc.data()!;
        data['id'] = uid;
        return UserMapper.fromJson(data);
      }
    } catch (_) {
      // Firestore unavailable (offline / not yet provisioned) — return cache
      return _cachedUser;
    }
    return null;
  }

  Future<dynamic> signUp({
    required String email,
    required String password,
    required String name,
    required String role,
    required String phoneNumber,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final uid = credential.user!.uid;
    final now = DateTime.now().toIso8601String();
    final avatar =
        'https://ui-avatars.com/api/?name=${Uri.encodeComponent(name)}';

    if (role == 'chef') {
      final data = {
        'id': uid,
        'name': name,
        'email': email,
        'role': role,
        'phoneNumber': phoneNumber,
        'createdAt': now,
        'avatar': avatar,
        'profile': null,
        'chefDetails': null,
      };
      await _firestore.collection('chefs').doc(uid).set(data);
      _cachedUser = ChefMapper.fromJson(data);
    } else {
      final data = {
        'id': uid,
        'name': name,
        'email': email,
        'role': role,
        'phoneNumber': phoneNumber,
        'createdAt': now,
        'avatar': avatar,
      };
      await _firestore.collection('users').doc(uid).set(data);
      _cachedUser = UserMapper.fromJson(data);
    }

    return _cachedUser;
  }

  Future<dynamic> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    _cachedUser = await _fetchUserData(credential.user!.uid);
    return _cachedUser;
  }

  Future<void> signOut() async {
    _cachedUser = null;
    await _auth.signOut();
  }

  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No user signed in');
    final uid = user.uid;
    await _firestore.collection('chefs').doc(uid).delete();
    await _firestore.collection('users').doc(uid).delete();
    _cachedUser = null;
    await user.delete();
  }

  Future<void> resetPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<dynamic> getCurrentUserData() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    if (_cachedUser != null) return _cachedUser;
    return await _fetchUserData(user.uid);
  }

  Future<void> changePassword({required String newPassword}) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No user signed in');
    await user.updatePassword(newPassword);
  }

  Future<void> updateEmail({required String newEmail}) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No user signed in');
    await user.verifyBeforeUpdateEmail(newEmail);
  }
}
