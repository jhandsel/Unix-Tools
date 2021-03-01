# Set up raspberry pi

## Auto VNC
Create file /usr/lib/systemd/system/vncserver-pi.service containing:
```
[Unit]
Description=VNC Server in Virtual Mode daemon
After=network.target

[Service]
User=pi
Type=forking
ExecStart=/usr/bin/vncserver -geometry 1440x900 :1
ExecStop=/usr/bin/vncserver -kill :1
Restart=on-failure
RestartSec=5
KillMode=process

[Install]
WantedBy=multi-user.target
```

Then run:
```
sudo systemctl daemon-reload
sudo systemctl enable vncserver-pi
sudo reboot
```
Then connect to <hostname>:1 with RealVNC viewer.
