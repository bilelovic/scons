# scons-color based on https://gist.github.com/1027800
BOLD=$(tput bold)
UNDERLINE_ON=$(tput smul)
UNDERLINE_OFF=$(tput rmul)
TEXT_BLACK=$(tput setaf 0)
TEXT_RED=$(tput setaf 1)
TEXT_GREEN=$(tput setaf 2)
TEXT_YELLOW=$(tput setaf 3)
TEXT_BLUE=$(tput setaf 4)
TEXT_MAGENTA=$(tput setaf 5)
TEXT_CYAN=$(tput setaf 6)
TEXT_WHITE=$(tput setaf 7)
BACKGROUND_BLACK=$(tput setab 0)
BACKGROUND_RED=$(tput setab 1)
BACKGROUND_GREEN=$(tput setab 2)
BACKGROUND_YELLOW=$(tput setab 3)
BACKGROUND_BLUE=$(tput setab 4)
BACKGROUND_MAGENTA=$(tput setab 5)
BACKGROUND_CYAN=$(tput setab 6)
BACKGROUND_WHITE=$(tput setab 7)
RESET_FORMATTING=$(tput sgr0)


# Wrapper function for Scons's scons command.
scons-color() {
  (
  # Filter Scons output using sed. Before filtering set the locale to C, so invalid characters won't break some sed implementations
  unset LANG
  LC_CTYPE=C scons "$@" | sed -e "s/\(\[INFO\]\)\(.*\)/${TEXT_BLUE}${BOLD}\1${RESET_FORMATTING}\2/g" \
               -e "s/\(\[INFO\]\ BUILD SUCCESSFUL\)/${BOLD}${TEXT_GREEN}\1${RESET_FORMATTING}/g" \
               -e "s/\(\[WARNING\]\)\(.*\)/${BOLD}${TEXT_YELLOW}\1${RESET_FORMATTING}\2/g" \
               -e "s/\(\[ERROR\]\)\(.*\)/${BOLD}${TEXT_RED}\1${RESET_FORMATTING}\2/g" \
               -e "s/Tests run: \([^,]*\), Failures: \([^,]*\), Errors: \([^,]*\), Skipped: \([^,]*\)/${BOLD}${TEXT_GREEN}Tests run: \1${RESET_FORMATTING}, Failures: ${BOLD}${TEXT_RED}\2${RESET_FORMATTING}, Errors: ${BOLD}${TEXT_RED}\3${RESET_FORMATTING}, Skipped: ${BOLD}${TEXT_YELLOW}\4${RESET_FORMATTING}/g"

  # Make sure formatting is reset
  echo -ne "${RESET_FORMATTING}"
    )
}

# Override the Scons command with the colorized one.
#alias scons="scons-color"

# aliases
alias lbe="scons"
alias pacsversions="scons"
alias notificationids="scons"
alias init="scons"
alias jaxb="scons"
# TODO $COMPONENT
alias java="scons"

function listSconsCompletions {
    reply=(
        # Commands
        java
        lbe
        # options
        "--eclipse" -u "jni_libs" "--no-java" "--no-tests"

        # arguments

    );
}

compctl -K listSconsCompletions scons
