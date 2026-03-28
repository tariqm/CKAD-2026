#!/bin/bash
set -euo pipefail
echo "=== Q5 Setup: Build Container Image with Podman ==="

mkdir -p /root/app-source

cat > /root/app-source/Dockerfile << 'DOCKERFILE'
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
DOCKERFILE

cat > /root/app-source/index.html << 'HTML'
<!DOCTYPE html>
<html>
<head><title>My App</title></head>
<body><h1>Hello from my-app:1.0</h1></body>
</html>
HTML

echo "✅ Q5 setup complete. /root/app-source contains a valid Dockerfile."
