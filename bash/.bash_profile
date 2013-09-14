# ALIASES FTW
alias ll='ls -Fla'
alias b='bundle'
alias be='bundle exec'
alias bed='bundle exec deploy && notify "deploy complete"'
alias bedable='bundle exec deployable'
alias silent-deploy='cap staging2 deploy:upload FILES=app/path/to/file/you/keep/changing.rb'
alias bepr='bundle exec pull-request'
alias benb='bundle exec new-branch'
alias g='git'
alias s='rails s'
alias stat_s='CACHE_CLASSES=1 s -p 3001'
alias ns='npm start'
alias nsw='npm run-script watch'
alias powup='powder up'
alias powdown='powder down'
alias powre='powder restart'
alias rmorig='find . -name '\''*.orig'\'' | xargs rm'
alias assets='be rake asset:packager:build_all'
alias sa1-restart='bundle exec cap staging2 deploy:restart'
alias sa2-restart='bundle exec cap staging2 deploy:restart'
alias gr='grunt && notify "grunt done"'
alias gw='grunt watch'
alias grt='grunt test && notify "tests done"'
alias grd='grunt dev && notify "grunt dev done"'
alias grn='grunt dev && npm run-script watch'
alias hdeploy='git push heroku master'
alias mm='be sync-branch'
alias stage='be stage-up && bed && 1'
alias besu='be stage-up'
alias qa='be qaready'
alias snui='b u sport_ngin_ui'
alias signoff='be signoff'
alias notify='terminal-notifier -message'

# Git shortcuts

alias ga='git add'
alias gaa='git add -A'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gcm='git commit -m'
alias gcma='git commit -am'
alias gb='git branch'
alias gbr='git branch -r'
alias gco='git checkout'
alias go='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gf='git fetch'
alias gmm='be sync-branch'
alias gst='git stash'
alias gstp='git stash pop'
alias new-branch=new-branch

new-branch(){ git checkout -b $1 && git push --set-upstream origin $1; }

complete -o default -o nospace -F _git g

# homebrew completion files for installed libraries
[ -f `brew --prefix`/etc/bash_completion ] && . `brew --prefix`/etc/bash_completion

# homebrew completion files for installed libraries
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

export PS1="\e[36;40m\W\e[0m \e[35;40m\$(__git_ps1 ' (%s)') \e[0m\]\n\$ "

# for more info, http://git.kernel.org/?p=git/git.git;a=blob;f=contrib/completion/git-completion.bash;hb=HEAD
# __git_ps1 flags
# show * if there are untracked changes and + if staged and uncommitted changes
export GIT_PS1_SHOWDIRTYSTATE=1
# show $ if there are stashed changes
export GIT_PS1_SHOWSTASHSTATE=1
# show % if there are untracked files
export GIT_PS1_SHOWUNTRACKEDFILES=1
# show < if there are unpulled changes, > if there are unpushed changes, or <> if there are both
export GIT_PS1_SHOWUPSTREAM=1

export AUTOMATION_GITHUB_USER=kevinmarx
export AUTOMATION_GITHUB_TOKEN=33b8f154b1f27b61d038913a84d3a1962b3845ff

# This loads RVM into a shell session.
[[ -s '/Users/kevinmarx/.rvm/scripts/rvm' ]] && . '/Users/kevinmarx/.rvm/scripts/rvm'

# Add our custom MySQL to the $PATH
export PATH=/usr/local/mysql/bin:$PATH


# Add Homebrew the $PATH
export PATH=/usr/local/bin:$PATH

# add locally installed NPM modules to your $PATH
export PATH=./node_modules/.bin:$PATH

export EDITOR='subl -w'


# solves issues with rake having mismatched versions with what Gemfile.lock expects
rake() {
  if [[ -e ./Gemfile ]] && which bundle; then
    bundle exec rake "$@"
  else
    command rake "$@"
  fi
}


# `work foo` to navigate to SHARED_WORKSPACE/foo.
work() {
  dir=$(workspace)
  cd "$dir/${1}"
}

# Used by work() and _work() to determine workspace your projects live in. Set
# the SHARED_WORKSPACE environment variable if this is not ~/workspace/.
workspace() {
  result=$([ -s "$SHARED_WORKSPACE" ] && echo $SHARED_WORKSPACE || echo "~/workspace/")
  echo "$result"
}

# bash completion function for work(). Allows you to type `work f` to
# auto-complete to `work foo`, following standard Bash directory-completion
# rules.
_work() {
  local cur
  local trim
  local dir=$(workspace)
  cur=${COMP_WORDS[COMP_CWORD]}
  # length of expanded path, used to trim off first portion of matched paths below
  trim=`echo $dir/ | wc -c`
  # perform completion, returning all directories in workspace, trimming off the path to the workspace
  COMPREPLY=( $( compgen -S/ -d $dir/$cur | cut -b $trim- ) )
}

# enable completion for work() function using _work(), but only if `complete` exists
command -v complete > /dev/null && complete -o nospace -F _work work


# necessary for mysql gem when using mysql 5.5 on mac os x
export DYLD_LIBRARY_PATH="/usr/local/mysql/lib/:$DYLD_LIBRARY_PATH"

# the colors duke! the colors!
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

#update ulimit to over 9000!
ulimit -n 10000

[[ -s /Users/kevinmarx/.nvm/nvm.sh ]] && . /Users/kevinmarx/.nvm/nvm.sh # This loads NVM
