docker build -t swiftbunnymike/multi-client:latest -t swiftbunnymike/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t swiftbunnymike/multi-server:latest -t swiftbunnymike/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t swiftbunnymike/multi-worker:latest -t swiftbunnymike/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push swiftbunnymike/multi-client:latest
docker push swiftbunnymike/multi-server:latest
docker push swiftbunnymike/multi-worker:latest

docker push swiftbunnymike/multi-client:$SHA
docker push swiftbunnymike/multi-server:$SHA
docker push swiftbunnymike/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=swiftbunnymike/multi-server:$SHA
kubectl set image deployments/client-deployment client=swiftbunnymike/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=swiftbunnymike/multi-worker:$SHA
