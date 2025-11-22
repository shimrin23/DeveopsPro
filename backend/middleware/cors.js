const cors = require('cors');

const corsOptions = {
  origin: ['http://localhost:3000', 'http://localhost:5001','http://13.233.127.34:3000'],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization']
};

module.exports = cors(corsOptions);