#!/bin/bash

abort()
{
    MESSAGE=$1

    if ! [[ "$MESSAGE" == "" ]];
    then
        echo -e "${MESSAGE}\n"
    fi

    exit 1
}


if [[ "$2" == "" ]] || [[ "$1" == "" ]];
then
    abort "Usage: init.sh <app name> <package>\n"
fi


APP_NAME=$1
PACKAGE=$2
PROJECT_PATH=$(realpath $(dirname $0))

PACKAGE_PATH=$(echo "$PACKAGE" | sed 's/\./\//g')


if [[ -d "app/src/main/java/$PACKAGE_PATH" ]];
then
    abort "This project is ready."
fi


echo -e "Ready for initializing project"
echo -e "------------------------------"
echo "App name: $APP_NAME"
echo "Package: $PACKAGE"
echo "Package path: $PACKAGE_PATH"
echo ""
echo "Files to patch: "


echo ""
read -p "Press ENTER to proceed. Ctrl-C to abort."
echo ""


mkdir -p "$PROJECT_PATH/app/src/androidTest/java/$PACKAGE_PATH"
mkdir -p "$PROJECT_PATH/app/src/main/java/$PACKAGE_PATH"
mkdir -p "$PROJECT_PATH/app/src/test/java/$PACKAGE_PATH"

cp -ru "$PROJECT_PATH/app/src/androidTest/java/.template/"* \
       "$PROJECT_PATH/app/src/androidTest/java/$PACKAGE_PATH/"

cp -ru "$PROJECT_PATH/app/src/main/java/.template/"* \
       "$PROJECT_PATH/app/src/main/java/$PACKAGE_PATH/"

cp -ru "$PROJECT_PATH/app/src/test/java/.template/"* \
       "$PROJECT_PATH/app/src/test/java/$PACKAGE_PATH/"

echo -e "- Project structure created."


echo -e "- Patching files..."

for file in $(find "${PROJECT_PATH}/app/"** -type f -name "*.kt*");
do
    sed -i "s/BaseWebApp/$APP_NAME/g" "$file"
    sed -i "s/me.android.basewebapp/$PACKAGE/g" "$file"
done

for file in $(find "${PROJECT_PATH}/app/"** -type f -name "*.xml");
do
    sed -i "s/BaseWebApp/$APP_NAME/g" "$file"
    sed -i "s/me.android.basewebapp/$PACKAGE/g" "$file"
done

if [[ -f "$PROJECT_PATH/.idea/workspace.xml" ]];
then
    sed -i "s/BaseWebApp/$APP_NAME/g" "$PROJECT_PATH/.idea/workspace.xml"
fi

sed -i "s/BaseWebApp/$APP_NAME/g" "$PROJECT_PATH/settings.gradle.kts"


echo "Done."
echo ""
