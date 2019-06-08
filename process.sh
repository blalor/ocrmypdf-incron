#!/bin/bash
set -e -u -o pipefail

declare -r dest_dir="/srv/ocr"
declare -r create_txt=0

src_dir="$1"
src_fn="$2"

input="${src_dir}/${src_fn}"
dest_pdf="${dest_dir}/${src_fn}"

ocr_args=(
    --rotate-pages
    --deskew
    --clean
)

if [ $create_txt -eq 1 ]; then
    dest_txt="${dest_dir}/${src_fn%.pdf}.txt"
    
    ocr_args+=("--sidecar=${dest_txt}")
fi

echo "processing ${input}"

rc=0
if /usr/bin/ocrmypdf "${ocr_args[@]}" "${input}" "${dest_pdf}"; then
    rm "${input}"
else
    echo "ocrmypdf failed on ${input}"
    rc=1
fi

exit $rc
