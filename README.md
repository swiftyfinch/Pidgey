# 🐦 Pidgey

<a href="https://www.apple.com/ru/swift/"><img src="https://img.shields.io/badge/Swift-red?logo=swift&logoColor=white" /></a>
<a href="https://github.com/yonaskolb/Mint"><img src="https://img.shields.io/badge/Mint-darkgreen?logo=leaflet&logoColor=white" /></a>
<a href="https://twitter.com/swiftyfinch"><img src="https://img.shields.io/badge/@swiftyfinch-blue?logo=twitter&logoColor=white" /></a>
<br>
Notify GitLab reviewers to Slack.

<img width="700" src="https://user-images.githubusercontent.com/64660122/143618050-36c83a80-9e8c-4b9e-9dfc-e282bb80a897.png">

```
OVERVIEW: Notify GitLab reviewers to Slack.

USAGE: pidgey <subcommand>

SUBCOMMANDS:
  notify (default)        Show list of your GitLab merge requests and select
                          one for notify reviewers to Slack.
  setup                   Setup environment.
  
OPTIONS:
  --version               Show the version.
  -h, --help              Show help information.
```

## Quick start with <a href="https://github.com/yonaskolb/Mint">Mint</a> 🌱

```bash
brew install mint
mint install swiftyfinch/pidgey

# Now on Mint 0.17.0 you'll need to add ~/.mint/bin to your $PATH
# For example, add this to your ~/.zshrc file and relaunch terminal
export PATH=$HOME/.mint/bin:$PATH
```
Watch 🎬 [installation demo](https://github.com/swiftyfinch/Rugby/discussions/71)<br>
It's from my another project, but the idea is the pretty same.

## How to use 🐦

First of all, you need to set up. All values will keep in the keychain.
```bash
pidgey setup --gitlab <gitlab_endpoint> --token <personal_token> --slack <slack_hook_url>
```

Then just call `pidgey` and you will see all merge requests which you are created.<br>
Select one of them and 🐦 **Pidgey** will send notifications to all reviewers.

### Author

Vyacheslav Khorkov\
Twitter: [@SwiftyFinch](https://twitter.com/swiftyfinch)\
Blog: [swiftyfinch.github.io](https://swiftyfinch.github.io/en)\
Feel free to contact me 📮
