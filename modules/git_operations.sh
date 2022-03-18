#!/bin/bash

git-operation()
{
  case $1 in
    #Execute Status Operation
    "--status")
    if [ $3 = "0" ]
      then
        message 1 $2
        git -C $2 status
      else  
        message 7 $2 
    fi
    ;;

    #Execute Pull Operation
    "--pull")
    if [ $3 = "0" ]
      then
        message 2 $2 $5
        git -C $2 checkout $5
        git -C $2 pull
      else
        message 7 $2
    fi
    ;;

    #Execute Push Operation
    "--push")
    if [ $3 = "0" ]
      then
        message 3 $2 $5
        git -C $2 add -A 
        git -C $2 commit -m "$DEFAULT_COMMIT_MSG"
        git -C $2 push
      else
        message 7 $2
    fi
    ;;

    #Execute Bulk Operation
    "--bulk")
      echo $1 $2 $3
      if [ $2 = '--status' ] || [ $2 = '--pull' ] || [ $2 = '--push' ]
        then
          for d in */
            do
              CHECK="$(git -C $d/ rev-parse 2>/dev/null; echo $?)"
              if [ $CHECK = "0" ]
                then
                  echo $d
                  git-operation $2  $PWD/$d $CHECK ${@: -1}
                else
                  echo error!
              fi
            done
        else
        message 8 
      fi
    ;;

  esac
}