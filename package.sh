current_path=$(
    cd "$(dirname "$0")"
    pwd
)

echo into $current_path

cd $current_path

echo "pod spec lint WNPlayer-ilongge.podspec --allow-warnings"
validate=$(pod spec lint WNPlayer-ilongge.podspec --allow-warnings)

Not_Pass_Word="The spec did not pass validation"

result=$(echo $validate | grep "${Not_Pass_Word}")

if [[ "$result" != "" ]]; then

    echo $Not_Pass_Word

    exit

fi

echo "The spec did pass validation"

echo "pod repo push ilonggeSpec WNPlayer-ilongge.podspec --allow-warnings"
Push_Result=$(pod repo push ilonggeSpec WNPlayer-ilongge.podspec --allow-warnings) 

echo "pod repo update ilonggeSpec"
Update_Result=$(pod repo update ilonggeSpec) 

echo "pod package WNPlayer-ilongge.podspec --force --dynamic --no-mangle"
Package_Result=$(pod package WNPlayer-ilongge.podspec --force --no-mangle) 
result=$(echo $Package_Result | grep "configuration Release")

if [[ "$result" == "" ]]; then

    echo "Framework Build Success"

fi
