
# serverpod
docker compose up -d
serverpod generate --experimental-features=all
dart bin/main.dart --apply-migrations
serverpod create-migration --experimental-features=all

docker compose down -v

#kubernaties

[Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes('yg4E>\O$eV{2iB'))

# Проверим поды
kubectl get pods
kubectl get pods -w

# Проверим сервисы
kubectl get svc
kubectl get svc ts2-server-service -o yaml 

# логи приложения
kubectl logs -f -l app=ts2-server


# Тестируем endpoint для получения списка TestData
Invoke-WebRequest -Uri "https://api5.my-points.ru/" -Method POST -ContentType "application/json" -Body '{"endpoint":"testData","method":"listTestDatas","params":{}}'

# Проверка доступности напрямую
Invoke-WebRequest -Uri "https://api5.my-points.ru/" -Method GET

# Проверим детали Ingress:
bashkubectl describe ingress sync2-server-ingress

docker login dbe81550-wise-chickadee.registry.twcstorage.ru
docker build -t dbe81550-wise-chickadee.registry.twcstorage.ru/ts2-server:latest -f Dockerfile.prod .
docker push dbe81550-wise-chickadee.registry.twcstorage.ru/ts2-server:latest


kubectl apply -f k8s/

kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/job.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/secret.yaml


#delete project
kubectl delete -f k8s/

kubectl delete service ts2-server-service
kubectl delete ingress ts2-server-ingress
kubectl delete configmap serverpod-config-ts2
kubectl delete job serverpod-migration-job-ts2
kubectl delete secret serverpod-secrets-ts2
kubectl delete deployment ts2-server-deployment

#restart deployment
kubectl rollout restart deployment ts2-server-deployment

kubectl create secret generic serverpod-secrets-ts2 --from-literal=database-password='yg4E>\O$eV{2iB' --from-literal=redis-password='M/4TbocWi_UG/{' --from-literal=service-secret='MBuPQvx15_eUU8lkkveQybi-aLrscxOz'