// Please see this file for the latest firebase-js-sdk version:
// https://github.com/firebase/flutterfire/blob/master/packages/firebase_core/firebase_core_web/lib/src/firebase_sdk_version.dart
importScripts("https://www.gstatic.com/firebasejs/10.11.1/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.11.1/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: "AIzaSyAWXzOYOBDQXFlU6Gp_8BYyvk5_L9Ev3dU",
    authDomain: "veteran-production.firebaseapp.com",
    projectId: "veteran-production",
    storageBucket: "veteran-production.appspot.com",
    messagingSenderId: "326120302123",
    appId: "1:326120302123:web:2e7f57b9f1be4c39edac6e",
    measurementId: "G-5K1QYSG097"
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
});
