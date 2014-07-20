#!/bin/sh

TMP_DIR="${TMPDIR}"

setvar() { eval $1="'$3'"; }

set -ue

#BEGIN DEPEND------------------------------------------------------------------

BASENAME="`basename $0 .com`"

INPUT_INP=./inputs/${BASENAME}.inp

INPUT_PSP1=./inputs/1h.pspnc
INPUT_PSP2=./inputs/8o.pspnc

OUTPUT_DAT=./outputs/${BASENAME}.out

#END DEPEND--------------------------------------------------------------------

test -z "${TMP_DIR}" && TMP_DIR="."
TMP_DIR="${TMP_DIR}/tmp-${BASENAME}-$$"
mkdir "${TMP_DIR}"

TMP_FILES="${TMP_DIR}/${BASENAME}.files"

set -x

cat > ${TMP_FILES} <<EOF
$(basename ${INPUT_INP})
$(basename ${OUTPUT_DAT})
${BASENAME}i
${BASENAME}o
${BASENAME}
$(basename ${INPUT_PSP2})
$(basename ${INPUT_PSP1})
EOF

cp ${INPUT_PSP1} ${TMP_DIR}
cp ${INPUT_PSP2} ${TMP_DIR}
cp ${INPUT_INP} ${TMP_DIR}

(
    cd ${TMP_DIR}
    abinis < $(basename ${TMP_FILES})
)

tree ${TMP_DIR}

mv ${TMP_DIR}/$(basename ${OUTPUT_DAT}) ${OUTPUT_DAT}

rm -rf "${TMP_DIR}"
