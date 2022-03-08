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
Fraud_Solution.tar.gz  - Contains data and scripts for deploying the fraud Solution
Generic_Solution.tar.gz - Contains scripts for deploying the generic Solution
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
   
   ### This may take up to 15 minutes. Sit back and relax
   
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
![Screen Shot 2022-03-07 at 6 53 32 PM](https://user-images.githubusercontent.com/46678528/157144091-86a4f451-2c72-4dcb-a270-0c410d1dc998.png)

5. Create a new query and call `GetRecentTransactions` from TigerGraph
   
   ![Screen Shot 2022-03-07 at 7 03 37 PM](https://user-images.githubusercontent.com/46678528/157145098-3a6a56b7-4dbf-4883-9e8f-2b44679c4200.png)
   This query gets the latest 50 transactions in the graph, and will be used to get a table of transactions that updates in real time for the dashboard
   
6. Click **Add Visualization** to create a *Table* visualization. Style it as you like.
   
   Once complete, be sure to **set the refresh time** if desired and **name the query and publish** 
   
6. Create a new query and call `GetMetaInformation` from TigerGraph
   
   This query gets high-level information like number of users, total transaction amount, etc. Using this query we can create several *Counter* visualizations to display large numbers.
   
   ![Screen Shot 2022-03-07 at 7 12 50 PM](https://user-images.githubusercontent.com/46678528/157146003-7a513239-0eb6-4875-bfba-aa6581613b14.png)

7. Create *Counter* visualizations for all of the 6 columns.

8. Create a new Dashboard. Call it something like **Fraud Dashboard**

   Use the **Add Widget** button to add the different visualizations we created to the table layout. Orient and position them how you see fit. Here is an example:
   
   ![Screen Shot 2022-03-07 at 7 18 54 PM](https://user-images.githubusercontent.com/46678528/157146592-f4c1dbbb-45b3-41f7-bee7-97b87757f1f3.png)

9. **Publish the results**
   
10. The final step is to set up NodeRed streaming. Click the **TigerGlow** icon on the sidebar.

   To start, add a **TigerGraphQuery** node from the left panel
   
   **Double click** on the node and edit the **TG Graph**
   Configure the connection similar to the redash data source (**Note: DO NOT include the `http://` portion of the URL**) 
   
   ![Screen Shot 2022-03-07 at 7 29 28 PM](https://user-images.githubusercontent.com/46678528/157147729-7b4dc8a6-8e5e-4924-821e-3ceebc0c8544.png)
   
   Now set up the node to call the query `GenerateUser` or `GenerateTransaction`. These queries randomly generate users or transactions between users respectively and update the graph. We will use NodeRed to continuously call these queries and *simulate* live transactions
   
   ![Screen Shot 2022-03-07 at 7 32 39 PM](https://user-images.githubusercontent.com/46678528/157148053-8d5f67a5-94bc-4fcd-815d-b9466de9ab2e.png)

   All that's left is to add the inject component. This is what triggers the call to TigerGraph. Configure the inject to not transmit any data, and to repeat however often you desire.
   
   ![Screen Shot 2022-03-07 at 7 36 20 PM](https://user-images.githubusercontent.com/46678528/157148413-adf1b1fd-0188-4198-9bb7-fb357cafecfb.png)

   
   Connect the **inject node** to the **TigerGraphQuery node**
   
   Repeat the process with the other query (`GenerateUser` or `GenerateTransaction`).
   
   **Deploy the flow**
   
   ### Double check: 
   The TigerGraphQuery nodes should say **connected** if everything is configured properly
   
   ### Inject both queries and watch the live updates in your dashboard!

# Troubleshooting
## Remote Host Identification
When first installing the docker images, you may run into this issue.
![Screen Shot 2022-03-05 at 3 26 41 PM](https://user-images.githubusercontent.com/46678528/156900401-a8883764-aab6-4574-9025-6161bae5c5a4.png)

This may happen if you have previously installed the TigerGraph docker image on your local machine.

### To resolve, you need to edit the `known_hosts` file

This file contains the public keys to all SSH hosts that have been verified

**For me, this was located at `Users/akashkaul/.ssh`** 

### Delete the line for TigerGraph 

`[localhost]:14022 ecdsa-sha2-nistp256 AAA ....`

Run the install script again and the error should be resolved!

## Rest++ Authentication 
When trying to connect your TigerGraph database to Redash, you may come across the following error:
> REST++ authentication is not enabled, can't generate token

This may happen if user authentication is not enabled in TigerGraph.
Run these commands (courtesy of [TigerGraph docs](https://docs.tigergraph.com/tigergraph-server/current/user-access/enabling-user-authentication#_enable_restpp_authentication)) in the TigerGraph shell to enable authentication:

`gadmin config set RESTPP.Factory.EnableAuth true`

`gadmin config apply`

`gadmin restart restpp nginx gui gsql -y`
