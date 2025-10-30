const express = require("express");
const app = express();
const cors = require("cors");
const PORT = 3000;

app.use(cors());
app.use(express.json());

// Allowed users — exact values
const allowedUsers = [
  { email: "user2@gmail.com", password: "pass234" },
  { email: "test@gmail.com", password: "12345" },
  { email: "test@gmail.com", password: "123458" },
  { email: "user3@gmail.com", password: "mypwd789" }
];

app.post("/login", (req, res) => {
  const { email, password } = req.body;

  // DEBUG logs (important)
  console.log("📩 Received from client:");
  console.log("Email:", `"${email}"`);
  console.log("Password:", `"${password}"`);

  const user = allowedUsers.find(u => u.email === email && u.password === password);

  if (user) {
    console.log(" Match found for:", email);
    // respond 200 with JSON
    return res.json({ success: true, message: "Login successful!", role: "player" });
  } else {
    console.log(" Invalid credentials:", email, password);
    // respond 401 but include JSON body (so client can read message)
    return res.status(401).json({ success: false, message: "Invalid email or password" });
  }
});

// IMPORTANT: bind to 0.0.0.0 so other devices on LAN can reach it
app.listen(PORT, "0.0.0.0", () => {
  console.log(`🚀 Server running on http://localhost:${PORT} (listening on 0.0.0.0)`);
});
