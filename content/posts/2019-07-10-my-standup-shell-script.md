---
layout: post
title: My standup Shell Script
description: "A Shell Script I use to document my day to day at Teamwork"
tags: [terminal, standups]
date: 2019-07-10
---

At Teamwork’s Mobile Team we hold a Standup meeting every day, at 11:00 AM Irish Time. That’s Noon for me, here in Spain. And more than a Standup is a “Status Update” to let other members of the Mobile sub-teams know roughly what I’m doing and if I have some errand to run, or won’t be available for several hours, etc. It's also a good way to keep the connection with the rest of the team. Something specially important when you work 100% remotely from home.

Since my 1st day at Teamwork I got into the habit of writing the bullet points of my standup status update in a Markdown document. This way I just read instead of remembering and stuttering through the _Virtual Meeting Software Of Choice_. Also, it serves as a handy diary with _everything_ I’ve been doing.

![Visual Studio Code showing a preview of my standup document](/img/standup-script.png)

But you know: each day, open that doc. Add a new section with what I’ve done yesterday and what I want to do today. Fill those. Open the browser. Go to the meeting URL... too much effort. I needed something easier and with less friction. So I decided to write a small script that does all of the above... and a bit more. Right now it even adds the date, the weather at  my location and takes a picture using my MBP’s webcam. 

You can grab the script in this [Github Gist](https://gist.github.com/dfreniche/21425d7d911dcca89873e76c7776ad09). As always, save it as `standup.sh`, give it execute permissions `chmod a+x standup.sh` and run it with `./standup.sh` (or put it in your $PATH).

To take the photo using your web cam you'll need to install [imagesnap](https://github.com/rharder/imagesnap) with `brew install imagesnap`.

If you're too lazy to click on the link above, here is also the script:

```bash
#!/bin/bash

SU_DATE="## `date "+%d %m %Y (%a)"`"
SU_TEXT1="Yesterday:"
SU_TEXT2="Today:"
SU_TEXT3="---"

# weather info
SU_WEATHER=`curl 'wttr.in/Sevilla?format=3'`

SU_DIR=~/Teamwork/daily-standups
IMG_FILE=$SU_DIR/img/`date "+%Y-%m-%d"`.jpg 

# Add link to that capture in standup file
MD_IMG="![]($IMG_FILE)"

echo "$(echo $MD_IMG; echo $SU_DATE; echo ""; echo $SU_WEATHER; echo ""; echo $SU_TEXT1; echo ""; echo ""; echo $SU_TEXT2; echo ""; echo ""; echo $SU_TEXT3; echo ""; cat $SU_DIR/standup.md)" > $SU_DIR/standup.md

open -a /Applications/Visual\ Studio\ Code.app $SU_DIR/standup.md

# Open Meet (sadly only works properly with Chrome)
open https://meet.google.com/YOUR-MEETING-LINK_HERE -a /Applications/Google\ Chrome.app

# Photo capture
imagesnap -q -w 5 $IMG_FILE
```