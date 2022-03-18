#!/bin/bash

git-operation()
{
  case $1 in
    "--status")
      message 1 $2
      git -C $2 status
    ;;
    "--pull")
      message 2 $2 $5
      git -C $2 checkout $5
      git -C $2 pull
    ;;
    "--push")
      message 3 $2 $5
      git -C $2 add -A 
      git -C $2 commit -m "$DEFAULT_COMMIT_MSG"
      git -C $2 push
    ;;
    "checkfolder")
      if [ $3 = "0" ]
        then
         git-operation $4 $5 $6
        else
         message 4 $5
      fi
    ;;
    "--bulk")
      echo $1 $2 $3 $4 $5 $6
      for d in */
        do
          echo $d
        done

    ;;
  esac
}