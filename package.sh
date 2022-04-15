Spec=WNPlayerPlus.podspec

PodVersion=

LintConfig=

current_path=$(
    cd "$(dirname "$0")"
    pwd
)

echo into $current_path

cd $current_path

function PodLintSpec() {

    echo "pod $PodVersion spec lint $Spec --allow-warnings $LintConfig"

    validate=$(pod $PodVersion spec lint $Spec --allow-warnings $LintConfig)

    Not_Pass_Word="The spec did not pass validation"

    result=$(echo $validate | grep "${Not_Pass_Word}")

    if [[ "$result" != "" ]]; then
        echo $validate
        exit
    fi

    echo "The spec did pass validation"
}

function PodRepoPush() {

    echo "pod $PodVersion trunk push $Spec --allow-warnings "

    Push_Result=$(pod $PodVersion trunk push $Spec --allow-warnings)

    echo $Push_Result
}

function PodRepoUpdate() {

    echo "pod $PodVersion repo  update"

    Push_Result=$(pod $PodVersion repo update)

    echo $Push_Result
}

function PodPackage() {

    echo "pod $PodVersion package $Spec --force --no-mangle"

    Package_Result=$(pod $PodVersion package $Spec --force --no-mangle)

    Configuration_Release="with configuration Release"

    result=$(echo $Package_Result | grep "${Configuration_Release}")

    if [[ "$result" != "" ]]; then
        echo "Framework Build Fail"
    else
        echo "Framework Build Success"
    fi
}

PodLintSpec
PodRepoPush
PodRepoUpdate
# PodPackage