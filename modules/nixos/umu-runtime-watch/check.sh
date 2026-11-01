base=https://repo.steampowered.com/steamrt4/images/latest-public-beta
state="${XDG_STATE_HOME:-$HOME/.local/state}/umu-runtime-watch"
mkdir -p "$state"
[ -f "$state/fixed" ] && exit 0

stamp=$(curl -fsSI "$base/SHA256SUMS" "$base/SteamLinuxRuntime_4.tar.xz" | grep -i '^last-modified' | tr -d '\r')
if [ -f "$state/last-checked" ] && [ "$stamp" = "$(cat "$state/last-checked")" ]; then
  exit 0
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
curl -fsSL "$base/SHA256SUMS" -o "$tmp/SHA256SUMS"
curl -fsSL "$base/SteamLinuxRuntime_4.tar.xz" -o "$tmp/runtime.tar.xz"
want=$(grep 'SteamLinuxRuntime_4.tar.xz' "$tmp/SHA256SUMS" | cut -d' ' -f1)
got=$(sha256sum "$tmp/runtime.tar.xz" | cut -d' ' -f1)

if [ -n "$want" ] && [ "$want" = "$got" ]; then
  notify-send "Valve runtime checksums fixed" \
    "umu can download Steam Linux Runtime 4 again. Ask Claude to remove the battlenet runtime workaround and this watcher."
  touch "$state/fixed"
else
  echo "$stamp" > "$state/last-checked"
  echo "still mismatched: SHA256SUMS says $want, file is $got"
fi
