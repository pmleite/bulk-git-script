#!/bin/bash
#
# By.:Paulo Leite
# Ver: 1.5


# Default Values
DEFAULT_COMMIT_MSG="Commit made with bulk tool!"

# Color Values
RED='\033[0;31m'
GREEN='\033[0;32m'
OFF='\033[0m'

# Messages
STATUS_MSG="Status of the repository"
BRANCH_MSG="of branch"
PULL_MSG="Pulling repository"
PUSH_MSG="Pushing repository"
NOT_REPOSITORY_MSG="this is not a GIT repository"
WRONG_REPOSITORY_MSG="One or more parameters is/are not a GIT repository folders! For instructions Type: ./bulk-git.sh --help"
INVALID_BULK_OPERATION_MSG="Invalid bulk operation"
INVALID_FOLDER_MSG="is not a GIT respository folder"
INVALID_OPERATION_MSG="Invalid operation!"

help()
{
    clear
    echo
    printf "bulk-git is a ${RED}BASH${OFF} script, cbinary compiled that allows you\n"
    printf "to do bulk GIT operations.${OFF}\n"
    echo
    echo "How to use:"
    echo
    echo "bulk-pull [OPTIONAL] *[COMMAND] *[REPOSITORY]...[REPOSITORY] *[BRANCH]"
    echo 
    echo "OPTIONAL:"
    echo "    --bulk                Scan all folder relative to the script location"   
    echo "                          and does the bulk command indicated."
    echo
    echo "                          How to use (status example):"   
  printf "                          ${RED}bulk-git.sh --bulk --status dev${OFF}\n"
    echo                            
    echo "                          Note: all * fields are demanded, even if not used"
    echo "                          (will be fixed in the future)"
    echo 
    echo "COMMAND:"
    echo "    --status              Return the git status of the repository(ies)"
    echo "    --pull                Execute the git pull of the repository(ies)"
    echo "    --push                Execute the git push of the repository(ies)"
    echo "    --help                Show this help text" 
    echo "                          How to use (example):"   
  printf "                          ${RED}bulk-git.sh --pull [COMMAND] [BRANCH]${OFF}\n"
    echo         
    echo "REPOSITORY:"
    echo "    Repository Folder     Target folder, max 7"
  printf "                          ${RED}must be a GIT folder${OFF}\n"
    echo
    echo "BRANCH:"
    echo "    Git branch            Target branch, only used for pull but input is mandatory"
    echo 
    echo " *mandatory fields"
    echo 
}

message()
{
  echo
  case $1 in
    1)
      printf "${GREEN}$STATUS_MSG $2${OFF}:\n"
    ;;
    2)
      printf "$PULL_MSG ${GREEN}[$2]${OFF} $BRANCH_MSG ${GREEN}[$3]:${OFF}\n"
    ;;
    3)
      printf "$PUSH_MSG ${GREEN}[$2]${OFF} no branch atual${OFF}\n"
    ;;
    4)
      printf "${RED}$NOT_REPOSITORY_MSG ${OFF}\n"
    ;;
    5)
      printf "${RED}$WRONG_REPOSITORY_MSG ${OFF}\n"
    ;;
    6)
      printf "${RED}$INVALID_BULK_OPERATION_MSG ${OFF}\n"
    ;;
    7)
      printf "${RED}$2 $INVALID_FOLDER_MSG ${OFF}\n"
    ;;
    8)
      printf "${RED}$INVALID_OPERATION_MSG ${OFF}\n"
    ;;

  esac
  echo
}

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

    #Execute Bulk Operations
    "--bulk")
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
                    CHECK="$(git -C ./ rev-parse 2>/dev/null; echo $?)"
                    if [ $CHECK = "0" ]
                        then
                            git-operation $2  $PWD $CHECK ${@: -1}
                        else
                            message 7 $d
                    fi
              fi
            done
        else
        message 8 
      fi
    ;;
  esac
}



if [ $# -lt 3 ] || [ $1 = '--help' ] || [ $# -gt 9 ] 
    then
        help
        exit 1
    else
        if [ $1 = '--status' ] || [ $1 = '--pull' ] || [ $1 = '--push' ]
            then
                for ((i=2; i<=$#-1;i++));
                    do
                      if [ -d ${!i} ]
                        then
                            git-operation $1 $PWD/${!i}/ $(git -C $PWD/${!i} rev-parse 2>/dev/null; echo $?) ${!i} ${@: -1}
                        else
                            message 5
                            exit 1
                      fi
                    done
                exit 1
        fi
        if [ $1 = '--bulk' ]
            then
                git-operation $1 $2 ${@: -1}
            else
                message 8
                exit 1
        fi
fi





