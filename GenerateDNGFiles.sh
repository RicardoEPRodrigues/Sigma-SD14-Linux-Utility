#!/bin/bash

echo "Script to more easily convert X3F into DNG files in a formatted way."
echo "Website: https://github.com/RicardoEPRodrigues/Sigma-SD14-Linux-Utility"
echo "By: Ricardo \"ColorCrow\" Rodrigues (ricardo@colorcrow.me)"
echo "Makes use of X3F Extract from https://github.com/Kalpanika/x3f"
echo

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INPUT_DIR="${DIR}/RAW"
OUTPUT_DIR="${DIR}/DNG"

X3F_EXT="X3F"
DNG_EXT="dng"

COMMAND="x3f_extract"

OVERRIDE=0

while getopts ":o" option; do
    case $option in
        o) # set override
            OVERRIDE=1
    esac
done

mkdir -p ${OUTPUT_DIR}
mkdir -p ${INPUT_DIR}

if [[ -f "${DIR}/x3f_extract" ]] 
then
    COMMAND="${DIR}/x3f_extract"
fi

# Create an Array of X3F Files
cd "${INPUT_DIR}"
readarray -d '' X3F_FILES < <(find . -name "*.${X3F_EXT}" -print0)
X3F_FILES_LEN=${#X3F_FILES[@]}
echo "Found ${X3F_FILES_LEN} X3F files."

if (( ${OVERRIDE} == 0 )); then
    cd "${OUTPUT_DIR}"
    # Create an Array of previously generated DNG files
    readarray -d '' DNG_FILES < <(find . -name "*.${DNG_EXT}" -print0)
    echo "Found ${#DNG_FILES[@]} DNG files."

    # Remove already generated files from the X3F array
    for dng in ${DNG_FILES[@]}; do
        X3F_FILES=( "${X3F_FILES[@]/${dng%.*}}" )
    done
    # Compact
    X3F_FILES=( ${X3F_FILES[*]} )
    echo "Excluded $(expr ${X3F_FILES_LEN} - ${#X3F_FILES[@]}) X3F files."
    echo
else
    echo "Skipping exclusion of previously generated DNG files (due to option \"-o\")."
    echo
fi

# Check if there are any files to update
if (( ${#X3F_FILES[@]} == 0 )); then
    echo "No new files to generate. Use the option \"-o\" to override previous DNG files."
    exit;
fi

# Generate files
cd "${INPUT_DIR}"
echo "Will generate the following new files: ${X3F_FILES[*]}"
echo
set -x
${COMMAND} -o ${OUTPUT_DIR} -dng ${X3F_FILES[*]}
set +x

# Allow writing to files
cd "${OUTPUT_DIR}"
chmod u+w *.dng

cd "${DIR}"
