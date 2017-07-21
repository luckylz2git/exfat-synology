#!/bin/sh

#auto rename NEF
exiftool '-FileName<%-4f)00000${ShutterCount}.%e' -r -ext NEF ./*ND*/
exiftool '-FileName<%-5f(${ColorSpace})%5f.%e' -r -ext NEF ./*ND*/
exiftool -if '${FileName} =~ /\(Adobe\ RGB\)/i' -FileName='DSC_%5f(A%-5f.%e' -r -ext NEF ./*ND*/
exiftool -if '${FileName} =~ /\(sRGB\)/i' -FileName='DSC_%5f(S%-5f.%e' -r -ext NEF ./*ND*/
exiftool '-Directory<${Model}/%e.${DateTimeOriginal}' -d %Y%m -r -ext NEF ./*ND*/

#auto rename MOV
exiftool '-FileName<DSC_${DateTimeOriginal}(%-4f).%e' -d %Y%m%d_%H%M%S -r -ext MOV ./*ND*/
exiftool '-Directory<${Model}/%e.${DateTimeOriginal}' -d %Y%m -r -ext MOV ./*ND*/
