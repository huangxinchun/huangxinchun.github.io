#!/bin/bash
message=$1

if [$message == ""] ;then
echo "请输入commit 参数"
exit
fi

#博客地址
hxc_path="../../huangxinchun.github.io"
images_path="../images"

echo "更新本地"

git add ./
git commit -m "$message"
git push

echo "更新完成"
cp -R $images_path $hxc_path

cd "$hxc_path/images"

echo "更新图片"

git add ./
git commit -m "$message"
git push
echo "图片更新完成"

