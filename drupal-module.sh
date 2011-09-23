#!/bin/bash

SCRIPT_NAME=$(basename $0)

URL=$1
MODULE=($(echo $1 | sed -e 's|.*/||'))
MODULE_NAME=($(echo $MODULE | sed -e 's|-.*||'))

if [ $# -ne 1 ]
then
  echo "usage : ${SCRIPT_NAME} URL"
  exit -1
fi


echo "Retrieve module \"${MODULE_NAME}\" at \"${URL}\""
wget $URL -o /dev/null

if [ -f $MODULE ]
then
  echo "Install module..."
  tar xvzf $MODULE 2>&1 > /dev/null
  echo "Delete temp tar file..."
  rm $MODULE 2>&1 > /dev/null
  if [ -d $MODULE_NAME ]
  then
    echo "Module \"${MODULE_NAME}\" was successfully installed"
  else
    echo "Problem occured during extraction."
  fi

  if [ -f ${MODULE} ]
  then
    echo "Problem occured during deletion of temp file."
  fi
else
  echo "Problem occured during downloading."
fi

exit 0
