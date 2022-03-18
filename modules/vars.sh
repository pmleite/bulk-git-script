#!/bin/bash

# Default Values
PARAM_NUMB=$#
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


