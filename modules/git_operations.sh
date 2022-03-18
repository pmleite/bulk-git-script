#!/bin/bash

git-operation()
{
  case $1 in
    "--status")
      echo $3
      message 1 $2
      git -C $2 status
    ;;
    "--pull")
      echo $3
      message 2 $2 $5
      git -C $2 checkout $5
      git -C $2 pull
    ;;
    "--push")
      echo $3
      message 3 $2 $5
      git -C $2 add -A 
      git -C $2 commit -m "$DEFAULT_COMMIT_MSG"
      git -C $2 push
    ;;
    "--bulk")
      echo $1 $2 $3 $4 $5
      for d in */
        do
          echo $d
        done

    ;;
  esac
}