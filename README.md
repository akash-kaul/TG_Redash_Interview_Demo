# TG_Redash_Interview_Demo
The project is a live-streaming fraud dashboard that utilizes data from the fraud starter kit from TigerGraph. This project was created for the presentation round of my interview for TigerGraph. 

The main components of this project are:
1. [Redash](https://redash.io/) - for dashboarding
2. [TigerGraph](https://www.tigergraph.com/) - graph database with connected fraud data
3. [TigerFlow](https://github.com/TigerGraph-DevLabs/TigerFlow) ([NodeRed](https://nodered.org/)) - custom flow editor for configuring streaming of data with TigerGraph
4. [tgSolutionPack](https://github.com/TigerGraph-DevLabs/tgSolutionPack) - an open-source project from TigerGraph with scripts and data for installing the starter kits


This project offers two solutions. One is a fraud dataset with custom queries and other features. There are also instructions below to create a simple fraud dashboard with data streaming using Redash and Node Red. The other is a general insallation using the `tgSolutionPack` project. Using this you can install any of 10 different starter kits, and still contains the blank dashboard template to create your own custom projects.

**Both projects run using Docker**

Before you can get started, make sure you have [Docker](https://www.docker.com/) installed and running.

There are a few main docker images in this project:
1. *tgdash* - This contains redash
2. *TigerFlow* - This contains the custom implementation of Node Red with TigerGraph configuration
3. *TigerGraph* - This is to allow you to create graphs and write queries on your own local graph database

# Getting Started

**The projects contains 2 gzip files for deployment**
```
fraudSolution.tar.gz  - Contains data and scripts for deploying the fraud Solution
genericSolution.tar.gz - Contains scripts for deploying the generic Solution
```

### Download these files and unzip them to get started

**Alternatively, you can clone this repository and use the directories available**


See below for instructions of the respective solutions.
## Setup - Generic
1. Change to the Generic folder

   `cd Generic_Solution`

2. Execute the file `deploy_solution_generic.sh`

   `./deploy_solution_generic.sh`
   
   or
   
   `sh deploy_solution_generic.sh`
   
   This will begin downloading several docker images along with the data for the different starter kits.
   
   ### You will be prompted several times for the password to your local TigerGraph instance
   
   **At each prompt, enter the password: `tigergraph`**
3. Once finished, you should have a terminal connected to your TigerGraph instance. 

   **Double Check**
   
   You should be in the directory `~/mydata/tgSolutionPack`
   
   You can check everything has been installed correctly by running `ls`. You should see the following
   
   
   ![Screen Shot 2022-03-05 at 3 04 45 PM](https://user-images.githubusercontent.com/46678528/156899886-c868d53b-dddd-424e-9432-9ecc52986c62.png)

4. Run the install script and follow the instructions to install a TigerGraph starter kit

   `./runDPInstall.sh`
   
   or
   
   `sh runDPInstall.sh`
   
5. To stop the Docker container, run `docker-compose stop`
6. To restart the container execute the file `deploy_solution_generic.sh` again
## Setup - Fraud
1. Change to the Fraud folder

   `cd Fraud_Solution`

2. Execute the file `deploy_solution_fraud.sh`

   `./deploy_solution_fraud.sh`
   
   or
   
   `sh deploy_solution_fraud.sh`
   
   This will begin downloading several docker images along with the data for the fraud starter kit.
   
   ### You will be prompted several times for the password to your local TigerGraph instance
   
   **At each prompt, enter the password: `tigergraph`**
3. Once finished, you should have a terminal connected to your TigerGraph instance. 

   **Double Check**
   
   You should be in the home directory. When running `ls`, you should see a folder called `data`

4. Run the install script

   `./runDPInstall.sh`
   
   or
   
   `sh runDPInstall.sh`
   
   This creates the fraud starter kit schema, loads the data, and installs several queries. 
   
   ### This may take up to 10 minutes. Sit back and relax
   
   Once installed, you can check everything loaded correctly by using GraphStudio.
   
   `localhost:14240`
   
5. To stop the Docker container, run `docker-compose stop`
6. To restart the container execute the file `deploy_solution_generic.sh` again
## Fraud Dashboard
1. Once installed, you can head over to the redash app.
   
   `localhost:5000`
2. Create an account and login

   ![Screen Shot 2022-03-05 at 4 06 12 PM](https://user-images.githubusercontent.com/46678528/156901327-11ae9d05-9a36-43bb-8ed6-18e3bd410448.png)
3. Click `Connect a Data Source`

   Alternatively, go to `Settings` to add a new data source
   
   Fill out the information requested.
   
   ### Two important notes:
   1. To get the `Graph Secret`, use the **Admin Portal** of GraphStudio (`localhost:14240`) and generate a new secret under the tab `Management -> Users`
   ![Screen Shot 2022-03-05 at 4 13 18 PM](https://user-images.githubusercontent.com/46678528/156901480-29dc6b4e-8fef-4f02-a754-a3a0591feaee.png)
   2. Because we are using docker containers, the `TigerGraph Host` is not `localhost` but your local IP address (ie `http://192.168.1.0`)

4. Save the Data Source and **Test the connection** to make sure it is working

   
5. asfd


2. Set up queries & visualizations in Redash
3. Set up dashboard
4. Set up nodered streaming
 - configure connection
 - set up components
 - inject

## Troubleshooting
When first installing the docker images, you may run into this issue.
![Screen Shot 2022-03-05 at 3 26 41 PM](https://user-images.githubusercontent.com/46678528/156900401-a8883764-aab6-4574-9025-6161bae5c5a4.png)

This may happen if you have previously installed the TigerGraph docker image on your local machine.

### To resolve, you need to edit the `known_hosts` file

This file contains the public keys to all SSH hosts that have been verified

**For me, this was located at `Users/akashkaul/.ssh`** 

### Delete the line for TigerGraph 

`[localhost]:14022 ecdsa-sha2-nistp256 AAA ....`

Run the install script again and the error should be resolved!
