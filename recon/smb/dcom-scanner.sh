#!/bin/bash
# Quick wrapper to
SCRIPT_DIR=$(dirname $0)
cd ${SCRIPT_DIR}

if [ -z ${1} ]; then
    echo "Usage: ${0} <address>"
    exit
fi

[ ! -e './dcom-scanner' ] && echo "[-] First compile binary, run make" && exit

./dcom-scanner ${1} >/dev/null 2>&1
sc=$?

[ $sc == 0 ] && echo "[-] ${1} - Not vulerable"
[ $sc == 1 ] && echo "[-] ${1} - Does not accept DCE RPC protocol (connection refused)"
[ $sc == 2 ] && echo "[-] ${1} - No response (filtering DCOM port, or not there)"
[ $sc == 3 ] && echo "[+] ${1} - Vulnerable to dcom 1 and dcom2"
[ $sc == 4 ] && echo "[+ ${1} - Vulnerable to dcom 2 (but patched for dcom1)"
[ $sc == 255 ] && echo "[-] ${1} - Not vulnerable"
