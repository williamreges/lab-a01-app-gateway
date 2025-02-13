NAME_IMAGE=lab-a01-app-gateway
NAME_REPO=williamreges

./mvnw clean install -Dtest.Skip=true

echo "=== Build Image Version ===="
docker build -t ${NAME_REPO}/${NAME_IMAGE} .


