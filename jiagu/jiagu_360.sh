#!/bin/bash

#jiagu.jar的路径
BASE=../../jiagu/jiagu.jar
NAME=17076612166
PASSWORD=360-123456
#key的路径
KEY_PATH=../../app/epointkey.jks
KEY_PASSWORD=123456
#别名
ALIAS=alad
#别名密码
ALIAS_PASSWORD=123456
#自定义渠道列表
CHANNEL=../../jiagu/_360channel.txt
#需要加固的apk
APK=../../app/build/outputs/apk/app-release.apk
#apk输出路径
DEST=../../app/build/outputs/apk/
SDK_PATH=D\:\\AndroidStudio\\LocalSDK\\build-tools\\25.0.2
#walle输出路径
#WALLE_PATH=../../XXXXXX
#对齐后的apk路径
ZIP_PATH=${DEST}zip.apk
#加固后输出的apk路径
JIAGU_PATH=../../app/




echo "------ jiagu running! ------"

java -jar ${BASE} -version
java -jar ${BASE} -login ${NAME} ${PASSWORD}
java -jar ${BASE} -importsign ${KEY_PATH} ${KEY_PASSWORD} ${ALIAS} ${ALIAS_PASSWORD}
java -jar ${BASE} -showsign
#java -jar ${BASE} -importmulpkg ${CHANNEL} #根据自身情况使用
java -jar ${BASE} -showmulpkg
java -jar ${BASE} -showconfig
java -jar ${BASE} -jiagu ${APK} ${DEST} #-autosign

echo "------ jiagu finished! ------"


echo "------ output file start------"
for file_a in ${DEST}/*; do
    temp_file=`basename $file_a`
    if [[ $temp_file == *"jiagu"*.apk ]];then
        JIAGU_PATH=${DEST}$temp_file
        echo "find it "${JIAGU_PATH}
        echo $temp_file
        break
    fi
    echo $temp_file
done
echo "------ output file finish ------"


echo "------ zipalign running! ------"
${SDK_PATH}/zipalign -v 4 ${JIAGU_PATH} ${ZIP_PATH}
echo "------ zipalign finished! ------"

echo "------ signer running! ------"
${SDK_PATH}/apksigner sign --ks ${KEY_PATH} ${ZIP_PATH} <<EOF
${KEY_PASSWORD}
EOF
echo "------ signer finished! ------"