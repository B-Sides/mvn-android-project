#mvn-android-project
A simple bash script that generates an android project with maven configured as the build system. Code quality tools are preconfigured to run during a maven build. A .gitignore is also generated to filter out common Android files.

The following are features configured as part of the build:

## Code quality tools
* [Checkstyle Maven Plugin](http://maven.apache.org/plugins/maven-checkstyle-plugin/) - A development tool to help programmers write Java code that adheres to a coding standard.
* [FindBugs Maven Plugin](http://mojo.codehaus.org/findbugs-maven-plugin/findbugs-mojo.html) - FindBugs uses static analysis to inspect Java bytecode for occurrences of bug patterns

## Testing
* [Robolectric](https://github.com/robolectric/robolectric) - A unit test framework that de-fangs the Android SDK so you can test-drive the development of your Android app
* [Robotium](Insert Link here) - A integration test framework. 


##Usage
In Bash run: **./mvn-android-project com.mycompany my-project-name**