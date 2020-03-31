#!/usr/bin/env bash 

VERSION="0.1.0"

BASE_API="https://corona.lmao.ninja"
API_ALL_COUNTRIES_ENDPOINT="$BASE_API/countries"
API_TOTAL_ENDPOINT="$BASE_API/all"

function get_single_country_stats() {
  country=$1

  stats=($(curl -s $API_ALL_COUNTRIES_ENDPOINT/$country | jq -r ".cases,.todayCases,.deaths,.todayDeaths,.recovered | @sh")) 

  cases=${stats[0]}
  today_cases=${stats[1]}
  deaths=${stats[2]}
  today_deaths=${stats[3]}
  recovered=${stats[4]}
}

function get_world_stats() {
  stats=($(curl -s $API_TOTAL_ENDPOINT | jq -r ".cases,.deaths,.recovered | @sh"))

  cases=${stats[0]}
  deaths=${stats[1]}
  recovered=${stats[2]}
}

function print_stats() {
  RED=$(tput setaf 1)
  GREEN=$(tput setaf 2)
  YELLOW=$(tput setaf 3)

  if [[ "$1" == "world" ]]; then
    get_world_stats

    echo "${YELLOW}Cases     = ${cases}"
    echo "${RED}Deaths    = ${deaths}"
    echo "${GREEN}Recovered = ${recovered}"

    exit
  fi

  get_single_country_stats $1

  echo "${YELLOW}Cases     = ${cases} +${today_cases}"
  echo "${RED}Deaths    = ${deaths} +${today_deaths}"
  echo "${GREEN}Recovered = ${recovered}"
}

print_stats $1

