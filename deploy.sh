docker build -t todorradevext351/multi-client:latest -t todorradevext351/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t todorradevext351/multi-server:latest -t todorradevext351/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t todorradevext351/multi-worker:latest -t todorradevext351/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push todorradevext351/multi-client:latest
docker push todorradevext351/multi-server:latest
docker push todorradevext351/multi-worker:latest

docker push todorradevext351/multi-client:$SHA
docker push todorradevext351/multi-server:$SHA
docker push todorradevext351/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=todorradevext351/multi-server:$SHA
kubectl set image deployments/client-deployment client=todorradevext351/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=todorradevext351/multi-worker:$SHA