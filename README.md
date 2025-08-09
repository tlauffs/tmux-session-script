# Tmux Sessionizer

This script simplifies the creation and management of tmux sessions, leveraging `zoxide` to quickly navigate to your project directories. It automatically creates and attaches to tmux sessions, and can be configured to run an initialization script for each project.

## Prerequisites

Before using this script, you need to have the following installed:
* tmux
* zoxide
* fzf

## How to Use

1.  Make the `ct.sh` script executable:
    ```bash
    chmod +x ct.sh
    ```
2.  Run the script with a `zoxide` query as an argument:
    ```bash
    ct.sh my-project
    ```
    This will:
    *   Use `zoxide` to find the directory for "my-project".
    *   Create a new tmux session named after the project directory.
    *   Attach to the new tmux session.

## `inittmux.sh`

You can automate the setup of your development environment by creating an `inittmux.sh` file in your project's root directory. If this file exists, the tmux sessionizer will execute it when creating a new session.

### Example `inittmux.sh`

Here is an example of an `inittmux.sh` file that sets up a typical development environment:

```bash
#!/bin/bash

# Create a new window named 'editor' and open nvim
tmux new-window -n editor
tmux send-keys -t editor 'nvim .' C-m

# Create a new window named 'server' and start a development server
tmux new-window -n server
tmux send-keys -t server 'npm run dev' C-m

# Split the 'editor' window vertically and run a shell command
tmux select-window -t editor
tmux split-window -v
tmux send-keys 'git status' C-m

# Go back to the editor pane
tmux select-pane -t 0
```

This script will:

*   Create a new tmux window named "editor" and open Vim in it.
*   Create another window named "server" and run `npm run dev`.
*   Split the "editor" window and show the git status.
*   Return focus to the editor pane.

By using `inittmux.sh` files, you can create a consistent and automated development environment for each of your projects.
