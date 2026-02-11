const express = require("express");
require("dotenv").config();
require("./db/conn");
const userRouter = require("./routes/userRoutes");
const stylistRouter = require("./routes/stylistRoutes");
const appointRouter = require("./routes/appointRoutes");
const cors = require('cors');
const path = require("path");

const app = express();
const port = process.env.PORT || 5001;

// Allow requests from your frontend IP
app.use(cors({
  origin: 'http://54.227.156.82', // No trailing slash!
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  credentials: true
}));
app.use(express.json());


app.use("/api/users", userRouter);
app.use("/api/stylist", stylistRouter);
app.use("/api/appointment", appointRouter);

// Health check endpoint
app.get("/", (req, res) => {
  res.send("✅ Backend server is running on port 5001");
});

// Test endpoint that doesn't require auth
app.get("/api/test", (req, res) => {
  res.json({
    status: "ok",
    message: "API is reachable",
    timestamp: new Date().toISOString(),
    headers: req.headers
  });
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
