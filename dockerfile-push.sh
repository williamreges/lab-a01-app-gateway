VERSION=V2
NAME_IMAGE=lab-a01-app-gateway
NAME_REPO=williamreges


echo "=== Tag Image ===="
docker tag ${NAME_REPO}/${NAME_IMAGE} ${NAME_REPO}/${NAME_IMAGE}:${VERSION}

echo "=== PUSH version==="
docker push ${NAME_REPO}/${NAME_IMAGE}:${VERSION}

echo "=== PUSH Latest==="
docker push ${NAME_REPO}/${NAME_IMAGE}