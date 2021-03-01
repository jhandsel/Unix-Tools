# Set up raspberry pi

## Enable VNC
```
sudo raspi-config
```
Navigate to Interfacing Options.

Scroll down and select VNC > Yes.

Then start the server from the command line:
```
vncserver
```

## Auto VNC
Create file  /etc/systemd/system/vncserver.service containing:
```
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=forking
User=pi
PAMName=login
PIDFile=/home/pi/.vnc/%H:1.pid
ExecStartPre=-/usr/bin/vncserver -kill :1 > /dev/null 2>&1
ExecStart=/usr/bin/vncserver -depth 24 -geometry 1280x800 :1
ExecStop=/usr/bin/vncserver -kill :1

[Install]
WantedBy=multi-user.target
```

Then run:
```
sudo systemctl daemon-reload && sudo systemctl enable vncserver@1.service
sudo reboot
```

The cursor may appear as a cross. To correct:
```
cp /etc/vnc/xstartup /etc/vnc/xstartup.custom
```

Then modify the `xsetroot -solid grey` line in `xstartup.custom`:
```
xsetroot -solid grey -cursor_name left_ptr
```

Then connect to <hostname>:1 with RealVNC viewer.
