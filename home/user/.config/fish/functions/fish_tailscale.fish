function fish_tailscale -d 'Show Status Tailscale'
    set --local _hostname "$(hostnamectl hostname)"
    set --local _devices "$(tailscale --socket /run/user/$(id -u)/tailscale/tailscaled.sock status | awk '/^\s*$/ {exit} {print}')"
    set --local _total "$(echo "$_devices" | wc -l)"
    set --local _offline "$(echo "$_devices" | grep -c 'offline')"

    if echo "$_devices" | grep -q "$_hostname.*offline"
        echo "Disconnect ($(math $_total - $_offline) Last Online)"
    else
        echo "$_total ($(math $_total - $_offline) Online)"
    end
end
