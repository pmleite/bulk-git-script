#!/bin/bash
#
# By.:Paulo Leite
# Ver: 1.5

source ./modules/vars.sh
source ./modules/help_and_msgs.sh
source ./modules/git_operations.sh

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
                            git-operation "checkfolder" $PWD/${!i}/ $(git -C $PWD/${!i} rev-parse 2>/dev/null; echo $?) $1 ${!i} ${@: -1}
                            #REPO_FOLDER=$PWD/${!i}
                            #CHECK_REPO="$(git -C $REPO_FOLDER/ rev-parse 2>/dev/null; echo $?)"
                            # if [ $CHECK_REPO = "0" ]
                            # #If it is a GIT Repository
                            #     then
                            #         #Execute git operations
                            #         git-operation $1 ${!i} ${@: -1}
                            #     else
                            #     message 4 ${!i}
                            # fi
                        else
                        message 5
                        exit 1
                      fi
                    done
                    exit 1
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
                                        message 1 $d
                                        git -C $d status
                                    fi
                                    #Check pull
                                    if [ $2 = '--pull' ]
                                        then
                                        message 2 $d ${@: -1}
                                        git -C $d checkout ${@: -1}
                                        git -C $d pull
                                    fi
                                    #Check push
                                    if [ $2 = '--push' ]
                                        then
                                        message 3 $d
                                        git -C $d add -A
                                        git -C $d commit -m "$DEFAULT_COMMIT_MSG"
                                        git -C $d push
                                    fi
                                else
                                message 6
                                exit 1
                                fi
                            else
                            message 1 $d
                            message 7 $d
                        fi
                    done
        else
        message 8
        exit 1
        fi
fi





