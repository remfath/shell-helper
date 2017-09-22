#!/usr/bin/env bash

# Get the GB size part of a given size of bytes
function getGBPart() {
    local totalBytes=$1
    local gbPart=$((totalBytes/1024/1024/1024))

    echo $gbPart
    return 0
}

# Get the MB size part of a given size of bytes
function getMBPart() {
    local totalBytes=$1
    local gbPart=$(getGBPart "$totalBytes")

    totalBytes=$((totalBytes - 1024 * 1024 * 1024 * gbPart))
    local mbPart=$((totalBytes/1024/1024))

    echo $mbPart
    return 0
}

# Get the KB size part of a given size of bytes
function getKBPart() {
    local totalBytes=$1
    local gbPart=$(getGBPart "$totalBytes")
    local mbPart=$(getMBPart "$totalBytes")

    totalBytes=$((totalBytes - 1024 * 1024 * 1024 * gbPart - 1024 * 1024 * mbPart))
    local kbPart=$((totalBytes/1024))

    echo $kbPart
    return 0
}

# Get the byte size part of a given size of bytes
function getBytePart() {
    local totalBytes=$1
    local gbPart=$(getGBPart "$totalBytes")
    local mbPart=$(getMBPart "$totalBytes")
    local kbPart=$(getKBPart "$totalBytes")

    totalBytes=$((totalBytes - 1024 * 1024 * 1024 * gbPart - 1024 * 1024 * mbPart - 1024 * kbPart))
    local bytePart=$totalBytes

    echo $bytePart
    return 0
}

# Format size of a given size of bytes
function formatSizeString() {
    local totalBytes=$1
    local gbPart=$(getGBPart "${totalBytes}")
    local mbPart=$(getMBPart "${totalBytes}")
    local kbPart=$(getKBPart "${totalBytes}")
    local bytePart=$(getBytePart "${totalBytes}")

    echo "${gbPart}GB ${mbPart}MB ${kbPart}KB ${bytePart}Byte"
    return 0
}
