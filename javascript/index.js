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

exports.deleteFromAllUsersBooks = functions.firestore
    .document("users/{userId}/books/{bookId}")
    .onDelete((snap, context) => {
      const bookId = context.params.bookId; // 削除されたドキュメントのbookIdを取得
      // allUsersBooksコレクションからbookIdが一致するドキュメントを検索して削除
      return admin.firestore().collection("allUsersBooks")
          .where("bookId", "==", bookId)
          .get()
          .then((snapshot) => {
            const deletions = [];
            snapshot.forEach((doc) => {
              deletions.push(doc.ref.delete()); // 各ドキュメントを削除
            });
            return Promise.all(deletions); // すべての削除操作を同時に実行
          })
          .catch((error) => console.error(
              "Error deleting matching documents:",
              error,
          ));
    });

exports.incrementBookCount = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
        "unauthenticated",
        "The function must be called while authenticated.",
    );
  }

  const userId = data.userId;
  const userRef = admin.firestore().collection("users").doc(userId);

  try {
    await admin.firestore().runTransaction(async (transaction) => {
      const userDoc = await transaction.get(userRef);
      if (!userDoc.exists) {
        throw new functions.https.HttpsError("not-found", "User not found");
      }
      const userData = userDoc.data();
      const bookCount = (userData.bookCount || 0) + 1;
      transaction.update(userRef, {bookCount: bookCount});
    });
    return {success: true};
  } catch (error) {
    throw new functions.https.HttpsError(
        "internal",
        "Failed to increment book count",
    );
  }
});

exports.decrementBookCount = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
        "unauthenticated",
        "The function must be called while authenticated.",
    );
  }

  const userId = data.userId;
  const userRef = admin.firestore().collection("users").doc(userId);

  try {
    await admin.firestore().runTransaction(async (transaction) => {
      const userDoc = await transaction.get(userRef);
      if (!userDoc.exists) {
        throw new functions.https.HttpsError("not-found", "User not found");
      }
      const userData = userDoc.data();
      const bookCount = (userData.bookCount || 0) - 1;
      transaction.update(userRef, {bookCount: bookCount > 0 ? bookCount : 0});
    });
    return {success: true};
  } catch (error) {
    throw new functions.https.HttpsError(
        "internal",
        "Failed to decrement book count",
    );
  }
});

