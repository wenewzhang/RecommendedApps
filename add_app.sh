#!/bin/bash

JSON_FILE="RecommendedApps.json"

# 初始化 JSON 文件（如果不存在）
if [[ ! -f "$JSON_FILE" ]]; then
    echo '[]' > "$JSON_FILE"
fi

# 读取输入
read -rp "请输入应用名称 (name): " name
read -rp "请输入应用链接 (url): " url
read -rp "请输入图标链接 (icon_url): " icon_url
read -rp "请输入 Star 数 (stars): " stars
read -rp "请输入应用描述 (description): " description
read -rp "请输入中文描述 (cn_description): " cn_description

# 构造 JSON 对象
new_item=$(jq -n \
    --arg name "$name" \
    --arg url "$url" \
    --arg icon_url "$icon_url" \
    --arg stars "$stars" \
    --arg description "$description" \
    --arg cn_description "$cn_description" \
    '{
        name: $name,
        url: $url,
        icon_url: $icon_url,
        stars: $stars,
        description: $description,
        cn_description: $cn_description
    }')

# 追加到 JSON 数组
jq --argjson item "$new_item" '. + [$item]' "$JSON_FILE" > "${JSON_FILE}.tmp" && mv "${JSON_FILE}.tmp" "$JSON_FILE"

echo "✅ 已保存到 $JSON_FILE"
cat "$JSON_FILE" | jq .
