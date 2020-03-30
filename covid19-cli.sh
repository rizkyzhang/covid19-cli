#!/usr/bin/env bash 

VERSION="0.0.1"

BASE_API="https://corona.lmao.ninja"
API_ALL_COUNTRIES_ENDPOINT="$BASE_API/countries"
API_TOTAL_ENDPOINT="$BASE_API/all"

function get_data() {
  country=$1

  arr=($(curl -s $API_ALL_COUNTRIES_ENDPOINT/$country | jq -r ".cases,.deaths,.recovered | @sh"))
  
  cases=${arr[0]}
  deaths=${arr[1]}
  recovered=${arr[2]}
}

function print_result() {
  get_data $1

  RED=$(tput setaf 1)
  GREEN=$(tput setaf 2)
  YELLOW=$(tput setaf 3)

  echo "${YELLOW}Cases     : ${cases}"
  echo "${RED}Deaths    : ${deaths}"
  echo "${GREEN}Recovered : ${recovered}"
}

print_result $1

