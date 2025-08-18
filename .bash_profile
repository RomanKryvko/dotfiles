#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export TERMINAL=alacritty
export GTEST_COLOR=1
export EDITOR=vim
export PATH="$PATH:$HOME/.local/bin/:$HOME/.local/bin/scripts"
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export ANDROID_AVD_HOME=$HOME/.android/avd
export ANDROID_SDK_HOME=$HOME/.android
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
