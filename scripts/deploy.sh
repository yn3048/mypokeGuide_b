#!/bin/bash
PROJECT_NAME="PokeGuide"
BUILD_JAR=$(ls /home/$PROJECT_NAME/build/libs/*.jar)
JAR_NAME=$(basename $BUILD_JAR)
echo "> build 파일명: $JAR_NAME" >> /home/$PROJECT_NAME/deploy.log

echo "> build 파일 복사" >> /home/$PROJECT_NAME/deploy.log
DEPLOY_PATH=/home/$PROJECT_NAME/
cp $BUILD_JAR $DEPLOY_PATH

echo "> 현재 실행중인 애플리케이션 pid 확인" >> /home/$PROJECT_NAME/deploy.log
CURRENT_PID=$(pgrep -f $JAR_NAME)

if [ -z $CURRENT_PID ]
then
  echo "> 현재 구동중인 애플리케이션이 없으므로 종료하지 않습니다." >> /home/$PROJECT_NAME/deploy.log
else
  echo "> kill -15 $CURRENT_PID"
  kill -15 $CURRENT_PID
  sleep 5
fi

DEPLOY_JAR=$DEPLOY_PATH$JAR_NAME
echo "> DEPLOY_JAR 배포"    >> /home/$PROJECT_NAME/deploy.log
nohup java -jar $DEPLOY_JAR >> /home/$PROJECT_NAME/deploy.log 2>/home/$PROJECT_NAME/deploy_err.log &