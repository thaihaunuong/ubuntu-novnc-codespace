#!/bin/bash

echo "Running setup script for VNC and NoVNC..."

# Create a VNC password (can be hardcoded for convenience in a demo, but insecure for production)
# For a real scenario, consider setting this securely or dynamically.
# We'll set it to 'password' for simplicity here.
mkdir -p ~/.vnc
echo "password" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Configure xstartup for XFCE
cat <<EOF > ~/.vnc/xstartup
#!/bin/bash
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

# Start VNC Server on display :1 (port 5901)
echo "Starting VNC server..."
vncserver :1 -geometry 1280x720 -depth 24

# Start websockify (NoVNC proxy) on port 6080
echo "Starting websockify (NoVNC proxy)..."
websockify 6080 localhost:5901 &

echo "VNC and NoVNC setup complete. Access via forwarded port 6080."
echo "You might need to wait a few seconds for XFCE to fully load."