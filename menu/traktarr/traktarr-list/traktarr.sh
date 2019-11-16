#!/bin/bash 

traktarr movies -t https://trakt.tv/users/porkie16/lists/docu-movies -l 15  
sleep 30s
traktarr movies -t https://trakt.tv/users/porkie16/lists/thriller-movies-rating-65 -l 15  
sleep 30s
traktarr movies -t https://trakt.tv/users/porkie16/lists/horror-movies-rating-65 -l 15  
sleep 30s
traktarr movies -t https://trakt.tv/users/porkie16/lists/sci-fi-movies-65-rating -l 15  
sleep 30s
traktarr movies -t https://trakt.tv/users/porkie16/lists/comedy-movies-65-rating -l 15  
sleep 30s
traktarr movies -t https://trakt.tv/users/porkie16/lists/animation-movies-kids-only-rating-65 -l 15  
sleep 30s
traktarr movies -t https://trakt.tv/users/porkie16/lists/action-movies-rating-65-rating -l 15  
sleep 30s
traktarr movies -t https://trakt.tv/users/theultimatec0der/lists/all-movies-2019 -l 15
sleep 30s
traktarr shows -t https://trakt.tv/users/theultimatec0der/lists/all-shows-2019 -l 15
sleep 30s
traktarr shows -t https://trakt.tv/users/theultimatec0der/lists/all-shows-2018 -l 15
sleep 30s
traktarr shows -t https://trakt.tv/users/theultimatec0der/lists/all-netflix-series -l 15
sleep 30s
traktarr shows -t https://trakt.tv/users/theultimatec0der/lists/all-hulu-series -l 15
sleep 30s
traktarr shows -t https://trakt.tv/users/theultimatec0der/lists/all-amazon-series -l 15

exit 0
