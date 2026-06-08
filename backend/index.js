const express = require("express");
const cors = require("cors");
const admin = require("firebase-admin");
const fs = require("fs");
const path = require("path");

// 1. Hook up Firebase credentials without committing secrets
const serviceAccountPath = process.env.FIREBASE_SERVICE_ACCOUNT_KEY_PATH || path.join(__dirname, "serviceAccountKey.json");

let firebaseCredential;

if (fs.existsSync(serviceAccountPath)) {
	const serviceAccount = JSON.parse(fs.readFileSync(serviceAccountPath, "utf8"));
	firebaseCredential = admin.credential.cert(serviceAccount);
} else {
	firebaseCredential = admin.credential.applicationDefault();
}

admin.initializeApp({
	credential: firebaseCredential,
});

const db = admin.firestore();
const app = express();

// 2. Allow Flutter App to talk to this backend
app.use(cors());
app.use(express.json());

// 3. Create API Endpoint for Flutter App to fetch data
app.get("/words", async (req, res) => {
	try {
		const snapshot = await db.collection("words").get();

		const wordsList = snapshot.docs.map((doc) => doc.data());

		res.status(200).json(wordsList);
	} catch (error) {
		console.error("Error fetching words:", error);
		res.status(500).json({ error: "Failed to fetch words" });
	}
});

// 4. Start the server
const PORT = 3000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`LingoBreeze API is listening at port ${PORT}`);
});