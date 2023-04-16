# docker-mopidy
Very simple docker image for extensible music server [Mopidy](https://mopidy.com).  
The image is based on python3/debian-slim and installs Mopidy, together with the below listed extensions, according to the [official documentation](https://docs.mopidy.com/en/release-2.2/installation/debian).  
  
Using a GitHub workflow, the image is created and published weekly.


## Included extensions
Music sources:
- Mopidy-GMusic
- Mopidy-MPD
- Mopidy-Local
- Mopidy-Pandora
- Mopidy-RadioNet
- Mopidy-SoundCloud
- Mopidy-Spotify
- Mopidy-TuneIn
- Mopidy-YouTube

WebUIs:
- Mopidy-Iris
- Mopidy-Moped

## Usage
Create your configuration file and mount it to `/config/mopidy.conf`.
A guide how to create the configuration file can be found here: [https://docs.mopidy.com/en/latest/config/](https://docs.mopidy.com/en/latest/config/).
  
Startup example:
```bash
# Without port forwarding
docker run --rm --name mopidy -v $(pwd)/mopidy.conf:/config/mopidy.conf:ro ghcr.io/firefrei/mopidy

# With port forwarding
... -p 6600:6600 -p 6680:6680 -p 5555:5555/udp ... 
```
