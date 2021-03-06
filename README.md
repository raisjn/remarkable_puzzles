# Remarkable Puzzles

[Simon Tatham's Portable Puzzle Collection][stpuzzles] for the reMarkable tablet.


## Building

Builds are done in docker by default.

```sh
# Build the docker toolchain
make docker_build

# Debug build
make debug

# Release build
make release
```

### Help files

Help files are based on the those from the original puzzle collection, found in
vendor/puzzles/html/. For expediency and simplicity, the help dialog only shows
plain text, so these must be converted and edited. Fortunately these help files
only use a simple subset of html, so most of this can be automated:

```sh
# Generate text-only help files in help/
scripts/build-help.sh
```

Most help files should be hand-edited since the controls are a little different
(e.g. there is no middle click, and right click is simulated by a long press).

### Icons

In the spirit of the original puzzle collection, icons are generated from
in-progress games. The canonical save files for these icons can be found in
vendor/puzzles/icons/. There is a separate `puzzle-icons` build that is used to
generate all icons at once, based on these save files.

```sh
scripts/build-icons.sh
```

## Testing

Assuming `remarkable` as an alias in ~/.ssh/config, as per
<https://remarkablewiki.com/tech/ssh>:

```
host remarkable
  Hostname 10.11.99.1
  User root
```

Stop xochitl

```sh
ssh remarkable -t systemctl stop xochitl
```

Make /opt/etc/puzzles directory structure

```sh
ssh remarkable -t mkdir -p /opt/etc/puzzles/save
scp -r config/ remarkable:/opt/etc/puzzles/
scp -r help/ remarkable:/opt/etc/puzzles/
scp -r icons/ remarkable:/opt/etc/puzzles/
```

Copy the executable and run it

```sh
scp build/debug/puzzles remarkable:/opt/bin/
ssh -t remarkable /opt/bin/rm2fb-client /opt/bin/puzzles
```

Restart xochitl

```sh
ssh remarkable -t systemctl start xochitl
```



[stpuzzles]: https://www.chiark.greenend.org.uk/~sgtatham/puzzles/
