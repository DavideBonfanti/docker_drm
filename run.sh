#!/bin/bash

# Run Docker container
docker run -d --name dell-drm --tmpfs /tmp -p 8091:8091 dell-drm:3.4.8

# Wait DRM startup then open web browser
echo Wait about 30 seconds then open https://localhost:8091/drm/ ...
sleep 30
open https://localhost:8091/drm/ &
