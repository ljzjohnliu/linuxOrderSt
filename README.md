#背景
后续图片底层解码库在业务的升级比较频繁，每次升级需要在图片库侧回归，手动打包效率太低
update_version.sh
#使用说明
##脚本位置
根目录下update_version.sh
##脚本使用
sh update_version.sh --bb dev --libtest 1.1.1 --libvc1dec 1.1.2 --libvc2dec 1.1.3
##参数说明：
--bb               基于哪个分支打包，如 dev
--libtest        libttheif_ios库更新后的版本号，如 1.1.1
--libvc1dec      libvc1dec库更新后的版本号，如 1.1.2
--libvc2dec      libvc2dec库更新后的版本号，如 1.1.3
