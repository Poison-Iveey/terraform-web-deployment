const express = require('express');
const app = express();

// IMPORTANT: port 80 so it matches the Load Balancer
const PORT = 80;

app.get('/', (req, res) => {
  res.send('Hello from Node.js running on VM Scale Set 🚀');
});

app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

app.listen(PORT, () => {
  console.log(`Node app listening on port ${PORT}`);
});
