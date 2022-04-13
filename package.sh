
Spec=WNPlayerPlus.podspec

current_path=$(
    cd "$(dirname "$0")"
    pwd
)

echo into $current_path

cd $current_path

echo "pod spec lint $Spec --allow-warnings"
validate=$(pod spec lint WNPlayer-ilongge.podspec --allow-warnings)

Not_Pass_Word="The spec did not pass validation"

result=$(echo $validate | grep "${Not_Pass_Word}")

if [[ "$result" != "" ]]; then
    echo $Not_Pass_Word
    exit
fi

echo "The spec did pass validation"

#echo "pod trunk push --allow-warnings $Spec"
#Push_Result=$(pod trunk push --allow-warnings WNPlayer-ilongge.podspec)
#
#echo "pod package $Spec --force --no-mangle"
#Package_Result=$(pod package WNPlayer-ilongge.podspec --force --no-mangle)
#Configuration_Release= "with configuration Release"
#result=$(echo $Package_Result | grep "${Configuration_Release}")
#if [[ "$result" != "" ]]; then
#    echo "Framework Build Fail"
#else
#    echo "Framework Build Success"
#fi
