GIT HOWTO

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