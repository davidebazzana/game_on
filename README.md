# Game-on

### Description
Game-on is a web platform that allows you to play and share games. In fact, as a registered user of the site, you can both play other people's games and write your own and then share them on the platform. Registered users can express their opinion on the available games by adding comments or assigning a like or dislike. Each user can also create a list of their favorite games which constitutes a collection of the ones they liked the most. Finally, the platform offers the possibility for users to interact with each other. The user can in fact follow and be followed by other users.

### Dependencies

This application needs both ClamAV and ClamAV Daemon to run. 

To install them, run:
`sudo apt-get install clamav clamav-daemon`

If you get the error: `ERROR: could not connect to clamd on LocalSocket /var/run/clamav/clamd.ctl: No such file or directory`
then run the following commands:
```
sudo systemctl stop clamav-daemon.service
sudo rm /var/log/clamav/freshclam.log
sudo systemctl start clamav-daemon.service
```

### Team:
- Davide Bazzana
- Giacomo Colizzi Coin
- Renato Giamba
