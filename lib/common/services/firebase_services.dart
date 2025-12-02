import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/category_slider_model.dart';
import 'package:evently/models/event_data_model.dart';
import 'package:evently/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  //firebase database
  static CollectionReference<EventDataModel> getEventsCollection() {
    CollectionReference<EventDataModel> eventsCollection = getUsersCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Events')
        .withConverter<EventDataModel>(
          fromFirestore: (snapshot, options) =>
              EventDataModel.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toJson(),
        );
    return eventsCollection;
  }

  static Future<void> addNewEvent(EventDataModel eventDataModel) async {
    CollectionReference<EventDataModel> eventsCollection =
        getEventsCollection();
    DocumentReference<EventDataModel> document = eventsCollection.doc();
    eventDataModel.id = document.id;
    await document.set(eventDataModel);
  }

  static Future<List<EventDataModel>> getAllEvents(
      {CategoryValues? categoryValues}) async {
    CollectionReference<EventDataModel> eventsCollection =
        getEventsCollection();
    QuerySnapshot<EventDataModel> querySnapshot = await eventsCollection
        .orderBy('dateTime')
        .where('categoryValues', isEqualTo: categoryValues?.toJson())
        .get();
    return querySnapshot.docs
        .map(
          (e) => e.data(),
        )
        .toList();
  }

  //

  static Stream<List<EventDataModel>> getAllEventsStream(
      {CategoryValues? categoryValues}) {
    CollectionReference<EventDataModel> eventsCollection =
        getEventsCollection();
    Stream<QuerySnapshot<EventDataModel>> querySnapshot = eventsCollection
        .orderBy('dateTime')
        .where('categoryValues', isEqualTo: categoryValues?.toJson())
        .snapshots();
    var streamData = querySnapshot.map(
      (event) => event.docs
          .map(
            (e) => e.data(),
          )
          .toList(),
    );
    return streamData;
  }

  static Stream<List<EventDataModel>> getFavEventsStream(
      {CategoryValues? categoryValues}) {
    CollectionReference<EventDataModel> eventsCollection =
        getEventsCollection();
    Stream<QuerySnapshot<EventDataModel>> querySnapshot = eventsCollection
        .orderBy('dateTime')
        .where('isFavourite', isEqualTo: true)
        .snapshots();
    var streamData = querySnapshot.map(
      (event) => event.docs
          .map(
            (e) => e.data(),
          )
          .toList(),
    );
    return streamData;
  }

  static Future<void> changeEventFav(
      EventDataModel eventDataModel, bool favValue) async {
    CollectionReference<EventDataModel> eventsCollection =
        getEventsCollection();
    await eventsCollection
        .doc(eventDataModel.id)
        .update({'isFavourite': favValue});
  }

  //delete event
  static Future<void> deleteEvent(EventDataModel eventDataModel) async {
    CollectionReference<EventDataModel> eventsCollection =
        getEventsCollection();
    await eventsCollection.doc(eventDataModel.id).delete();
  }

//update event
  static Future<void> editEvent(EventDataModel eventDataModel) async {
    CollectionReference<EventDataModel> eventsCollection =
        getEventsCollection();
    await eventsCollection
        .doc(eventDataModel.id)
        .update(eventDataModel.toJson());
  }

//firebase authentication
  static Future<UserModel> registerUser(
      {required String email,
      required String password,
      required String name}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel userModel =
        UserModel(email: email, name: name, uId: userCredential.user!.uid);
    await addNewUser(userModel);
    return userModel;
  }

  static CollectionReference<UserModel> getUsersCollection() {
    CollectionReference<UserModel> usersCollection =
        FirebaseFirestore.instance.collection('Users').withConverter<UserModel>(
              fromFirestore: (snapshot, options) =>
                  UserModel.fromJson(snapshot.data() ?? {}),
              toFirestore: (value, options) => value.toJson(),
            );
    return usersCollection;
  }

  static Future<void> addNewUser(UserModel user) async {
    CollectionReference<UserModel> usersCollection = getUsersCollection();
    DocumentReference<UserModel> document = usersCollection.doc(user.uId);
    await document.set(user);
  }

  static Future<UserModel?> loginUser(
      {required String email, required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (userCredential.user?.uid != null) {
      UserModel? userModel = await getUserInfo(userCredential.user!.uid);
      return userModel;
    }
    return null;
  }

  static Future<UserModel?> getUserInfo(String uid) async {
    CollectionReference<UserModel> usersCollection = getUsersCollection();
    DocumentSnapshot<UserModel> document = await usersCollection.doc(uid).get();
    return document.data();
  }

//login with google
  static Future<User?>? signInWithGoogle() async {
    GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();
    if (googleAccount == null) return null;
    GoogleSignInAuthentication googleAuthentication =
        await googleAccount.authentication;
    OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken);
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    UserModel userModel = UserModel(
        email: googleAccount.email,
        name: googleAccount.displayName ?? 'no name',
        uId: FirebaseAuth.instance.currentUser?.uid??'');
    await addNewUser(userModel);

    return userCredential.user;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
