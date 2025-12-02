importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyA8QTmBETFhu7L8ET5GQq18xykTDEkcttg",
  authDomain: "evently-6caf0.firebaseapp.com",
  projectId: "evently-6caf0",
  storageBucket: "evently-6caf0.firebasestorage.app",
  messagingSenderId: "1002735867588",
  appId: "1:1002735867588:web:e52a2d73a386b04dbc9b91",
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});