#############
#  HISTORY  #
#############

# Share history between sessions
setopt APPEND_HISTORY

# Add to the history as commands are executed (i.e., not just at session exit)
# setopt INC_APPEND_HISTORY

# Reload the history
setopt SHARE_HISTORY

# Put timestamps in the history
setopt EXTENDED_HISTORY

# Don't include consecutive duplicate commands in the command history
setopt HIST_IGNORE_DUPS

################
#  CORRECTION  #
################

# Command correction
setopt CORRECT

################
#  COMPLETION  #
################

# Don't populate with first ambigious option on first tab down
unsetopt MENU_COMPLETE

# Populate with first ambiguous option on second tab down
setopt AUTO_MENU

# Automatically list choices on ambigious completions
setopt AUTO_LIST

# Recognize exact matches event if they're ambigious
setopt REC_EXACT

# Don't add a trailing slash when completing dir names
unsetopt AUTO_PARAM_SLASH

###########
#  OTHER  #
###########

# If the typed command isn't a command, try it as a `cd` instead
setopt AUTO_CD

# Use $HOME when pushd is invoked without arguments
setopt PUSHD_TO_HOME

# Don't show the stack when pushing and popping
setopt PUSHD_SILENT

# Attempt to expand expressions passed to `cd` if there's no matching dir
setopt CDABLE_VARS

# Always list jobs in the long format
setopt LONG_LIST_JOBS

# Treat single word, simple commands as candidates for resuming a bg job
setopt AUTO_RESUME

# Treat consecutive single quotes as a single quote character when in a single-quoted string
setopt RC_QUOTES

# Don't nice jobs when they're sent to the background
unsetopt BG_NICE

# Expand/substitute/eval prompts
setopt PROMPT_SUBST

# Function like Bash/other POSIX shells when exiting functions
setopt POSIX_TRAPS
