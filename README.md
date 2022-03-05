# TG_Redash_Interview_Demo
The project is a live-streaming fraud dashboard that utilizes data from the fraud starter kit from TigerGraph. This project was created for the presentation round of my interview for TigerGraph. 

The main components of this project are:
1. [Redash](https://redash.io/) - for dashboarding
2. [TigerGraph](https://www.tigergraph.com/) - graph database with connected fraud data
3. [TigerFlow](https://github.com/TigerGraph-DevLabs/TigerFlow) ([NodeRed](https://nodered.org/)) - custom flow editor for configuring streaming of data with TigerGraph
4. [tgSolutionPack](https://github.com/TigerGraph-DevLabs/tgSolutionPack) - an open-source project from TigerGraph with scripts and data for installing the starter kits

# Getting Started
This project offers two solutions. One is a fraud dataset with custom queries and other features. There are also instructions below to create a simple fraud dashboard with data streaming using Redash and Node Red. The other is a general insallation using the `tgSolutionPack` project. Using this you can install any of 10 different starter kits, and still contains the blank dashboard template to create your own custom projects.

**Both projects run using Docker**

Before you can get started, make sure you have [Docker](https://www.docker.com/) installed and running.

There are a few main docker images in this project:
1. tgdash - This contains redash
2. TigerFlow - This contains the custom implementation of Node Red with TigerGraph configuration
3. TigerGraph- This is to allow you to create graphs and write queries on your own local graph database

**The projects contains 2 gzip files for deployment**
```
fraudSolution.tar.gz  - Contains data and scripts for deploying the fraud Solution
genericSolution.tar.gz - Contains scripts for deploying the generic Solution
```

**Alternatively, you can clone this repository and use the directories available**


See below for instructions of the respective solutions.
## Setup - Generic
1. asdf
2. 2asdf
3. asdf
4. dsf
## Setup - Fraud
1. asdf
2. asdf
3. asdf
4. asdf
5. asfd
## Fraud Dashboard
1. asdf
2. asdf
3. sadf
4. asfd

Notes: IP address for localhost
1. Set up data source
2. Set up queries & visualizations in Redash
3. Set up dashboard
4. Set up nodered streaming
 - configure connection
 - set up components
 - inject
