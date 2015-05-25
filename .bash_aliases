# "repeat" command. Like:
#
#   repeat 10 echo foo
repeat ()
{
  local count="$1" i;
  shift;
  for i in $(_seq 1 "$count");
  do
    eval "$@";
  done
}

# Subfunction needed by `repeat'.
_seq ()
{
  local lower upper output;
  lower=$1 upper=$2;

  if [ $lower -ge $upper ]; then return; fi
  while [ $lower -lt $upper ];
  do
    echo -n "$lower "
    lower=$(($lower + 1))
  done
  echo "$lower"
}
