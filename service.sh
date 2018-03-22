#!/bin/zsh

urldecode () {
	local encoded_url=$1
	local caller_encoding="UTF-8"
	local LC_ALL=C
	export LC_ALL
	local tmp=${encoded_url:gs/+/ /}
	tmp=${tmp:gs/\\/\\\\/}
	tmp=${tmp:gs/%/\\x/}
	local decoded
	eval "decoded=\$'$tmp'"
	local safe_encodings
	safe_encodings=(UTF-8 utf8 US-ASCII)
	if [[ -z ${safe_encodings[(r)$caller_encoding]} ]]
	then
		decoded=$(echo -E "$decoded" | iconv -f UTF-8 -t $caller_encoding)
		if [[ $? != 0 ]]
		then
			echo "Error converting string from UTF-8 to $caller_encoding" >&2
			return 1
		fi
	fi
    echo -E $decoded
}

respond() {
  decoded=$(urldecode $REQUEST)
  method=${decoded:1:3}

  if [ $method = "put" ]
  then
    hsh=$(echo ${decoded:5} | md5sum)
    hsh=${hsh:0:-3}
    output=$hsh
    (echo -E ${decoded:5} > /data/$hsh)
  elif [ $method = "get" ]
  then
    output=$(cat /data/${decoded:5})
  elif [ $method = "sch" ]
  then
    output=$(tail -n +1 $(ag -l "${decoded:5}" "/data"))
  fi
  echo "HTTP/1.1 200 OK\r\nConnection: keep-alive\n\n$output"
}

read -r line
line=$(echo "$line" | tr -d '\r\n')
REQUEST=$(echo "$line" | cut -d ' ' -f2) # extract the request
respond