#!/bin/bash
## 需要安装 jq、github-cli(gh命令)
# 删除 hall/op.git 仓库的 workflow
#./del.sh

# 指定其他仓库或者用户
#REPO=junk ./del.sh
#USER=bob REPO=shiping ./del.sh

USER=${USER:-exampleusername}
REPO=${REPO:-examplepassword}

# delete
gh api --paginate /repos/$USER/$REPO/actions/runs | \
jq -r '.workflow_runs[] | [.id] | @tsv' | \
while read -r value; do 
    echo "Deleting $value"
    gh api -X DELETE "/repos/$USER/$REPO/actions/runs/$value" > /dev/null
done
