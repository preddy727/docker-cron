# docker-cron
An example of running cron job to schedule scale out and scale rules on horizontal pod scaler in a docker container

# Prereqs
Deploy a private aks cluster and sample front door voting application 
https://github.com/preddy727/aksprivatecluster


# Create docker image with azure cli, aks credentials and crontab for HPA patching 
```cli 

git clone https://github.com/preddy727/docker-cron
cd docker-cron
docker build --rm -t preddy727/docker-cron .
docker run -it preddy727/docker-cron test .

#Publish image and push to acr 

sudo az acr login --name $MYACR
az acr list --resource-group $AKS_PE_DEMO_RG --query "[].{acrLoginServer:loginServer}" --output table
sudo docker tag azure-crontab preastus2mycontainerregistry.azurecr.io/azure-crontab:v1
sudo docker push preastus2mycontainerregistry.azurecr.io/azure-crontab:v1
az acr repository list --name $MYACR --output table

# Create a yaml file called azure-crontab.yaml 

containers:
- name: azure-crontab
  image: <acrName>.azurecr.io/azure-vote-front:v1
  
# Deploy the container 

kubectl apply -f azure-crontab.yaml

# Configure autoscaling for crontab container
kubectl autoscale deployment azure-crontab --cpu-percent=50 --min=3 --max=10





```

