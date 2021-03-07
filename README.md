# lnd-channel-backup-2-mail
This script watches the LND data folder and sends out emails with the channel backup on changes.

## Dependencies

### Install mail
`sudo apt-get install mailutils inotifywait`

**Configure mail**
`sudo nano /etc/mailname` and add your "domain name" e.g. `raspberrypi`

**Send test email**
`echo "Test" | mail -s "Test" your@email.com`

## Set it up as a service

- Create a service file
    `sudo nano /etc/systemd/system/backup-channels.service`
    Content:
    ```
    [Service]
    ExecStart=/PATH/TO/copy-channel-backup-on-change.sh
    Restart=always
    RestartSec=60s
    StandardOutput=syslog
    StandardError=syslog
    SyslogIdentifier=backup-channels
    User=USER

    [Install]
    WantedBy=multi-user.target
    ```

- rename /PATH/TO the the location of shell script
- replace USER with actual user

- start and enable service
    `sudo systemctl enable backup-channels.service`
    `sudo systemctl start backup-channels.service`

## Options

The script contains 3 important variables `EMAIL`, `PATHTOLND`, `PATHTOTMP`

**EMAIL**: your email address

**PATHTOLND** (default: /home/lightning/.lnd/): the path to your LND data folder

**PATHTOTMP** (default: /home/lightning/tmp/): the path to folder to temporary store the channel backups
