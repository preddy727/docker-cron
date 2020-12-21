FROM microsoft/azure-cli

#Install AKS cli
RUN az aks install-cli
RUN az aks get-credentials --resource-group preastus2-aksdemo-rg --name preastus2-aksdemo-aks
#CMD kubectl autoscale deployment azure-vote-front --cpu-percent=50 --min=3 --max=10


# Add crontab file in the cron directory
ADD crontab /etc/cron.d/hello-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/hello-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

#Install Cron
RUN apt-get update
RUN apt-get -y install cron


# Run the command on container startup
CMD cron && tail -f /var/log/cron.log


