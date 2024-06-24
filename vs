CODE_SERVER_HASH=dc96b837cf6bb4af9cd736aa3af08cf8279f7685
FOLDER="$HOME/.vscode-server"
mkdir -p $FOLDER
FILEPATH="$FOLDER/vscode-cli-$CODE_SERVER_HASH.tar.gz"
curl -L -o $FILEPATH "https://update.code.visualstudio.com/commit:${CODE_SERVER_HASH}/cli-alpine-x64/stable" &&
echo finished > $FILEPATH.done
tar -xf $FOLDER/vscode-cli-$CODE_SERVER_HASH.tar.gz -C $FOLDER
mv $FOLDER/code $FOLDER/code-$CODE_SERVER_HASH

CODESERVER_FILEPATH=$FOLDER/cli/servers/Stable-$CODE_SERVER_HASH
mkdir -p $CODESERVER_FILEPATH
curl -L -o $CODESERVER_FILEPATH/stable.tar.gz "https://update.code.visualstudio.com/commit:${CODE_SERVER_HASH}/server-linux-x64/stable" 
tar -xf $CODESERVER_FILEPATH/stable.tar.gz -C $CODESERVER_FILEPATH
mv $CODESERVER_FILEPATH/vscode-server-linux-x64 $CODESERVER_FILEPATH/server
rm $CODESERVER_FILEPATH/stable.tar.gz

