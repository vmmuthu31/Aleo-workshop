#!/bin/bash
# First check that Leo is installed.
if ! command -v leo &> /dev/null
then
    echo "leo is not installed."
    exit
fi

echo "
###############################################################################
########                                                               ########
########               STEP 0: Compile the vote program                ########
########                                                               ########
###############################################################################
"
# Build the Leo vote program.
(
  leo build || exit
)

echo "
###############################################################################
########                                                               ########
########                 STEP 1: Propose a new ballot                  ########
########                                                               ########
########                  ---------------------------                  ########
########                  |         |  Yes  |   No  |                  ########
########                  ---------------------------                  ########
########                  |  Votes  |       |       |                  ########
########                  ---------------------------                  ########
########                                                               ########
###############################################################################
"
# Run the `propose` function
(
 leo run propose || exit
)

echo "
###############################################################################
########                                                               ########
########               STEP 2: Issue a new ballot ticket               ########
########                                                               ########
########                  ---------------------------                  ########
########                  |         |  Yes  |   No  |                  ########
########                  ---------------------------                  ########
########                  |  Votes  |   0   |   0   |                  ########
########                  ---------------------------                  ########
########                                                               ########
###############################################################################
"
# Run the `new_ticket` function
(
  leo run new_ticket || exit
)

echo "
###############################################################################
########                                                               ########
########            STEP 3: Vote 'Yes' on the ballot ticket            ########
########                                                               ########
########                  ---------------------------                  ########
########                  |         |  Yes  |   No  |                  ########
########                  ---------------------------                  ########
########                  |  Votes  |   1   |   0   |                  ########
########                  ---------------------------                  ########
########                                                               ########
###############################################################################
"
# Run the `agree` or `disagree` function
(
  leo run agree || exit
  # leo run disagree || exit
)
