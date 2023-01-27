docker build -t ranaivoson0/multi-client:latest -t ranaivoson0/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ranaivoson0/multi-server:latest -t ranaivoson0/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ranaivoson0/multi-worker:latest -t ranaivoson0/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ranaivoson0/multi-client:latest
docker push ranaivoson0/multi-server:latest
docker push ranaivoson0/multi-worker:latest

docker push ranaivoson0/multi-client:$SHA
docker push ranaivoson0/multi-server:$SHA
docker push ranaivoson0/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ranaivoson0/multi-server:$SHA
kubectl set image deployments/client-deployment server=ranaivoson0/multi-client:$SHA
kubectl set image deployments/worker-deployment server=ranaivoson0/multi-worker:$SHA