---
date: 2019-06-01
title: Bash
description: "Bash scripting"
tags: [bash]

---


## Run command after n seconds

Open will start after two secs without blocking execution

```bash
( sleep 2 && open http://0.0.0.0:8000/ )&
```

## Expand bash variable containing a path with spaces

```Bash
SKETCH_PLUGINS_DIRECTORY="$HOME/Library/Application Support/com.bohemiancoding.sketch3/Plugins/" 

# To avoid the expasion to be splitted into two strings, we surround it with ""

ls "$SKETCH_PLUGINS_DIRECTORY"

```

## ls just one column

```bash
ls -1
```

## Check if last command succeeded

```bash
some_command
if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi
```

## Count arguments passed to a script

```bash
if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
fi
```

## Check if directory exists

[To check if a directory exists in a shell script you can use the following](https://stackoverflow.com/a/59839/225503):

```bash
if [ -d "$DIRECTORY" ]; then
  # Control will enter here if $DIRECTORY exists.
fi
```

Or to check if a directory doesn't exist:

```bash
if [ ! -d "$DIRECTORY" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
fi
```