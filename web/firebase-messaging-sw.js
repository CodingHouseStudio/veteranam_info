// Please see this file for the latest firebase-js-sdk version:
// https://github.com/firebase/flutterfire/blob/master/packages/firebase_core/firebase_core_web/lib/src/firebase_sdk_version.dart
importScripts("https://www.gstatic.com/firebasejs/10.11.1/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.11.1/firebase-messaging-compat.js");


const firebaseConfigProd = {
    apiKey: "AIzaSyAWXzOYOBDQXFlU6Gp_8BYyvk5_L9Ev3dU",
    authDomain: "veteran-production.firebaseapp.com",
    projectId: "veteran-production",
    storageBucket: "veteran-production.appspot.com",
    messagingSenderId: "326120302123",
    appId: "1:326120302123:web:2e7f57b9f1be4c39edac6e",
    measurementId: "G-5K1QYSG097"
};

const firebaseConfigDev = {
    apiKey: "AIzaSyBEyjiJOQxksq81cI865BN4T28i-P1gGGo",
    authDomain: "veteran-development.firebaseapp.com",
    projectId: "veteran-development",
    storageBucket: "veteran-development.appspot.com",
    messagingSenderId: "32851885972",
    appId: "1:32851885972:web:c0d9869836ece62aecd981",
    measurementId: "G-76WYC6VSWT"
};

try {
    // Перший набір конфігурацій
    firebase.initializeApp(firebaseConfigProd);
    console.log("Firebase initialized with Production.");
} catch (error) {
    console.error("Prod config initialization failed:", error);
    firebase.initializeApp(firebaseConfigDev);
    console.log("Firebase initialized with Development.");
}


const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
});
