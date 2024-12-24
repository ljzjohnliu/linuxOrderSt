#!/bin/bash

libtest_version=""
vc1_version=""
vc2dec_version=""
base_branch=""
target_branch=""

longOpts=`getopt --long libtest:,libvc1dec:,libvc2dec:,bvc2:,bb:`

eval "${longOpts}"

while true
do
	case "$1" in
		--libtest)
			echo "update libtest: $2"
			libtest_version=$2
			shift 2
			;;
		--libvc1dec)
			echo "update libvc1dec: $2"
			vc1_version=$2
			shift 2
			;;
		--libvc2dec)
			echo "update libvc2dec: $2"
			vc2dec_version=$2
			shift 2
			;;
		--bb)
			echo "base branch: $2"
			base_branch=$2
			shift 2
			;;
			# todo -h
		*)
			shift
			break
			;;	
	esac
done


if [[ $base_branch == "" ]]; then
	echo "error: must have a base branch!"
 	exit 1
else
	target_branch="autopack/$base_branch"
fi

if [[ $libtest_version == "" ]]&&[[ $vc1_version == "" ]]&&[[ $vc2dec_version == "" ]]; then
	echo "error: libtest/libvc1dec/libvc2dec must have a version!"
 	exit 1
fi


if [[ $libtest_version != "" ]]; then
	version=`echo $libtest_version | sed "s/\./_/g"`
	target_branch="${target_branch}_libtest_${version}"
fi

if [[ $vc1_version != "" ]]; then
	version=`echo $vc1_version | sed "s/\./_/g"`
	target_branch="${target_branch}_bvc1dec_${version}"
fi

if [[ $vc2dec_version != "" ]]; then
	version=`echo $vc2dec_version | sed "s/\./_/g"`
	target_branch="${target_branch}_bvc2dec_${version}"
fi


echo "------args begin------"
echo "libtest_version: $libtest_version"
echo "libvc1dec_version: $vc1_version"
echo "vc2dec_version: $vc2dec_version"
echo "base_branch: $base_branch"
echo "target_branch: $target_branch"
echo "------args end------"


SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR
pwd


git checkout . && git clean -df
git checkout $target_branch
if [[ $? -ne 0 ]]; then
	git checkout $base_branch
	git checkout -b $target_branch
fi


if [[ $libtest_version != "" ]]; then
  sed -i '' "s/\(TEST_VERSION =\) *.*.*/\1 ${libtest_version}/" ./gradle.properties
fi

if [[ $vc1_version != "" ]]; then
  sed -i '' "s/\(VC1_DEC_VERSION =\) *.*.*/\1 ${vc1_version}/" ./gradle.properties
fi

if [[ $vc2dec_version != "" ]]; then
  sed -i '' "s/\(VC2_DEC_VERSION =\) *.*.*/\1 ${vc2dec_version}/" ./gradle.properties
fi


echo "auto update: libtest_version -> ${libtest_version} libvc1dec -> ${vc1_version} vc2dec_version -> ${vc2dec_version}"

git add .
git commit -m "auto update: libtest_version -> ${libtest_version} libvc1dec -> ${vc1_version} vc2dec_version -> ${vc2dec_version}"
git push origin -u $target_branch:$target_branch

echo "done"
echo "pack demo on: demo url"
echo "pack target branch: $target_branch"
