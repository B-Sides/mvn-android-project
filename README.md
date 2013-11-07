#mvn-android-project
A simple bash script that generates an android maven project. Code quality tools are preconfigured to run during a maven build. A .gitignore is also generated to filter out common Android files that don't require versioning.

## Code quality tools
* [Checkstyle Maven Plugin](http://maven.apache.org/plugins/maven-checkstyle-plugin/) - a development tool to help programmers write Java code that adheres to a coding standard
* [FindBugs](http://mojo.codehaus.org/findbugs-maven-plugin/findbugs-mojo.html) - Looks for bugs in Java programs. FindBugs uses static analysis to inspect Java bytecode for occurrences of bug patterns

##Using mvn-android-project.sh
To create your project simply run **./mvn-android-project.sh com.myproject my-artifactId**