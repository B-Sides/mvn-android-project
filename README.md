#mvn-android-project#
A simple bash script that generates an android maven project. A .gitignore is also generated and installed in the root directory. 

Checkstyle is preconfigured as a plugin and runs during build compilation. Running "mvn clean install" in the root directory will produce a fail at first because main activity has a checkstyle error: "warning: Unused import - android.util.Log" . Removing the import will fix the build. 


###Running mvn-android-project
To create your project simply run **./mvn-android-project com.myproject my-artifactId**