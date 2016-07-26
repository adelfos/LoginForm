@echo off
call  %FLEX_HOME%/bin/mxmlc -library-path+=./libs/  -output ./bin/main.swf ./src/Main.mxml

pause

