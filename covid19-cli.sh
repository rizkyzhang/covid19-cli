#!/usr/bin/env bash 

VERSION="0.0.1"

BASE_API="https://corona.lmao.ninja"
API_ALL_COUNTRIES_ENDPOINT="$BASE_API/countries"
API_TOTAL_ENDPOINT="$BASE_API/all"

function get_data() {
  country=$1

  arr=($(curl -s $API_ALL_COUNTRIES_ENDPOINT/$country | jq -r ".cases,.todayCases,.deaths,.todayDeaths,.recovered | @sh"))
  
  cases=${arr[0]}
  today_cases=${arr[1]}
  deaths=${arr[2]}
  today_deaths=${arr[3]}
  recovered=${arr[4]}
}

function print_result() {
  get_data $1

  RED=$(tput setaf 1)
  GREEN=$(tput setaf 2)
  YELLOW=$(tput setaf 3)

  echo "${YELLOW}Cases     : ${cases} +${today_cases}"
  echo "${RED}Deaths    : ${deaths} +${today_deaths}"
  echo "${GREEN}Recovered : ${recovered}"
}

print_result $1

