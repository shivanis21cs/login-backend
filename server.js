const express = require("express");
const cors = require("cors");
const app = express();

// Use PORT from Render environment, fallback to 3000 for local testing
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Allowed users — exact values
const allowedUsers = [
  { email: "user2@gmail.com", password: "pass234" },
  { email: "test@gmail.com", password: "12345" },
  { email: "test@gmail.com", password: "123458" },
  { email: "user3@gmail.com", password: "mypwd789" }
];

app.get("/", (req, res) => {
  res.send("✅ Backend is running on Render!");
});

app.post("/login", (req, res) => {
  const { email, password } = req.body;

  console.log("📩 Received:", email, password);

  const user = allowedUsers.find(u => u.email === email && u.password === password);

  if (user) {
    console.log("✅ Match found for:", email);
    return res.json({ success: true, message: "Login successful!", role: "player" });
  } else {
    console.log("❌ Invalid credentials:", email, password);
    return res.status(401).json({ success: false, message: "Invalid email or password" });
  }
});

// Important: Use 0.0.0.0 for external access
app.listen(PORT, "0.0.0.0", () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
