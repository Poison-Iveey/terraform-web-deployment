#!/bin/bash
set -e

# Log everything
exec > /var/log/install-node.log 2>&1

echo "Updating system..."
apt-get update -y

echo "Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

echo "Node version:"
node -v
npm -v

echo "Creating app directory..."
mkdir -p /opt/nodeapp
cd /opt/nodeapp

echo "Creating Node.js app..."
cat <<EOF > index.js
const http = require('http');

const PORT = 3000;
const HOST = '0.0.0.0';

const server = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello from Node.js running on VM Scale Set\n');
});

server.listen(PORT, HOST, () => {
  console.log(\`Server running at http://\${HOST}:\${PORT}/\`);
});
EOF

echo "Starting Node.js app..."
nohup node index.js &
