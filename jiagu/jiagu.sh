#!/bin/bash

BASE=../jiagu/jiagu.jar
NAME=17076612166
PASSWORD=360-123456
KEY_PATH=../../app/keystore/epointkey.jks
KEY_PASSWORD=123456
ALIAS=alad
ALIAS_PASSWORD=123456

APK=../../app/build/outputs/apk/app-release.apk   #需要加固的apk路径
DEST=../../app/build/outputs/apk/  #输出加固包路径

echo "------ running! ------"

java -jar ${BASE} -version
java -jar ${BASE} -login ${NAME} ${PASSWORD}
java -jar ${BASE} -importsign ${KEY_PATH} ${KEY_PASSWORD} ${ALIAS} ${ALIAS_PASSWORD}
java -jar ${BASE} -showsign
#java -jar ${BASE}/jiagu.jar -importmulpkg ${BASE}/多渠道模板.txt #根据自身情况使用
#java -jar ${BASE} -showmulpkg
java -java ${BASE} -config -x86  //配置支持X86
java -jar ${BASE} -showconfig
java -jar ${BASE} -jiagu ${APK} ${DEST} -autosign

echo "------ finished! ------"

#-login          <username>                    首次使用必须先登录 <360用户名>
#                <password>                    <登录密码>

#-importsign     <keystore_path>               导入签名信息 <密钥路径>
#                <keystore_password>           <密钥密码>
#                <alias>                       <别名>
#                <alias_password>              <别名密码>

#-importmulpkg   <mulpkg_filepath>             导入多渠道配置信息，txt格式
#-showsign                                     查看已配置的签名信息
#-showmulpkg                                   查看已配置的多渠道信息
#-help                                         显示帮助信息

#-config         [-update]                     配置加固可选项 【升级通知】
#                [-crashlog]                  【崩溃日志】
#                [-x86]                       【x86支持】

#-showconfig                                   显示已配置加固项
#-version                                      显示当前版本号
#-update                                       升级到最新版本

#-jiagu          <inputAPKpath>                加固命令 <APK路径>
#                <outputPath>                  <输出路径>
#                [-autosign]                  【自动签名】
#                [-automulpkg]                【自动多渠道】
#                [-pkgparam mulpkg_filepath]  【自定义文件生成多渠道】