# Delete all exited containers

    docker rm -v $(docker ps -q -f status=exited)

# Delete all untagged images

    docker rmi $(docker images -f "dangling=true" -q)

# Delete unused docker volumes
#    cf. https://github.com/docker/docker/pull/14214
