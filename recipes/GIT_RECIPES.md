# GIT HOWTO
## on git local server side

- create git folder:
    mkdir <project.git>
- initiate bare server git repo for the project
    git init --bare <project.git>

## on git local copy

- create local project folder
    mkdir <project>
    cd <project>
- init empty git repo
    git init
- connect git repo to remote git repo
    git remote add local <git_local_server_path>/<project.git>
- create as you want files or copy files in it
    touch README.md .gitgnore
    git add *
    git commit -m "Initial commit"
- push local changes to remote repo
    git push --set-upstream local master

# GIT Mngt
## What is git versioning ?

https://swcarpentry.github.io/git-novice/

## Externals ressources

Add shh key to ssh-agent: https://gist.github.com/danieldogeanu/16c61e9b80345c5837b9e5045a701c99
Changelog: The Changelog trailer accepts the following values:
added: New feature
fixed: Bug fix
changed: Feature change
deprecated: New deprecation
removed: Feature removal
security: Security fix
performance: Performance improvement
other: Other
emoji git commit message convention:
https://gitmoji.dev/
https://kapeli.com/cheat_sheets/Gitmoji.docset/Contents/Resources/Documents/index
Semantic commit message 
https://nitayneeman.com/posts/understanding-semantic-commit-messages-using-git-and-angular/

## Git Considerations

Do not push to master, if you want to add a feature do it in your branch.
Separate subject from body with a blank line.
Limit the subject line to 50 characters.
Capitalize the subject line.
Do not end the subject line with a period.
Use the imperative mood in the subject line.
Use the present tense ("Add feature" not "Added feature").
Wrap the body at 72 characters.
Use the body to explain what and why vs. how.
Consider starting the commit message with an applicable emoji:
? :sparkles: When introducing a new feature
?? :art: Improving the format/structure of the code
? :zap: When improving performance
?? :fire Removing code or files.
?? :memo: When writing docs
?? :bug: When fixing a bug
?? :fire: When removing code or files
??? :wastebasket: When removing code or files
?? :green_heart: When fixing the CI build
?? :construction_worker: Adding CI build system
? :white_check_mark: When adding tests
?? :lock: When dealing with security
?? :arrow_up: When upgrading dependencies
?? :arrow_down: When downgrading dependencies
?? :rotating_light: When removing linter warnings
?? pencil2: Fixing typos
?? :scisccor: Refactoring code.
?? :boom: Introducing breaking changes
?? truck Moving or renaming files.
?? :space_invader: When fixing something synthesis related
?? :beer: Writing code drunkenly.
?? :ok_hand Updating code due to code review changes
??? :building_construction: Making architectural changes.

# Git flow

https://danielkummer.github.io/git-flow-cheatsheet/
