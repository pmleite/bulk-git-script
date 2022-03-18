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
        exit 1
    else
        if [ $1 = '--status' ] || [ $1 = '--pull' ] || [ $1 = '--push' ]
            then
                for ((i=2; i<=PARAM_NUMB-1;i++));
                    do
                      #check if folder exists
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
        #Operação Bulk
        if [ $1 = '--bulk' ]
            then
                git-operation $1 $2 ${@: -1}
            else
                message 8
                exit 1
        fi
fi





