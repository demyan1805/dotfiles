complete -c cleanup -s 'a' -l 'all' -d 'delete from all sources'
complete -c cleanup -s 'f' -l 'force' -d 'force deletion confirm'
# complete -c cleanup -l 'brew-stale-deps' -d 'homebrew stale libs dependencies'
complete -c cleanup -l 'brew-stale-downloads' -d 'homebrew stale package & cask downloads'
complete -c cleanup -l 'itunes-updates' -d 'itunes software updates'
complete -c cleanup -l 'mobile-backups' -d 'mobile device backups'
complete -c cleanup -l 'poetry-caches' -d 'poetry cache & shared virtualenvs'
complete -c cleanup -l 'xcode-devices' -d 'xcode device simulators'
