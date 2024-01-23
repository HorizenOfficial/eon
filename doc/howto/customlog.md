[&lt; EON Documentation index](/doc/index.md) 
# EON logging configuration

## Simple logging customization

Edit the following variables in the node configuration file to customize path and level of logging:

- **sparkz.logDir**

  Path of the logging directory

- **sparkz.logInfo.logFileName**

  Name of the log file

- **sparkz.logInfo.logFileLevel** and **sparkz.logInfo.logConsoleLevel**

  Level of logging used for file and console appenders. 
  Can be one of the following: off, fatal, error, warn, info, debug, trace, all


## Advanced logging customization

For advanced customization you can setup EON to use a totally custom log4j file instead of the default one:

- if you are running the java process  directly, add the following property to the startup command:

  -Dlog4j.configurationFile=filePath

- if you are running via Docker, configure an environment variable **SCNODE_LOG4J_CUSTOM_CONFIG** with the path to the log4j file, and be sure to have the file present inside the container.

Start from [this base template](https://github.com/HorizenOfficial/Sidechains-SDK/blob/master/sdk/src/main/resources/log4j2.xml) to create your cunfiguration file.