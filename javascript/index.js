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
