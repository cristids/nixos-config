#!/usr/bin/env bash

# SDDM Startup Troubleshooting Script
# Run this script to collect diagnostic information

echo "=== NixOS SDDM Startup Troubleshooting ==="
echo "Timestamp: $(date)"
echo

echo "=== System Boot Analysis ==="
systemd-analyze 2>/dev/null || echo "systemd-analyze not available"
echo

echo "=== Slowest Services ==="
systemd-analyze blame 2>/dev/null | head -10 || echo "blame analysis not available"
echo

echo "=== User Session Analysis ==="
systemd-analyze --user 2>/dev/null || echo "User session analysis not available"
echo

echo "=== Enabled User Services ==="
systemctl --user list-unit-files --state=enabled | head -20
echo

echo "=== Display Manager Status ==="
systemctl status display-manager.service --no-pager 2>/dev/null || echo "Display manager status not available"
echo

echo "=== SDDM Service Status ==="
systemctl status sddm --no-pager 2>/dev/null || echo "SDDM status not available"
echo

echo "=== Recent SDDM Logs ==="
journalctl -u sddm -n 20 --no-pager 2>/dev/null || echo "SDDM logs not available"
echo

echo "=== Wayland Sessions Available ==="
ls -la /run/current-system/sw/share/wayland-sessions/ 2>/dev/null || echo "Wayland sessions directory not found"
echo

echo "=== X11 Sessions Available ==="
ls -la /run/current-system/sw/share/xsessions/ 2>/dev/null || echo "X11 sessions directory not found"
echo

echo "=== Graphics Driver Info ==="
lspci | grep -E "(VGA|3D|Display)"
echo

echo "=== Memory Usage ==="
free -h
echo

echo "=== Disk Usage ==="
df -h | grep -E "(/$|/nix/store)"
echo

echo "=== Running Processes (top 10 by memory) ==="
ps aux --sort=-%mem | head -11
echo

echo "=== Environment Variables ==="
echo "XDG_SESSION_TYPE: $XDG_SESSION_TYPE"
echo "XDG_CURRENT_DESKTOP: $XDG_CURRENT_DESKTOP"
echo "WAYLAND_DISPLAY: $WAYLAND_DISPLAY"
echo "DISPLAY: $DISPLAY"
echo

echo "=== Troubleshooting Complete ==="
echo "Save this output and check for:"
echo "1. Services taking >5 seconds to start"
echo "2. Failed or slow user services"
echo "3. Graphics driver issues"
echo "4. High memory/disk usage"
echo "5. Missing session files"
