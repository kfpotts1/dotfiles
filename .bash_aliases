alias lg="lazygit"
alias sbash="source ~/.bashrc"
# alias for 1password signin
# alias opsign="eval $(op signin)"
# reload entire kitty config
alias kit="kitty @ set-config --reload"

# bazel aliases
# 'br' is short for 'bazel run', all arguments are passed through to bazel run

function bazel_run_file() {
  if [ -z "$1" ]; then
    echo "Error: No target file provided."
    return 1
  fi

  if [ ! -f "$1" ]; then
    echo "Error: Target file '$1' does not exist."
    return 1
  fi

  local target_name=$(basename $1)
  target_name=${target_name%%.*}
  local target_path=$(dirname $1)
  shift  # remove the first argument
  local bazel_command="bazel run -- //$target_path:$target_name $@"
  echo "Running: $bazel_command"
  eval $bazel_command
}

alias br="bazel_run_file"
