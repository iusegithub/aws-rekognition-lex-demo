#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
__dirname="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export AWS_PROFILE=$(node -e "console.log(JSON.stringify(require('$__dirname'+'/../config')))" | $(npm bin)/jq --raw-output ".profile")
export AWS_DEFAULT_REGION=$(node -e "console.log(JSON.stringify(require('$__dirname'+'/../config')))" | $(npm bin)/jq --raw-output ".region")


BUCKET=$($__dirname/exports.js | $(npm bin)/jq --raw-output '."QNA-BOOTSTRAP-BUCKET"')
PREFIX=$($__dirname/exports.js | $(npm bin)/jq --raw-output '."QNA-BOOTSTRAP-PREFIX"')
BLUE=$(tput setaf 4)
RESET=$(tput sgr0)
echo bootstrap bucket is $BLUE$BUCKET/$PREFIX$RESET

aws s3 sync $__dirname/../build/ s3://$BUCKET/$PREFIX/ --delete  


