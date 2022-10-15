#!/bin/bash

rm -f web config.json
wget -N https://raw.githubusercontent.com/bhqz/Alwaysdata-vmess-vless-trojan-/main/web
chmod +x ./web

if [[ -z $id ]]; then
    id="36effc45-7129-450b-ac23-0dd481b1a804"
fi

cat <<EOF > ~/config.json
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$id"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

./web -config=config.json
