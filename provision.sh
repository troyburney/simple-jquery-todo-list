#!/bin/bash


set -e;
reset;clear;


echo
echo
echo "##########################################################################"
echo "###                                                                    ###"
echo "###  Variables for image naming and execution                          ###"
echo "###                                                                    ###"
echo "##########################################################################"
set -x
runningContainerName=todo-list-application
containerSourcePort=80
hostTargetPort=28088
containerName=softwareshinobi/todo-list-web-application
containerTag=latest
set +x


echo
echo
echo "##########################################################################"
echo "###                                                                    ###"
echo "###  Build the image                                                   ###"
echo "###                                                                    ###"
echo "##########################################################################"
docker build -t $containerName:$containerTag .


echo
echo
echo "##########################################################################"
echo "###                                                                    ###"
echo "###  List the Images (filtered)                                        ###"
echo "###                                                                    ###"
echo "##########################################################################"
docker image ls | grep $containerName


echo
echo
echo "##########################################################################"
echo "###                                                                    ###"
echo "###  List the running Containers (before)                              ###"
echo "###                                                                    ###"
echo "##########################################################################"
docker ps


echo
echo
echo "##########################################################################"
echo "###                                                                    ###"
echo "###  Stop and remove the application specific Container                ###"
echo "###                                                                    ###"
echo "##########################################################################"
{ docker stop $runningContainerName || true; echo "stopped..."; } | tr "\n" " ";echo;
{ docker rm   $runningContainerName || true; echo "removed..."; } | tr "\n" " ";echo;


echo
echo
echo "##########################################################################"
echo "###                                                                    ###"
echo "###  Run the container given the parameters specified above            ###"
echo "###                                                                    ###"
echo "##########################################################################"
docker run -d --name $runningContainerName         \
           -p $hostTargetPort:$containerSourcePort \
              $containerName:$containerTag


echo
echo
echo "##########################################################################"
echo "###                                                                    ###"
echo "###  List the running Containers (after)                               ###"
echo "###                                                                    ###"
echo "##########################################################################"
docker ps


echo
echo
echo "##########################################################################"
echo "###                                                                    ###"
echo "###  Open the application in the Firefox browser                       ###"
echo "###                                                                    ###"
echo "##########################################################################"
firefox http://localhost:$hostTargetPort 2>&1


echo
echo
echo "##########################################################################"
echo "###                                                                    ###"
echo "###  Local Container deployment completed                              ###"
echo "###                                                                    ###"
echo "##########################################################################"
exit
