#!/usr/bin/env bash

check_gitea_environment(){
  if [ -z ${CHANGEME_POSTGRESSPASSWORD} ] || [ -z ${CHANGEME_INGRESSDOMAIN} ] 
  then
    echo "Requires Environment Variables:"
    echo "CHANGEME_POSTGRESSPASSWORD"
    echo "CHANGEME_INGRESSDOMAIN"
    exit 1
  fi
}

check_drone_environment(){
  if [ -z ${CHANGEME_DRONEUSER} ] || [ -z ${CHANGEME_POSTGRESSPASSWORD} ] || [ -z ${CHANGEME_INGRESSDOMAIN} ] || [ -z ${CHANGEME_DRONERPCSECRET} ] || [ -z ${CHANGEME_DRONECLIENTID} ] || [ -z ${CHANGEME_DRONECLIENTSECRET} ] || [ -z ${CHANGEME_DRONERPCSECRET} ] 
  then
    echo "Requires Environment Variables:"
    echo "CHANGEME_DRONEUSER"
    echo "CHANGEME_POSTGRESSPASSWORD"
    echo "CHANGEME_INGRESSDOMAIN"
    echo "CHANGEME_DRONERPCSECRET"
    echo "CHANGEME_DRONECLIENTID"
    echo "CHANGEME_DRONECLIENTSECRET"
    echo "CHANGEME_DRONERPCSECRET"
    exit 1
  fi
}

if [ ${1} == "download" ] 
then
  mkdir manifests
  curl -sL https://raw.githubusercontent.com/ruanbekker/blog-assets/master/civo.com-drone-gitea-cicd-kubernetes/manifests/postgres.yml -o manifests/postgres.yml
  curl -sL https://raw.githubusercontent.com/ruanbekker/blog-assets/master/civo.com-drone-gitea-cicd-kubernetes/manifests/gitea.yml -o manifests/gitea.yml
  curl -sL https://raw.githubusercontent.com/ruanbekker/blog-assets/master/civo.com-drone-gitea-cicd-kubernetes/manifests/drone-server.yml -o manifests/drone-server.yml
  curl -sL https://raw.githubusercontent.com/ruanbekker/blog-assets/master/civo.com-drone-gitea-cicd-kubernetes/manifests/drone-agent.yml -o manifests/drone-agent.yml
  curl -sL https://raw.githubusercontent.com/ruanbekker/blog-assets/master/civo.com-drone-gitea-cicd-kubernetes/manifests/ingress.yml -o manifests/ingress.yml
fi

if [ ${1} == "gitea" ] 
then
  check_gitea_environment
  sed -i "s/\$CHANGEME_POSTGRESSPASSWORD/$CHANGEME_POSTGRESSPASSWORD/g" manifests/postgres.yml
  sed -i "s/\$CHANGEME_POSTGRESSPASSWORD/$CHANGEME_POSTGRESSPASSWORD/g" manifests/gitea.yml
  sed -i "s/\$CHANGEME_INGRESSDOMAIN/$CHANGEME_INGRESSDOMAIN/g" manifests/gitea.yml
  sed -i "s/\$CHANGEME_INGRESSDOMAIN/$CHANGEME_INGRESSDOMAIN/g" manifests/ingress.yml
fi

if [ ${1} == "drone" ] 
then
  check_drone_environment
  sed -i "s/\$CHANGEME_DRONEUSER/$CHANGEME_DRONEUSER/g" manifests/drone-server.yml
  sed -i "s/\$CHANGEME_POSTGRESSPASSWORD/$CHANGEME_POSTGRESSPASSWORD/g" manifests/drone-server.yml
  sed -i "s/\$CHANGEME_INGRESSDOMAIN/$CHANGEME_INGRESSDOMAIN/g" manifests/drone-server.yml
  sed -i "s/\$CHANGEME_DRONERPCSECRET/$CHANGEME_DRONERPCSECRET/g" manifests/drone-server.yml
  sed -i "s/\$CHANGEME_DRONECLIENTID/$CHANGEME_DRONECLIENTID/g" manifests/drone-server.yml
  sed -i "s/\$CHANGEME_DRONECLIENTSECRET/$CHANGEME_DRONECLIENTSECRET/g" manifests/drone-server.yml
  sed -i "s/\$CHANGEME_DRONERPCSECRET/$CHANGEME_DRONERPCSECRET/g" manifests/drone-agent.yml
fi
