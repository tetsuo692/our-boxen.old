class people::tetsuo692 {
	class { 'ruby::global':
	  version => '2.3.1'
	}
	include ruby::global
	
    #DropBox
    include dropbox

    include xquartz

    #iterm2
    include iterm2::stable
    include iterm2::colors::solarized_dark

    #1passwd
    include onepassword


    #include alfred

    #Zsh
    include zsh
    include ohmyzsh

    include chrome

    #include virtualbox

    include appcleaner

    #include onyx
    include git
    /* include git::config */
    include macvim

    include mongodb
    include tmux

#    include wireshark

    include projects::dotfiles
	include projects::test_graph
    #include projects::echotek
    #include projects::cream

    package { 'wget':
      ensure => present,
    }

    $home = "/Users/${::luser}"
    $projects = "${boxen::config::srcdir}"
    $vimpath = "${home}/.vim"

    $dotfiles = "${projects}/dotfiles"


    file {$vimpath:
      ensure => "link",
      target => "${dotfiles}/vim/",
      require => Repository[$dotfiles],
    }

    file { "${home}/.zshrc":
      ensure => "link",
      target => "${dotfiles}/zshrc",
      require => Repository[$dotfiles],
    }
    file { "${home}/.gitignore":
      ensure => "link",
      target => "${dotfiles}/gitignore",
      require => Repository[$dotfiles],
    }
    file { "${home}/.vimrc":
      ensure => "link",
      target => "${home}/.vim/vimrc",
      require => Repository[$dotfiles],
    }
    file { "${home}/.gitconfig":
      ensure => "link",
      target => "${dotfiles}/gitconfig",
      require => Repository[$dotfiles],
    }

    file { "${home}/.tmux.conf":
      ensure  => "link",
      target  => "${dotfiles}/tmux.conf",
      require => Repository[$dotfiles],
    }
    #file { "${home}/.gemrc":
    #  ensure => "link",
    #  target => "${dotfiles}/gemrc",
    #  require => Repository[$dotfiles],
    #}
    exec { "vundle":
      provider => shell,
      command => "vim +PluginInstall +qall",
      require => Repository[$dotfiles],
    }
    include osx::disable_app_quarantine
}
