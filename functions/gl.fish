if not set -q GL_BASE_DIR
    set GL_BASE_DIR $HOME/src
end

function gl
  set git_host gitlab.com
  set -l repo ""

  if [ (count $argv) -ne 2 ]
    if not [ (echo $argv[1] | string match -r '\S/\S') ]
      echo "USAGE: gl [user] [repo]"
      return -1
    end
  end

  if [ (count $argv) -eq 2 ]
    set local_path $argv[1]/$argv[2]
  else
    set local_path $argv[1]
  end
  set resource $local_path.git

  set -l path $GH_BASE_DIR/$git_host/$local_path
  if not test -d $path
    git clone git@$git_host:$resource $path
  end

  cd $path
end
