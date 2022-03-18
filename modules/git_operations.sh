#!/bin/bash

git-operation()
{
  case $1 in
    "--status")
      message 1 $2
      git -C ./$2 status
    ;;
    "--pull")
      message 2 $2 $3
      git -C ./$2 checkout $3
      git -C ./$2 pull
    ;;
    "--push")
      message 3 $2 $3
      git -C ./$2 add -A 
      git -C ./$2 commit -m "$DEFAULT_COMMIT_MSG"
      git -C ./$2 push
    ;;
  esac
}