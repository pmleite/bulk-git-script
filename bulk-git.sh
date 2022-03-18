#!/bin/bash
#
# By.:Paulo Leite
# Ver: 1.5
#
#

source ./modules/env.sh
source ./modules/help_and_msgs.sh


if [ $# -lt 3 ] || [ $1 = '--help' ] || [ $# -gt 9 ] 
    then
        help
#       exit 1
    else
        if [ $1 = '--status' ] || [ $1 = '--pull' ] || [ $1 = '--push' ]
            then
                for ((i=2; i<=PARAM_NUMB-1;i++));
                    do
                      #check if folder exists
                      if [ -d ${!i} ]
                        then
                        #Check if it is a GIT Folder
                            REPO_FOLDER=$PWD/${!i}
                            CHECK_REPO="$(git -C $REPO_FOLDER/ rev-parse 2>/dev/null; echo $?)"
                            if [ $CHECK_REPO = "0" ]
                            #If it is a GIT Repository
                                then
                                    #Check Status
                                    if [ $1 = '--status' ]
                                        then
                                        message 1 ${!i}
                                        git -C ./${!i} status
                                    fi
                                    #Check pull
                                    if [ $1 = '--pull' ]
                                        then
                                        message 2 ${!i} ${@: -1}
                                        git -C ./${!i} checkout ${@: -1}
                                        git -C ./${!i} pull
                                    fi
                                    #Check push
                                    if [ $1 = '--push' ]
                                        then
                                        message 3 ${!i} ${@: -1}
                                        git -C ./${!i} add -A
                                        git -C ./${!i} commit -m "$DEFAULT_COMMIT_MSG"
                                        git -C ./${!i} push
                                    fi
                                else
                                message 4 ${!i}
                            fi
                        else
                        echo
                        printf "${RED}Repositório(s) errado(s), digite ./bulk-git.sh --help  para aceder à ajuda${OFF}\n"
                        exit 1
                      fi
                    done
        fi
        #Operação Bulk
        if [ $1 = '--bulk' ]
            then
                for d in */
                    do
                        REPO_FOLDER=$PWD/$d
                        CHECK_REPO="$(git -C $REPO_FOLDER/ rev-parse 2>/dev/null; echo $?)"
                        if [ $CHECK_REPO = "0" ]
                            then
                                if [ $2 = '--status' ] || [ $2 = '--pull' ] || [ $2 = '--push' ]
                                    then
                                    #Check Status
                                    if [ $2 = '--status' ]
                                        then
                                        echo 
                                        printf "${GREEN}Status do repositório - $d${OFF}:\n"
                                        git -C $d status
                                    fi
                                    #Check pull
                                    if [ $2 = '--pull' ]
                                        then
                                        echo 
                                        printf "Pull do repositório ${GREEN}[$d]${OFF} branch ${GREEN}[${@: -1}]:${OFF}\n"
                                        git -C $d checkout ${@: -1}
                                        git -C $d pull
                                    fi
                                    #Check push
                                    if [ $2 = '--push' ]
                                        then
                                        echo 
                                        printf "Push do repositório ${GREEN}[$d]${OFF} no branch atual:${OFF}\n"
                                        git -C $d add -A
                                        git -C $d commit -m "$DEFAULT_COMMIT_MSG"
                                        git -C $d push
                                    fi
                                else
                                printf "${RED}Operacao inválida!!"
                                echo
                                exit 1
                                fi
                            else
                            echo
                            printf "${GREEN}Status do repositório - $d${OFF}:\n"
                            printf "${RED}A pasta $d não é um respositório${OFF}:\n"
                            echo
                        fi
                    done
        else
        printf "${RED}Operacao inválida!!"
        echo
        exit 1
        fi
fi





