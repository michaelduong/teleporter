eval $(ibmcloud ks cluster-config --cluster mirror --export)

# get public ip from here
#ibmcloud ks workers mirror

# push docker-image: docker push noumaan/mirror-server:2
