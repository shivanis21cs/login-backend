// server.js
const express = require("express");
const cors = require("cors");
const mongoose = require("mongoose");

const app = express();

// ✅ Middleware
app.use(cors());
app.use(express.json());

// ✅ MongoDB connection (optional - comment out if not using MongoDB)
mongoose.connect("mongodb://localhost:27017/demo", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => console.log("✅ MongoDB Connected"))
.catch(err => console.log("❌ MongoDB Error:", err));

// ✅ Default route to check if server is running
app.get("/", (req, res) => {
  res.send("✅ Backend is running successfully!");
});

// ✅ Dummy login route (replace later with real DB logic)
app.post("/login", (req, res) => {
  const { email, password } = req.body;
  if (email === "test@gmail.com" && password === "12345") {
    res.json({ success: true, message: "Login successful!" });
  } else {
    res.json({ success: false, message: "Invalid email or password" });
  }
});

// ✅ Start server
const PORT = 3000;
app.listen(PORT, "0.0.0.0", () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
