# 一、自助修改版本号脚本
后续图片底层解码库在业务的升级比较频繁，每次升级需要在图片库侧回归，手动打包效率太低
可以使用脚本update_version.sh完成
## 使用说明
sh script_tool/update_version.sh --bb dev --libtest 1.1.1 --libvc1dec 1.1.2 --libvc2dec 1.1.3  
## 参数说明：
--bb               基于哪个分支打包，如 dev  
--libtest        libttheif_ios库更新后的版本号，如 1.1.1  
--libvc1dec      libvc1dec库更新后的版本号，如 1.1.2  
--libvc2dec      libvc2dec库更新后的版本号，如 1.1.3  

# 二、批量处理url脚本
批量给url添加引号操作，手动处理效率低，可用脚本完成
## 使用说明
./script_tool/to_oc_url.sh url.txt
## 参数说明
  url.txt是待处理的文件  

# 三、编译脚本
./script_tool/ibuild.sh