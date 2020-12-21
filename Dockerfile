FROM ubuntu

#Install AKS cli
RUN apt-get update -y
RUN apt-get install curl wget sudo -y
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
RUN az aks install-cli
RUN az login
RUN az aks get-credentials --resource-group preastus2-aksdemo-rg --name preastus2-aksdemo-aks
#RUN kubectl autoscale deployment azure-vote-front --cpu-percent=50 --min=3 --max=10


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
#CMD cron && tail -f /var/log/cron.log
CMD echo "starting" && echo "continuing" && (cron) \
 && echo "tailing..." && : >> /var/log/cron.log && tail -f /var/log/cron.log

