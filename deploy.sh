docker build -t dsknudsen/multi-client:latest -t dsknudsen/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dsknudsen/multi-server:latest -t dsknudsen/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dsknudsen/multi-worker:latest -t dsknudsen/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dsknudsen/multi-client:latest
docker push dsknudsen/multi-server:latest
docker push dsknudsen/multi-worker:latest
docker push dsknudsen/multi-client:$SHA
docker push dsknudsen/multi-worker:$SHA
docker push dsknudsen/multi-server:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=dsknudsen/multi-client:$SHA
kubectl set image deployments/server-deployment server=dsknudsen/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=dsknudsen/multi-worker:$SHA