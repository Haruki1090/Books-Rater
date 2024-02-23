const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.addBookToAllUsersBooks = functions.firestore
    .document("users/{userId}/books/{bookId}")
    .onCreate((snap, context) => {
      const newBookData = snap.data();
      return admin.firestore().collection("allUsersBooks")
          .add(newBookData)
          .then((docRef) => {
            console.log("Document written with ID: ", docRef.id);
          }).catch((error) => {
            console.error("Error adding document: ", error);
          });
    });
