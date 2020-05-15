# Collective environment

This is docker-compose test environment
(Hope I can put some picture here) 

## Steps
- Clone this repo.
- Make sure docker network/ports have no conflicts by running `docker ps` and `docker network`.
- `docker-compose.build` to build the Docker image
- `docker-compose up` to start 4 servers (ignore some error messages)
    ```
    htakamiy@us.ibm.com@Hirokos-MBP collective-env % docker-compose up
    Starting liberty3 ... done
    Starting liberty2 ... done
    Starting liberty4 ... done
    Starting liberty1 ... done
    Attaching to liberty2, liberty3, liberty4, liberty1
    liberty4    | /opt/ibm/helpers/runtime/docker-server.sh: line 55: /config/configDropins/defaults/keystore.xml: No such file or directory
    liberty3    | /opt/ibm/helpers/runtime/docker-server.sh: line 55: /config/configDropins/defaults/keystore.xml: No such file or directory
    liberty1    | /opt/ibm/helpers/runtime/docker-server.sh: line 55: /config/configDropins/defaults/keystore.xml: No such file or directory
    liberty2    | /opt/ibm/helpers/runtime/docker-server.sh: line 55: /config/configDropins/defaults/keystore.xml: No such file or directory
    liberty4    | cp: cannot create regular file '/config/configDropins/overrides/trustDefault.xml': No such file or directory
    liberty2    | cp: cannot create regular file '/config/configDropins/overrides/trustDefault.xml': No such file or directory
    liberty3    | cp: cannot create regular file '/config/configDropins/overrides/trustDefault.xml': No such file or directory
    liberty1    | cp: cannot create regular file '/config/configDropins/overrides/trustDefault.xml': No such file or directory
    ```
- On another terminal (separate from the terminal running the compose), make sure all the containers are up and running by `docker ps`
- Liberty 1 container 
    - For `liberty1` container, run `docker exec -it liberty1 /bin/bash`
    - Run `cat /remindme.txt` to remind myself of collective stuff. (Mostly forgotten!)
    - Run `/setup_liberty1.sh` to setup collective-controller.
- Liberty2 and 3 containers
    - For `liberty2` container, run `docker exec -it liberty2 /bin/bash`
    - Run `cat /remindme.txt` to remind myself of collective stuff. (Mostly forgotten!)
    - Run `/setup_liberty2.sh` to setup `libarty2` as replica to `liberty1` controller.
    - Same step for `liberty3` (Just change 2 to 3)
- Liberty4 
    - For `liberty4` container, run `docker exec -it liberty4 /bin/bash`
    - Run `cat /remindme.txt` to remind myself of collective stuff. (Mostly forgotten!)
    - Run `/setup_liberty4.sh` to setup `libarty4` as a member to `liberty1` controller.
- Saving files
    - For each container, `/logs` is locally `Users/htakamiy@us.ibm.com/logs/docker/logs1`
    - Change `docker-compose.yaml` definition to map local directory of your choice!


## Details
- docker-compose.yml : 
    - This file will bring up 4 servers 
    - Each server is based on `websphere-liberty:full` docker image
    - All of them has `collectiveController-1.0` is installed
    - Hostname, ip address, ports are defined to avoid conflicts
        - 2809, 9043, 9443, 9080, 10010 (bootstrap default port)
        - yaml file has details of port assignment
    - In each server root directory (/), following scripts are found.
        - setup_liberty1.sh : configures collective-controller
        - setup_liberty2.sh : a replica of liberty1
        - setup_liberty3.sh : another replica of liberty1
        - setup_liberty4.sh : configures collective-member
    - Ignore following error messages at startup. The files that are not found were purposely removed so that key.p12, trust.p12 and collective keystores will use the same passwords. 
        ```
        >  collective-env % docker-compose up
        ...
        ...
        liberty3    | /opt/ibm/helpers/runtime/docker-server.sh: line 55: /config/configDropins/defaults/keystore.xml: No such file or directory
        liberty3    | cp: cannot create regular file '/config/configDropins/overrides/trustDefault.xml': No such file or directory
        ```

    - Configuration details are found in `websphere-liberty/reminder.txt` in this repo, or `/reminder.txt` on the container. 
- websphere-liberty: 
    - This directory contains Dockerfile for the collective servers
    - Dockerfile is based on `websphere-liberty:full`
    - Dockerfile installs `collectiveController-1.0` feature which includes `collectiveMember-1.0` feature.
    - Some utilities such as ping, emacs 
    - Edited server.xml with snippets from `collective create/replicate/addReplica/join` commands for the scripts to use.
    - `/reminder.txt` at the root directory to help remmember collective setup
- container-opt-ibm-helpers-dir
    - This directory has copies of script that comes with `websphere-liberty:full` image that helps setup.  Just saving them for convenience to further enhance this repo.  Can be obtained by firing up the container and go to `/opt/ibm/helpers/` directory.
- keystores
    -  `setup_libertyX.sh` will copy `{wlp_server_dir}/resources` directory to each `logs` directory (which is local storage `~/docker/logsX`)
    - listing of files under resources
        ```
        ./resources
        ./resources/security
        ./resources/security/trust.p12
        ./resources/security/ssh
        ./resources/security/ssh/id_rsa
        ./resources/security/ssh/id_rsa.pub
        ./resources/security/key.p12
        ./resources/collective
        ./resources/collective/rootKeys.p12
        ./resources/collective/serverIdentity.p12
        ./resources/collective/collective.uuid
        ./resources/collective/collectiveTrust.p12
        ```
## KC and other docs

Collective Architecture
https://www.ibm.com/support/knowledgecenter/SSD28V_liberty/com.ibm.websphere.wlp.core.doc/ae/cwlp_collective_arch.html

Chris Vignola (2013)
https://www.ibm.com/developerworks/websphere/techjournal/1309_vignola/1309_vignola.html

Setting up the server-management environment for Liberty by using collective
https://www.ibm.com/support/knowledgecenter/SSD28V_liberty/com.ibm.websphere.wlp.core.doc/ae/tagt_wlp_server_management.html

Collective feature doc, elements etc
https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.liberty.autogen.nd.doc/ae/rwlp_feature_collectiveController-1.0.html

Collective Troubleshooting
https://www.ibm.com/support/knowledgecenter/SS7K4U_liberty/com.ibm.websphere.wlp.zseries.doc/ae/cwlp_collective_trouble.html

Collective Mustgather: 
https://www.ibm.com/support/pages/mustgather-collective-and-controller-websphere-liberty-profile

Intelligent Management Mustgather: 
https://www.ibm.com/support/pages/mustgather-tracing-dynamic-routing-feature-web-server-plug-liberty-profile-nd

Configuring a Liberty collective using developer tools
https://www.ibm.com/support/knowledgecenter/SSD28V_liberty/com.ibm.websphere.wlp.core.doc/ae/t_configurecollective.html

Registering host computers with a Liberty collective
https://www.ibm.com/support/knowledgecenter/SSD28V_liberty/com.ibm.websphere.wlp.core.doc/ae/tagt_wlp_registerhost.html

Starting and stopping member
https://www.ibm.com/support/knowledgecenter/SS7K4U_liberty/com.ibm.websphere.wlp.zseries.doc/ae/ragt_wlp_servercommand.html


## TODO
- collective summaries
- Configure admincenter
- add admincenter mustgather
- Put together existing data

## Clean up 
- docker container may be committed? (Need to learn more about docker-compose)
- Steps to start fresh
    - stop currently running docker-compose by Ctrl-C
    - docker ps -a
    - docker rm liberty1
    - docker rm liberty2, 3, 4
    - docker images
    - docker rmi (image-id)
    - Delete local file ~/docker/logs1,2,3,4
- if Dockerfile is updated, remove images and run 
    - docker-compose build
