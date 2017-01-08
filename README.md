# HiveCodes

# Below are the some steps that we need to do to connect to the Hive Database from Squirrel client

FOR HDP 2.2.x From /usr/hdp/current/hive-client/lib/ sftp or scp to your local desktop

hive-*-0.14*.jar
httpclient-4.2.5.jar
httpcore-4.2.5.jar
libthrift-0.9.0.jar
libfb303-0.9.0.jar
commons-logging-1.1.3.jar
FOR HDP 2.3.x

From /usr/hdp/current/hive-client/lib/ sftp or scp to your local desktop

hive-jdbc.jar
FOR BOTH

From /usr/hdp/current/hadoop-client

hadoop-common.jar
hadoop-auth.jar
From /usr/hdp/current/hadoop-client/lib

log4j-1.2.17.jar
slf4j-*.jar
Download SquirrelSQL from sourceforge.net

http://squirrel-sql.sourceforge.net/

Configure Hive Driver in Squirrel SQL

Select ‘Drivers -> New Driver…’ to register the Hive JDBC driver.
Enter Hive for Driver Name and jdbc:// Example URL: jdbc:hive://localhost:10000/default
Select ‘Extra Class Path -> Add’ to add the jars you copied from the previous steps.
Enter org.apache.hive.jdbc.HiveDriver as Class Name
Add a New Hive Connection Alias for HDP 2.3

Choose Alias -> New Alias
Enter “Hive for HDP 2.3”
Enter “jdbc:hive2://127.0.0.1:10000”
Enter “hive” for User Name and “hive” for Password.
Test your connection and ensure it is successful
Connect to “Hive for HDP 2.3.” alias. If successful you would be presented with the default and xademo databases.
Oracle SQL Developer and Toad for Apache Hadoop does not use Apache Hive JDBC Driver. They are both black boxes that hide the the ability to easily point to a JDBC class path and just end whatever JDBC properties you desire.

So if you need to add special properties for ssl, or kerberos or ldap authentication, neither SQL Developer nor Toad will work.

Use SQL Workbench J, RazorSQL or Squirrel SQL instead.
