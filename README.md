# lnd-mobile-docker
Create lnd mobile libraries using docker

## Usage
`docker build -t mobile-api .`

`docker run \
	-v /home/$USER/Android/Sdk/ndk/<NDK_VERSION>:/ndk \
	-v /home/$USER/Android/Sdk:/android \
	-v /home/$USER/work/lnd-mobile-ouput:/generated \
	mobile-api`
