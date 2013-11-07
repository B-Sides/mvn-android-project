#!/bin/bash

# Builds a maven android project using the input package name and artifactId.
# buld-android-project com.package.name my-project-name

android_platform=14
android_plugin_version=3.7.0
android_project_version=1.0-SNAPSHOT
archetype_version=1.0.11

if [[ $1 = help ]]; then
  echo "Call this way:";
  echo "mvn-android-project com.project.package my-project-name";
  exit 0;
fi

# check if the user provided an argument
if [ -z $1 ]; then
    echo "Call this way:";
    echo "mvn-android-project com.project.package my-project-name"
    exit 0;
fi

echo "Creating your android maven project... Please wait."

yes "" | mvn archetype:generate \
  -DarchetypeArtifactId=android-release \
  -DarchetypeGroupId=de.akquinet.android.archetypes \
  -DarchetypeVersion=$archetype_version \
  -DgroupId=$1 \
  -DartifactId=$2 \
  -Dversion=$android_project_version \
  -Dplatform=$android_platform \
  -Dandroid-plugin-version=$android_plugin_version \
  -Demulator=not-specified \
  -Dpackage=$1 >/dev/null

cat > $2/.gitignore << EOF
# built application files
*.apk
*.ap_

# files for the dex VM
*.dex

# Java class files
*.class

# generated files
bin/
gen/

# Local configuration file (sdk path, etc)
local.properties

# Eclipse project files
.classpath
.project

# AndroidAnnotations related files
.settings
.factorypath
.apt_generated

# Maven related
target/

# Misc.
*.DS_Store

# Checkstyle
.checkstyle

# Android Lint
lint.xml

# IntelliJ
.idea
*.iml
*.ipr
*.iws
classes
gen-external-apklibs
out

*.jar.properties
EOF

# Setup Checkstyle Plugin
mkdir $2/config/
mkdir $2/config/quality
checkstyledir=$2/config/quality/checkstyle
mkdir $checkstyledir

touch $checkstyledir/checkstyle.xml
touch $checkstyledir/supressions.xml

cat > $checkstyledir/checkstyle.xml << EOF
<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE module PUBLIC "-//Puppy Crawl//DTD Check Configuration 1.3//EN"
    "http://www.puppycrawl.com/dtds/configuration_1_3.dtd"><!--     This configuration file was written by the eclipse-cs plugin configuration editor --><!--
    Checkstyle-Configuration: Android Checkstyle
    Description: none
-->
<module name="Checker">
    <property name="severity" value="warning" />
    <module name="TreeWalker">
        <property name="tabWidth" value="4" />
        <module name="ConstantName" />
        <module name="LocalFinalVariableName" />
        <module name="LocalVariableName" />
        <module name="MethodName" />
        <module name="PackageName" />
        <module name="ParameterName" />
        <module name="TypeName" />
        <module name="AvoidStarImport" />
        <module name="IllegalImport" />
        <module name="RedundantImport" />
        <module name="UnusedImports" />
        <module name="LineLength">
            <property name="severity" value="ignore" />
            <metadata name="net.sf.eclipsecs.core.lastEnabledSeverity" value="inherit" />
        </module>
        <module name="MethodLength" />
        <module name="ParameterNumber" />
        <module name="EmptyForIteratorPad" />
        <module name="MethodParamPad" />
        <module name="NoWhitespaceAfter">
            <property name="tokens" value="BNOT,DEC,DOT,INC,LNOT,UNARY_MINUS,UNARY_PLUS" />
        </module>
        <module name="NoWhitespaceBefore" />
        <module name="OperatorWrap" />
        <module name="ParenPad" />
        <module name="TypecastParenPad" />
        <module name="WhitespaceAfter" />
        <module name="WhitespaceAround">
           <property name="allowEmptyMethods" value="true" />
        </module>
        <module name="ModifierOrder" />
        <module name="RedundantModifier" />
        <module name="AvoidNestedBlocks" />
        <module name="EmptyBlock" />
        <module name="LeftCurly" />
        <module name="NeedBraces" />
        <module name="RightCurly" />
        <module name="EmptyStatement" />
        <module name="EqualsHashCode" />
        <module name="IllegalInstantiation" />
        <module name="InnerAssignment" />
        <module name="MagicNumber" />
        <module name="MissingSwitchDefault" />
        <module name="RedundantThrows">
            <property name="suppressLoadErrors" value="true" />
        </module>
        <module name="SimplifyBooleanExpression" />
        <module name="SimplifyBooleanReturn" />
        <module name="DesignForExtension">
            <property name="severity" value="ignore" />
            <metadata name="net.sf.eclipsecs.core.lastEnabledSeverity" value="inherit" />
        </module>
        <module name="FinalClass" />
        <module name="HideUtilityClassConstructor" />
        <module name="InterfaceIsType" />
        <module name="ArrayTypeStyle" />
        <module name="FinalParameters">
            <property name="severity" value="ignore" />
            <metadata name="net.sf.eclipsecs.core.lastEnabledSeverity" value="inherit" />
        </module>
        <module name="TodoComment">
            <property name="severity" value="ignore" />
            <metadata name="net.sf.eclipsecs.core.lastEnabledSeverity" value="inherit" />
        </module>
        <module name="UpperEll" />
        <module name="MethodLength">
            <property name="max" value="40" />
        </module>
        <module name="LineLength">
            <property name="max" value="100" />
        </module>
        <module name="InnerTypeLast" />
    </module>
    <module name="NewlineAtEndOfFile">
        <property name="severity" value="ignore" />
        <metadata name="net.sf.eclipsecs.core.lastEnabledSeverity" value="inherit" />
    </module>
    <module name="Translation" />
    <module name="FileTabCharacter">
        <property name="severity" value="ignore" />
        <metadata name="net.sf.eclipsecs.core.lastEnabledSeverity" value="inherit" />
    </module>
    <module name="RegexpSingleline">
        <property name="severity" value="ignore" />
        <property name="format" value="\s+$" />
        <property name="message" value="Line has trailing spaces." />
        <metadata name="net.sf.eclipsecs.core.lastEnabledSeverity" value="inherit" />
    </module>
    <module name="SuppressionFilter">
        <property name="file" value="config/quality/checkstyle/suppressions.xml" />
    </module>
</module>
EOF

cat > $checkstyledir/suppressions.xml << EOF
<?xml version="1.0"?><!DOCTYPE suppressions PUBLIC
    "-//Puppy Crawl//DTD Suppressions 1.1//EN"
    "http://www.puppycrawl.com/dtds/suppressions_1_1.dtd">
<suppressions>
    <suppress checks="[a-zA-Z0-9]*" files="[\\/]gen[\\/]" />
    <suppress checks="[a-zA-Z0-9]*" files="[\\/]bin[\\/]" />
    <suppress checks="[a-zA-Z0-9]*" files="[\\/]target[\\/]" />
    <suppress checks="[a-zA-Z0-9]*" files="[\\/].apt_generated[\\/]" />
</suppressions>
EOF

# Insert checkstyle settings into parent pom
plugin_checkstyle='              <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-checkstyle-plugin</artifactId>
                    <version>${maven-checkstyle-plugin.version}</version>
                    <configuration>
                        <configLocation>config/quality/checkstyle/checkstyle.xml</configLocation>
                        <enableRulesSummary>false</enableRulesSummary>
                        <propertyExpansion>basedir=${basedir}</propertyExpansion>
                        <failsOnError>true</failsOnError>
                        <violationSeverity>warning</violationSeverity>
                        <consoleOutput>true</consoleOutput>
                    </configuration>
                    <executions>
                        <execution>
                            <id>checkstyle-check</id>
                            <phase>process-sources</phase>
                            <goals>
                                <goal>check</goal>
                            </goals>
                        </execution>
                    </executions>
                </plugin>'

printf '%s\n' H 75i "$plugin_checkstyle" . wq | ed -s $2/pom.xml

checkstyle_version='        <maven-checkstyle-plugin.version>2.9.1</maven-checkstyle-plugin.version>'
printf '%s\n' H 15i "$checkstyle_version" . wq | ed -s $2/pom.xml

checkstyle_declaration='            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-checkstyle-plugin</artifactId>
                </plugin>'

printf '%s\n' H 80i "$checkstyle_declaration" . wq | ed -s $2/$2/pom.xml

# Setup FindBugs Plugin
findbugsdir=$2/config/quality/findbugs

mkdir $findbugsdir

cat > $findbugsdir/findbugs-filter.xml << EOF
<?xml version="1.0" encoding="UTF-8"?>
<FindBugsFilter>
    <!-- http://stackoverflow.com/questions/7568579/eclipsefindbugs-exclude-filter-files-doesnt-work -->
    <Match>
        <Class name="~.*\.R\$.*"/>
    </Match>
    <Match>
        <Class name="~.*\.Manifest\$.*"/>
    </Match>
    <!-- All bugs in test classes, except for JUnit-specific bugs -->
    <Match>
        <Class name="~.*\.*Test" />
        <Not>
            <Bug code="IJU" />
        </Not>
    </Match>
</FindBugsFilter>
EOF

findbugs_plugin='                   <plugin>
                    <groupId>org.codehaus.mojo</groupId>
                    <artifactId>findbugs-maven-plugin</artifactId>
                    <version>${findbugs-maven-plugin.version}</version>
                    <configuration>
                        <!--<xmlOutput>true</xmlOutput>-->
                        <skip>false</skip>
                        <failOnError>true</failOnError>
                        <threshold>High</threshold>
                        <excludeFilterFile>config/quality/findbugs/findbugs-filter.xml</excludeFilterFile>
                    </configuration>
                    <executions>
                        <execution>
                            <id>findbugs-check</id>
                            <phase>verify</phase>
                            <goals>
                                <goal>check</goal>
                            </goals>
                        </execution>
                    </executions>
                </plugin>'

printf '%s\n' H 98i "$findbugs_plugin" . wq | ed -s $2/pom.xml

findbugs_version='        <findbugs-maven-plugin.version>2.5.2</findbugs-maven-plugin.version>'
printf '%s\n' H 16i "$findbugs_version" . wq | ed -s $2/pom.xml

findbugs_declaration='            <plugin>
                <groupId>org.codehaus.mojo</groupId>
                <artifactId>findbugs-maven-plugin</artifactId>
                </plugin>'

printf '%s\n' H 84i "$findbugs_declaration" . wq | ed -s $2/$2/pom.xml

#Removes offending checkstyle error. (Unused import)
(echo "g/import android.util.Log/d"; echo 'wq') | ex -s $2/$2/src/main/java/com/project/HelloAndroidActivity.java

echo "**** Successfully created your maven android project in $2/ ****"

exit 0;