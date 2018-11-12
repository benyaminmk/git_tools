#!/bin/zsh
#/ Extract the filenames from a block of git output lists
#/ Usage: gs | grep .Rd | cut -d" " -f4
#/  vs    gs | grep .Rd | git_fns
git_fns() {
  cut -d" " -f4 "$1";
}
#git_fns `bash -sv "#Y0gs"`

echo $CANDI_RAD
#"git_fns `vcsh gs`"
