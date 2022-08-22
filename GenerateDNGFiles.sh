#!/bin/bash

set -e
set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INPUT_DIR="${DIR}/x3f-input"
OUTPUT_DIR="${DIR}/dng-convert"

COMMAND="x3f_extract"

mkdir -p ${OUTPUT_DIR}
mkdir -p ${INPUT_DIR}

# Download X3F Extract from https://github.com/Kalpanika/x3f

if [[ -f "${DIR}/x3f_extract" ]] 
then
    COMMAND="${DIR}/x3f_extract"
fi

cd "${INPUT_DIR}"
${COMMAND} -o ${OUTPUT_DIR} -dng *.X3F
cd "${DIR}"

cd "${OUTPUT_DIR}"
chmod u+w *.dng
cd "${DIR}"
