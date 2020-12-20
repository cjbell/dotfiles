[ -d "$HOME/Library/Android/sdk" ] && ANDROID_SDK=$HOME/Library/Android/sdk || ANDROID_SDK=$HOME/Android/Sdk

export ANDROID_SDK=$ANDROID_SDK
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
