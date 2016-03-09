source ~/.zplug/zplug

# 「ユーザ名/リポジトリ名」で記述し、ダブルクォートで見やすく括る（括らなくてもいい）
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

# junegunn/dotfiles にある bin の中の vimcat をコマンドとして管理する
zplug "junegunn/dotfiles", as:command, of:bin/vimcat

# tcnksm/docker-alias にある zshrc をプラグインとして管理する
# as: のデフォルトは plugin なので省力もできる
zplug "tcnksm/docker-alias", of:zshrc, as:plugin

# frozen: を指定すると全体アップデートのときアップデートしなくなる（デフォルトは0）
zplug "k4rthik/git-cal", as:command, frozen:1

# from: で特殊ケースを扱える
# gh-r を指定すると GitHub Releases から取ってくる
# of: で amd64 とかするとそれを持ってくる（指定しないかぎりOSにあったものを自動で選ぶ）
# コマンド化するときに file: でリネームできる（この例では fzf-bin を fzf にしてる）
zplug "junegunn/fzf-bin", \
    as:command, \
    from:gh-r, \
    file:fzf

# from: では gh-r の他に oh-my-zsh と gist が使える
# oh-my-zsh を指定すると oh-my-zsh のリポジトリにある plugin/ 以下を
# コマンド／プラグインとして管理することができる
zplug "plugins/git", from:oh-my-zsh

# ビルド用 hook になっていて、この例ではクローン成功時に make install する
# シェルコマンドなら何でも受け付けるので "echo OK" などでも可
zplug "tj/n", do:"make install"

# ブランチロック・リビジョンロック
# at: はブランチとタグをサポートしている
zplug "b4b4r07/enhancd", at:v1
zplug "mollifier/anyframe", commit:4c23cb60

# if: を指定すると真のときのみロードを行う（クローンはする）
zplug "hchbaw/opp.zsh", if:"(( ${ZSH_VERSION%%.*} < 5 ))"

# from: では gist を指定することができる
# gist のときもリポジトリと同様にタグを使うことができる
zplug "b4b4r07/79ee61f7c140c63d2786", \
    from:gist, \
    as:command, \
    of:get_last_pane_path.sh

# パイプで依存関係を表現できる
# 依存関係はパイプの流れのまま
# この例では emoji-cli は jq に依存する
zplug "stedolan/jq", \
    as:command, \
    file:jq, \
    from:gh-r \
    | zplug "b4b4r07/emoji-cli"

# check コマンドで未インストール項目があるかどうか verbose にチェックし
# false のとき（つまり未インストール項目がある）y/N プロンプトで
# インストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# プラグインを読み込み、コマンドにパスを通す
zplug load --verbose

function _update_ps1()
{
    export PROMPT="$(~/.zsh/powerline-zsh/powerline-zsh.py $?)"
}
precmd()
{
    _update_ps1
}
export TERM='xterm-256color'

function ks() {
  local -a arts
  arts=(
  "ヽ(｀Д´#)ﾉ ﾑｷｰ!!"
  "(#・∀・)ﾑｶｯ!!"
  "(# ﾟДﾟ) ﾑｯ!"
  "(# ﾟДﾟ) ﾑｯｶｰ"
  "(#ﾟДﾟ) ﾌﾟﾝｽｺ！"
  "(#ﾟДﾟ)y-~~ｲﾗｲﾗ"
  "(#＾ω＾)ﾋﾞｷﾋﾞｷ"
  "( ﾟдﾟ)､ﾍﾟｯ"
  "(ﾟДﾟ)ｺﾞﾙｧ!!"
  )
  local rnd=$RANDOM
  local max=`expr $#arts - 1`
  local i=`expr $rnd % $max`
  echo $arts[$i]
}

source $HOME/catkin_ws/devel/setup.zsh
source /opt/ros/indigo/setup.zsh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting