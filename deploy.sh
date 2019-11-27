docker build -t achliopa/multi-client:latest -t achliopa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t achliopa/multi-worker:latest -t achliopa/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t achliopa/multi-server:latest -t achliopa/multi-server:$SHA -f ./server/Dockerfile ./server
docker push achliopa/multi-client:latest
docker push achliopa/multi-worker:latest
docker push achliopa/multi-server:latest

docker push achliopa/multi-client:$SHA
docker push achliopa/multi-worker:$SHA
docker push achliopa/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=achliopa/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=achliopa/multi-worker:$SHA
kubectl set image deployments/server-deployment server=achliopa/multi-server:$SHA
