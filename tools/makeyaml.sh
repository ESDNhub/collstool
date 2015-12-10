#!/bin/bash

Echo "Running saxon...."
saxon -xsl:councils.xsl esdn.xml > councils.xml
if [ $? -eq 0 ]
then echo "Converting to json..."
fi
xml-to-json councils.xml > councils.json
if [ $? -eq 0 ]
then echo "Converting to yaml..."
fi
json2yaml councils.json > $1
if [ $? -eq 0 ]
then echo "Done."
fi

