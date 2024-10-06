{ config, pkgs, lib, inputs, ... }:
with lib;
let
  # Shorter name to access final settings a
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention.
  cfg = config.module.hyprland-event-hooks;
  hyprlandEventHooks = pkgs.writeScript "hyprland-event-hooks" ''
    #!${pkgs.bash}/bin/bash

    handle_message() {
        case $1 in
            monitoraddedv2*)
                input=$(echo $1 | sed 's/.*>>//')
                IFS=',' read -r serial name details <<< "$input"
                echo "Monitor connected: Name: $name, Serial: $serial, Details: $details"
                ${monitorSetupScript}
                ;;
        esac
    }

    echo "Listening for messages from Hyprland..."
    ${pkgs.socat}/bin/socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
        handle_message "$line"
    done
  '';
  monitorSetupScript = pkgs.writeScript "monitor-setup" ''
    #!${pkgs.bash}/bin/bash

    extract_monitor_information() {
        local -n result=$1
        output=$(${pkgs.wlr-randr}/bin/wlr-randr)

        current_display=""
        current_resolution=""
        current_refresh_rate=""
        current_serial=""
        current_make=""

        index=0

        while IFS= read -r line; do
            if [[ $line =~ ^[a-zA-Z0-9\-]+ ]]; then
                current_display=$(echo "$line" | awk '{print $1}')
            elif [[ $line =~ Serial ]]; then
                current_serial=$(echo "$line" | awk -F': ' '{print $2}')
            elif [[ $line =~ Make ]]; then
                current_make=$(echo "$line" | sed -n 's/.*Make: //p')
            fi

            if [[ $line =~ preferred ]]; then
                current_resolution=$(echo "$line" | awk '{print $1}')
                current_refresh_rate=$(echo "$line" | awk '{print $3}')
                result[$index]="[$current_display,$current_resolution,$current_refresh_rate,$current_serial,$current_make]"
                ((index++))
            fi
        done <<< "$output"
    }

    extract_output_by_serial() {
        local serial=$1
        local -n monitor_data=$2

        for entry in "''${monitor_data[@]}"; do
            IFS=',' read -r display resolution refresh serial_number make <<< "''${entry//[\[\]]/}"
            if [[ $serial_number == "$serial" ]]; then
                echo "$display"
                return
            fi
        done
    }

    extract_resolution_by_serial() {
        local serial=$1
        local -n monitor_data=$2

        for entry in "''${monitor_data[@]}"; do
            IFS=',' read -r display resolution refresh serial_number make <<< "''${entry//[\[\]]/}"
            if [[ $serial_number == "$serial" ]]; then
                echo "$resolution"
                return
            fi
        done
    }

    extract_serial_by_make() {
        local make_input=$1
        local -n monitor_data=$2

        for entry in "''${monitor_data[@]}"; do
            IFS=',' read -r display resolution refresh serial_number make <<< "''${entry//[\[\]]/}"
            if [[ "$make" == "$make_input" ]]; then
                echo "$serial_number"
                return
            fi
        done
    }

    extract_refresh_rate_by_serial() {
        local serial=$1
        local -n monitor_data=$2

        for entry in "''${monitor_data[@]}"; do
            IFS=',' read -r display resolution refresh serial_number make <<< "''${entry//[\[\]]/}"
            if [[ $serial_number == "$serial" ]]; then
                echo "$refresh"
                return
            fi
        done
    }

    extract_monitor_makes() {
        local -n monitor_data=$1
        local -n makes=$2
        makes=()

        for entry in "''${monitor_data[@]}"; do
            make=$(echo "$entry" | awk -F, '{print $5}' | tr -d '[]')
            makes+=("$make")
        done
    }

    arrange_monitors() {
        local -n monitor_info=$1
        local arrangement="$2"
        local position="0,0"
        local x_offset=0
        local y_offset=0

        IFS=$'\n' read -r -d ''' -a monitors <<< "$(echo "$arrangement" | tr '|' '\n' | sed 's/^ *//;s/ *$//')"

        echo "Configuring monitors according to arrangement: $arrangement"

        for monitor in "''${monitors[@]}"; do
            monitor=$(echo "$monitor" | xargs)
            serial=$(extract_serial_by_make "$monitor" monitor_info)

            if [ -z "$serial" ]; then
                echo "Error: Serial number for monitor '$monitor' not found!"
                continue
            fi

            refresh_rate=$(extract_refresh_rate_by_serial "$serial" monitor_info)
            resolution=$(extract_resolution_by_serial "$serial" monitor_info)
            output=$(extract_output_by_serial "$serial" monitor_info)

            echo "Setting monitor configuration: ''${output},''${resolution}@''${refresh_rate},0x''${x_offset},1.0"
            if ! ${pkgs.hyprland}/bin/hyprctl keyword monitor "''${output},''${resolution}@''${refresh_rate},''${x_offset}x0,1.0" > /dev/null; then
                echo "Error: Configuration failed for monitor $serial at position $position"
            fi

            added_x_offset="''${resolution%x*}"
            x_offset=$((x_offset + added_x_offset))
            position="''${x_offset},''${y_offset}"
        done
    }

    permute() {
        local prefix="$1"
        local remaining=("''${!2}")

        if [ ''${#remaining[@]} -eq 0 ]; then
            echo "''${prefix# }"
        else
            for i in "''${!remaining[@]}"; do
                local current="''${remaining[$i]}"
                local rest=("''${remaining[@]:0:i}" "''${remaining[@]:((i + 1))}")
                if [[ -z "$prefix" ]]; then
                    permute "$current" rest[@]
                else
                    permute "$prefix | $current" rest[@]
                fi
            done
        fi
    }

    handle_monitor_configuration() {
        echo "Fetching monitor information..."
        declare -a monitor_information
        extract_monitor_information monitor_information

        echo "Extracting monitor makes..."
        declare -a monitor_makes
        extract_monitor_makes monitor_information monitor_makes

        echo "Generating arrangement options..."
        printf "%s\n" "''${monitor_makes[@]}"
        options=$(permute "" monitor_makes[@])

        echo "Prompting user for arrangement..."
        choice=$(printf "%s\n" "''${options[@]}"  | column -t -s '|' | ${pkgs.fuzzel}/bin/fuzzel --dmenu --prompt="Select arrangement >")
        echo "User selected arrangement: $choice"

        echo "Arranging monitors..."
        arrange_monitors monitor_information "$choice"
    }

    handle_monitor_configuration
  '';
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.module.hyprland-event-hooks = {
    # Option declarations.
    # Declare what settings a user of this module module can set.
    # Usually this includes a global "enable" option which defaults to false.
    enable = mkEnableOption "hyprland-event-hooks";
  };

  config = mkIf cfg.enable {
    # Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these depend on whether a user of this module chose to "enable" it
    # using the "option" above.
    # Options for modules imported in "imports" can be set here.
    systemd.user.services.hyprland-event-hooks = {
      Unit = { Description = "Hyprland Event Hooks Service"; };
      Service = {
        ExecStart = "${hyprlandEventHooks}";
        Type = "simple";
        Restart = "always";
      };
      Install = { WantedBy = [ "default.target" ]; };
    };
    wayland.windowManager.hyprland = {
      settings.bind = [ "$mainMod, Y, exec, ${monitorSetupScript}" ];
    };
  };
}
