# my-jdownloader2-headless
An image for JDownloader 2 in headless mode for use with my.jdownloader.org

## Running
Replace the example mail, password and volume paths with your corresponding values

```
docker run \
    -v /your/path/to/config/files:/opt/JDownloader/cfg \
    -v /your/path/to/download/folder:/home/jdownloader/Downloads \
    -e MY_JD_EMAIL='your.mail@example.org' \
    -e MY_JD_PASSWORD='your_password' \
    mcarleio/my-jdownloader2-headless
```
    
## Optional environment variables  
* MY_JD_DEVICENAME

  The device name on my.jdownloader.org
  
* JD_UID

  The UID the jdownloader user should have
  
* JD_GID

  The GID the jdownloader user and group should have 