# lnd-mobile-docker
Create lnd mobile libraries using docker

## Usage
`docker build -t lnd-mobile .`

```
docker run \
	-v <ANDROID_NDK_HOME>:/ndk \
	-v <ANDROID_HOME>:/android \
	-v <OUTPUT_DIRECTORY>:/generated \
	lnd-mobile
```
