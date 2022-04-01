
# File that contains functions for menues and browsing

main_menu () {
  echo "Please, choose an option:"
  echo "1 .- Virus scan options"
  echo "2 .- Analyse directories"
  echo "3 .- Whatever..."
  read $Option
exit $Option
}

provide_dir () {
  echo "Please, provide a directory"
  read $Dir
exit $Dir
}
