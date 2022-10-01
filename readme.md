# VidHop Linux

## Description

Download videos, channels, playlists, music and thumbnails from any video platform on Linux.

VidHop stores metadata of the video files you process as JSON files, metadata through which you can easily search.

VidHop is like a Swiss knife for anyone interested in saving audiovisual content from the internet.

VidHop for Linux also exists. Sync functionality is built-in on both Linux and Android versions of VidHop though that 
requires a working SSH connection between laptop and phone.

A port for Windows is another idea.

### Videos

[An Introduction to VidHop](https://odysee.com/@WTechGo:e/Introduction-to-VidHop:0)

[Installing VidHop form Scratch](https://odysee.com/@WTechGo:e/Install-VidHop-from-Scratch:c)

[Sync VidHop between laptop and phone](https://odysee.com/@WTechGo:e/sync-vidhop-between-laptop-and-phone:1)

## Installation

1. Open Termux and paste this command.

    ```   
       curl -sL https://raw.githubusercontent.com/wtechgo/vidhop-linux/master/install.sh > install.sh && 
       chmod +x install.sh && ./install.sh && rm install.sh && . $HOME/.bashrc && . vidhop
    ```   

4. Check if it works: download a video and play it !

    ```
       dlv https://www.youtube.com/watch?v=-DT7bX-B1Mg && ls -l && sleep 3 && play
     ```

## Functional Information

VidHop enables Linux users to download videos, songs, thumbnails, complete channels and playlists from popular video
platforms to their workstation.

Each download also saves the video **metadata** and its thumbnail (video banner image). When users download a channel or
playlist, the same happens for each video while also saving channel metadata. It's also possible to fetch **only** the
metadata of a video, channel or playlist.

**The metadata is what makes application powerful** as VidHop provides functions for users to query their collected metadata
using search words or sentences. Effectively, VidHop will look for the search word in video titles and descriptions
though the metadata contains other useful data like video, channel and thumbnail URLs. File extensions include mp4 (
video), json (metadata) and jpg (thumbnails).

Finally, VidHop provides many utilities for day-to-day use such as keeping a history, renaming of downloaded files,
inspect video specs of files and URLs, remove the last download or play it...

## Technical Information

VidHop is in essence a collection of bash scripts users load in terminal via `.bashrc` or by calling the loader
`. vidhop` or `source vidhop` or another shell (also tested on zsh).

VidHop uses [YT-DLP](https://github.com/yt-dlp/yt-dlp) (written in Python) for downloading videos and metadata.
`install.sh` also installs FFmpeg for converting YT-DLP downloads when necessary.

Handling metadata JSON files happens with [JQ](https://github.com/stedolan/jq).

Finally, VidHop (`install.sh`) installs a bunch of useful packages
like `openssh, rsync, mediainfo, selenium and beautifulsoup4 (for scraping channel avatar images) and tor, proxychains-ng (for dealing with censored videos)`
.

## Commands

Output from command `vidhophelp`

To see some of these commands in action, watch [An Introduction to VidHop](https://odysee.com/@WTechGo:e/Introduction-to-VidHop:0).

```
 Title: dlv
 Description: Download video(s) and channels.
 Commands:
    dlv <URL>     => download video at <URL> plus information (metadata, thumbnail)
    dlvi <URL>    => download video information only at <URL>, no mp4 download
    dlvpl <URL>   => download video playlist
    dlvpli <URL>  => download video playlist information
    dlc <URL>     => download channel, all videos, metadata and thumbnails
    dlci <URL>    => download channel information, same as dlc but no video downloads
    dla <URL>     => download audio, as mp3 from music videos
    dlalbum <URL> => download a music album as mp3
    dlapl <URL>   => download audio playlist
    dlapli <URL>  => download audio playlist information
    dlpod <URL>   => download podcast, technically also audio but we differentiate podcasts from music
    dlt <URL>     => download thumbnail, as jpg

 Title: fvid
 Description: Searches for <SEARCH_WORD> in all videos and channels metadata.
 Commands:
    fvid <SEARCH_TEXT>  => find videos where title or description matches <SEARCH_TEXT> in all videos and channels metadata
    fvidv <SEARCH_TEXT> => find videos where title or description matches <SEARCH_TEXT> in all videos metadata (shorter search time)
    fvidf <SEARCH_TEXT> => find videos where title or description matches <SEARCH_TEXT> in all video files on disk
    fvidc <SEARCH_TEXT> => find videos where title or description matches <SEARCH_TEXT> in all channels metadata
    fvidcv <CHANNEL_NAME> <SEARCH_TEXT> => find videos where title or description matches <SEARCH_TEXT> in channel with a name that matches <CHANNEL_NAME in a channels metadata
    fvidcv <CHANNEL_NAME> <SEARCH_TEXT> <PLATFORM> => find videos where title or description matches <SEARCH_TEXT> in channel with a name that matches <CHANNEL_NAME in a channels metadata for <PLATFORM> e.g youtube
    fvidusermeta <SEARCH_TEXT>  => find videos where user added metadata contains <SEARCH_TEXT>, execute 'metadata_help' for more information.
    chani <CHANNEL_NAME> => channel information, lists all videos of a channel with name matching <CHANNEL_NAME>
    chani <CHANNEL_NAME> <PLATFORM> => channel information, lists all videos of a channel with name matching <CHANNEL_NAME> with platform matching <PLATFORM>

 Title: files
 Description: Manage VidHop files.
 Commands:
    play                            => play last downloaded video in default media player (MPV recommended)
    play <PARTIAL_FILENAME>         => play video with filename that matches <PARTIAL_FILENAME> in default media player (MPV recommended)
    renvid <PARTIAL_OLD_FILENAME> <NEW_FILENAME>  => rename all files of a video that matches <PARTIAL_OLD_FILENAME>
    renlast <NEW_FILENAME>          => rename all files of last downloaded video to <NEW_FILENAME>
    rmvid <PARTIAL_FILENAME>        => remove all files of a video who's name matches <PARTIAL_FILENAME>
    rmlast                          => remove all files of last downloaded video
    rmchan <PARTIAL_CHANNEL_NAME>   => remove all files of a channel that matches <PARTIAL_CHANNEL_NAME>
    metadata                        => remove all files of a channel that matches <PARTIAL_CHANNEL_NAME>
    metadata <FILE_ABS_PATH>        => remove all files of a channel that matches <PARTIAL_CHANNEL_NAME>
    metadata <PARTIAL_CHANNEL_NAME> => remove all files of a channel that matches <PARTIAL_CHANNEL_NAME>
    specs                           => shows technical video information like codecs, resolution...of last downloaded video
    specs <URL>                     => shows technical video information like codecs, resolution...of a video at <URL>
    specs <PARTIAL_FILENAME>        => shows technical video information like codecs, resolution...of a video who's filename matches <PARTIAL_FILENAME>

 Title: metadata
 Description: Edit the metadata of downloads.
 Commands:
    setdescription <your_description> => Set a description in the metadata JSON file.
    setsummary <your_summary>         => Set a summary in the metadata JSON file.
    setcategories <your_categories>   => Set categories in the metadata JSON file.
    settopics <your_topics>           => Set topics in the metadata JSON file.
    setspeakers <your_speakers>       => Set speakers in the metadata JSON file.
    setcreators <your_creators>       => Set creators in the metadata JSON file.
    rmdescription <your_description>  => Remove a description in the metadata JSON file.
    rmsummary <your_summary>          => Remove a summary in the metadata JSON file.
    rmcategories <your_categories>    => Remove categories in the metadata JSON file.
    rmtopics <your_topics>            => Remove topics in the metadata JSON file.
    rmspeakers <your_speakers>        => Remove speakers in the metadata JSON file.
    rmcreators <your_creators>        => Remove creators in the metadata JSON file.

 Title: history
 Description: Show history of actions in VidHop.
 Commands:
    vhistory => shows the history of the videos you or metadata download
    chistory => shows the history of the channels you or metadata download
    ahistory => shows the history of the audio you or metadata download
    phistory => shows the history of the podcasts you or metadata download
    thistory => shows the history of the thumbnails you or metadata download

 Title: sync
 Description: Sync files between phone and workstation.
 Commands:
    syncvidhop  => fetch VidHop files from phone to workstation and send files from workstation to phone
    sendvidhop  => send files from workstation to phone
    fetchvidhop => fetch VidHop files from phone to workstation
```

## Sync

Phones have limited storage so users will want to transfer their downloads from their phone to their computer.

Moreover, metadata collected on the computer has to be copied to the phone so users can query their video library 
while on the move.

VidHop provides command `syncvidhop` for this scenario though SSH has to be configured such that laptop and phone can 
establish an SSH connection.

Note: Configuring VidHop Sync is not required for downloading videos, channels, metadata etc. to work.

### Configuration

For explanation purposes, we'll use the scenario of syncing between laptop and phone (bi-directional).

If you ran `install.sh`, `openssh` (SSH) and rsync have already been installed in Termux. However, you might not have 
installed these packages on your laptop. If not, install them.

The easiest way to go about this, is to establish an SSH connection from laptop to phone first, to avoid typing on the phone. 
**Termux SSH requires RSA keys**.

#### Overview

Let's first consider an overview of how to configure SSH. The next chapter goes into detail.

- Generate SSH keys on laptop.
- Copy laptop public SSH key onto phone.
- Establish an initial SSH connection from laptop to phone and **accept the device fingerprint**.
- On phone, repeat the 3 previous steps.
- Inform VidHop on laptop of the IP-address and user of phone.
- Inform VidHop on phone of the IP-address and user of laptop.

#### SSH Configuration on Laptop

Note: the instructions below create new SSH keys with as name 'id_vidhop'.

Check that you have SSH installed with `which sshd` or `type sshd`. If not install package `openssh`.

check that you have rsync installed with `which rsync` or `type rsync`. If not install package `rsync`.

For the next steps, we need to get hold of the **user** and **IP-address** of the **phone**. Open Termux on your phone 
and run `sshconfig` (a VidHop function), which will output the information.

```
USER_PHONE="FILL_IN_USER_OF_PHONE"
IP_PHONE="FILL_IN_IP_OF_PHONE"

# Generate RSA keys. To dodge password prompts, leave password empty, just hit enter for each question.
yes | ssh-keygen -t rsa -b 4096 -f id_vidhop

# Copy you public key to phone.
# Make sure `sshd` is running on phone first. Open Termux and run `sshd`.
ssh-copy-id -i "$HOME/.ssh/id_vidhop" -p 8022 $USER_PHONE@$IP_PHONE

# Make an initial SSH connection and accept the the device fingerprint of laptop.
ssh -4 -i "$HOME/.ssh/id_vidhop" -p 8022 $USER_PHONE@$IP_PHONE 
```

If the last command was successful, you are now in Termux which you can verify with command `uname -a`.

#### SSH Configuration on Phone

We recommend you use the SSH connection from the previous part to do the configuration on your phone as doing 
configuration via finger-typing on screens is not particularly pleasant.

```
USER_WS="FILL_IN_USER_OF_WS"
IP_WS="FILL_IN_IP_OF_WS"

# Generate RSA keys. To dodge password prompts, leave password empty, just hit enter for each question.
yes | ssh-keygen -t rsa -b 4096 -f id_vidhop

# Copy you public key to laptop.
# Make sure `sshd` is running on laptop first. Open a terminal and run `systemctl start sshd` (or distro equivalent).
ssh-copy-id -i "$HOME/.ssh/id_vidhop" -p 22 $USER_WS@$IP_WS

# Make an initial SSH connection and accept the the device fingerprint of phone.
ssh -i "$HOME/.ssh/id_vidhop" $USER_WS@$IP_WS
```


#### Inform VidHop of your SSH connection

1. On **Phone**
   - 1.1. Open the sync script in nano editor.
        > nanosync
   
   - 1.2. Replace the placeholders (REPLACE_WITH...) with the IP-address and user of laptop.
      > IP_WS="REPLACE_WITH_YOUR_IP_WS_ADDRESS"  
        USER_WS="REPLACE_WITH_YOUR_USER_WS"
   - 1.3. **Save** the file with CTRL+x, type 'y', press 'enter'
2. On **Laptop** (similar to 1.) 
   - 1.1. Open the sync script in nano editor.
     > nanosync
   
   - 1.2. Replace the placeholders (REPLACE_WITH...) with the IP-address and user of **phone**.
     > IP_WS="REPLACE_WITH_YOUR_IP_WS_ADDRESS"  
       USER_WS="REPLACE_WITH_YOUR_USER_WS"

      To get hold of the **user** and **IP-address** of **phone**,  
      open Termux and run `sshconfig` (sshconfig is a VidHop function).
   - 1.3. **Save** the file with CTRL+x, type 'y', press 'enter'
3. Make sure `sshd` is running on the other device.
    - Start `sshd` on **laptop** with `systemctl start sshd`.  
    - Start `sshd` on **phone** with `sshd`.
4. Run `syncvidhop`
5. Alternatively, you can run `sendvidhop` or `fetchvidhop` for one-directional file sync.

Here are the [Termux docs for configuring SSH](https://wiki.termux.com/wiki/Remote_Access) just in case.

## Censored videos

Censored videos are often still accessible via [Tor browser](https://www.torproject.org/download/). You can still use
VidHop in such scenarios with this workaround. Note `tor` and `proxychains-ng` are already installed if you ran `install.sh`.

1. Install tor. `pkg install tor`
2. Install proxychains-ng. `pkg install proxychains-ng`
3. [**Optional**: [Configure proxychains-ng SOCKs5](https://www.youtube.com/watch?v=ebxUrLIoesE)]
    - 3.1. `nano $prefix/etc/proxychains.conf`. 
    - 3.2. Comment `strict_chain`. 
    - 3.3. Uncomment `dynamic_chain`. 
    - 3.4. Add `socks5 127.0.0.1 9050` under `socks5 127.0.0.1 9050`. 
    - 3.5. I bumped on error for SOCKs5 `WARN: Rejecting SOCKS request for anonymous connection to private address [scrubbed]`.
4. Start Tor. two options.
    - 4.1. Run Tor in the background. `tor &`. Press enter to regain your keyboard after Tor has
   finished loading.
     - 4.2. Run `tor` and switch to another shell session.
     - 4.3. Explanation: when you run Tor it occupies the terminal as a running process which blocks
   interaction with the terminal.
5. Start a new shell session under proxychains-ng. `proxychains4 bash`.
6. Inside the new shell, verify you have another IP-address. `curl ifconfig.me`.
7. Execute a VidHop command e.g. `dlv https://www.youtube.com/watch?v=-DT7bX-B1Mg`.

## Credits

Special thanks to the incredibly awesome projects [YT-DLP](https://github.com/yt-dlp/yt-dlp),
[JQ](https://github.com/stedolan/jq) and [Termux](https://f-droid.org/en/packages/com.termux/).

## Support

<h3>Buy Me A Coffee</h3>
<a href="https://www.buymeacoffee.com/wtechgo">
<img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee - WTechGO" width="150" />
</a>
<h3>Bitcoin</h3>
<a href="https://github.com/wtechgo/vidhop-linux/blob/master/img/qr_bitcoin_wtechgo.png?raw=true">
<img src="https://github.com/wtechgo/vidhop-linux/blob/master/img/qr_bitcoin_wtechgo.png?raw=true" alt="Bitcoin" width="100"/>
</a>
<pre>bc1qkxqz0frjhx6gshm0uc668zx6686xtfsxdm67u3</pre>
<h3>Monero</h3>
<a href="https://github.com/wtechgo/vidhop-linux/blob/master/img/qr_monero_wtechgo.png?raw=true">
<img src="https://github.com/wtechgo/vidhop-linux/blob/master/img/qr_monero_wtechgo.png?raw=true" alt="Monero" width="100" />
</a>
<pre>8BNDojnvwYkacFwztY3XsjefCr28zTDraTgzdFLH8JiL5W4eMjTuHCu57LkCy9UHKHZfGzWDo6ErDYDP4jBK814aG2T8z8c</pre>
