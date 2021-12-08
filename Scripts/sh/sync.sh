#!/usr/bin/env bash
# shellcheck disable=SC2034,2154,2188

<<'COMMENT'
cron: 32 6,18 * * *
new Env('自用更新');
COMMENT

## 导入通用变量与函数
dir_shell=/ql/shell
. $dir_shell/share.sh

file_config_config=$dir_config/config.sh
file_config_update=$dir_config/Update.sh

echo "ql check" >> $file_config_extra
echo "
if [[ $(date "+%-H") -eq 0 || $(date "+%-H") -eq 8 || $(date "+%-H") -eq 16 ]] && [ $(date "+%-M") -eq 0 ] && [ $(date "+%-S") -gt 4 ]; then
  export JD_JOY_REWARD_NAME="20"
else
  export JD_JOY_REWARD_NAME="500"
fi
" >>$file_config_config

update_update() {
    curl -sL https://cdn.jsdelivr.net/gh/Oreomeow/VIP@main/Scripts/sh/Update.sh >"$file_config_update"
    sed -i "/openCardBean/d" "$file_config_update"
    sed -i "s/CollectedRepo=(4)/CollectedRepo=(4)/" "$file_config_update"
    sed -i "s/OtherRepo=()/OtherRepo=(3 5 6 9 10)/" "$file_config_update"
    sed -i "s/RawScript=(1 2)/RawScript=(1 2)/" "$file_config_update"
    sed -i "s/repo=\$repo4/repo=\$repo4/" "$file_config_update"
}

update_update

cat >>$file_config_update <<-EOF
echo "ql check" >> \$file_config_extra
echo "
if [[ $(date "+%-H") -eq 0 || $(date "+%-H") -eq 8 || $(date "+%-H") -eq 16 ]] && [ $(date "+%-M") -eq 0 ] && [ $(date "+%-S") -gt 4 ]; then
  export JD_JOY_REWARD_NAME="20"
else
  export JD_JOY_REWARD_NAME="500"
fi
EOF

task /ql/config/Update.sh
