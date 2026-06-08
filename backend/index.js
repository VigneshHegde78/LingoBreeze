const express = require("express");
const cors = require("cors");
const admin = require("firebase-admin");

// 1. Hook up Firebase Keys
const serviceAccount = require("./serviceAccountKey.json");
admin.initializeApp({
	credential: admin.credential.cert(serviceAccount),
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
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
	console.log(`Server is running on http://localhost:${PORT}`);
});
