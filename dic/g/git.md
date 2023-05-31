# Git(GitHub)

- git 레포지터리와 로컬을 비교해서 다른 경우 가져오는 스크립트
```sh
reponame="lowyrepo"
env="lowybranch"

git fetch
HEADHASH=$(git rev-parse HEAD)
UPSTREAMHASH=$(git rev-parse $1@{upstream})

if [ "$HEADHASH" == "$UPSTREAMHASH" ]
then
    echo -e ${ERROR}Not up to date with ${reponame} ${env}. Aborting.${NOCOLOR}
    echo
    rst="UPSTREAMHASH:${UPSTREAMHASH}"
else
    rst="UPSTREAMHASH:${UPSTREAMHASH}"
    echo "git changed!"
    echo "HEADHASH : ${HEADHASH}"
    echo "UPSTREAMHASH : ${UPSTREAMHASH}"

    git pull origin ${env}
    # 서버 쪽 소스가 바뀌어서 git에서 다시 덮어야 할 경우
    git pull origin ${env} --rebase
    # 최신임에도 hash가 달라진 경우 강제로 맞추기
    git reset --hard origin/${env}

fi
```
