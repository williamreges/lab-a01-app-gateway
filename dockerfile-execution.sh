NAME_IMAGE=lab-a01-app-gateway
NAME_REPO=williamreges

echo "Docker RUN Local Network HOST"
docker run -p 8761:8761 \
--net=host \
--name ${NAME_REPO}/${NAME_IMAGE} \
--rm ${NAME_REPO}/${NAME_IMAGE}

