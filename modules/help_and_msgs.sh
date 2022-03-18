#!/bin/bash
#
#

STATUS_MSG="Status of the repository"
BRANCH_MSG="of branch"
PULL_MSG="Pulling repository"
PUSH_MSG="Pushing repository"
NOT_REPOSITORY_MSG="this is not a GIT repository"


help()
{
    clear
    echo
    printf "bulk-git.sh is a ${RED}BASH${OFF} script that allows to do bulk GIT operations\n"
    printf "in multiple repositories simultaneously.${OFF}\n"
    echo
    echo "How to use:"
    echo
    echo "bulk-pull [OPTIONAL] *[COMMAND] *[REPOSITORY]...[REPOSITORY] *[BRANCH]"
    echo 
    echo "OPTIONAL:"
    echo "    --bulk                Scan all folder relative to the script location"   
    echo "                          and does the bulk comand indicated."
    echo
    echo "                          How to use (status example):"   
  printf "                          ${RED}./bulk-git.sh --bulk --status dev${OFF}\n"
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
  printf "                          ${RED}./bulk-git.sh --pull [COMMAND] [BRANCH]${OFF}\n"
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
      printf "${RED} $NOT_REPOSITORY_MSGY ${OFF}\n"
    ;;
  esac
  echo
}