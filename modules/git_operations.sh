#!/bin/bash

git-operation()
{
  case $1 in
    "--status")
      message 1 $3
      git -C $3 status
    ;;
    "--pull")
      message 2 $3 $6
      git -C $3 checkout $6
      git -C $3 pull
    ;;
    "--push")
      message 3 $3 $6
      git -C $3 add -A 
      git -C $3 commit -m "$DEFAULT_COMMIT_MSG"
      git -C $3 push
    ;;
    "checkfolder")
      echo $1 $2 $3 $4 $5 $6
      if [ $3 = "0" ]
        then
         git-operation $4 $5 $6
        else
         message 4 $5
      fi
    ;;
  esac
}