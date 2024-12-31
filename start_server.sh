#!/bin/bash
set -xe

# 检查是否存在 DedicatedServer
if [ -f "${GAMEDIR}/DedicatedServer" ]; then
    steamcmd @ShutdownOnFailedCommand @NoPromptForPassword +login anonymous +app_update ${STEAMAPPID} +'quit'
else
    steamcmd @ShutdownOnFailedCommand @NoPromptForPassword +login anonymous +app_update ${STEAMAPPID} validate +'quit'
fi

# 创建必要的目录结构
mkdir -p "${GAMEDIR}/Daedalic Entertainment GmbH/Barotrauma/Multiplayer"
mkdir -p "${FIX_PATH}/Daedalic Entertainment GmbH"

# 创建符号链接修复路径问题
if [ ! -L "${FIX_LINKPATH}" ]; then
    ln -s "${FIX_PATH}" "${FIX_LINKPATH}"
fi

# 启动 DedicatedServer
exec "${GAMEDIR}/DedicatedServer"
