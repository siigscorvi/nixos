{ pkgs, vars, ... }:

let
  rofi-hypr-powermenu = pkgs.writeShellScriptBin "rofi-hypr-powermenu" ''
    ## Author : Aditya Shakya (adi1090x)
    ## Github : @adi1090x
    ## Rofi   : Power Menu
    ## Available Styles

    # Current Theme
    dir="$HOME/.config/rofi/hypr-powermenu"
    theme='style-10'

    # CMDs
    uptime="$(${pkgs.coreutils}/bin/uptime | ${pkgs.gnused}/bin/sed -E 's/.* up *([^,]+),.*/\1/')"
    host=$(${pkgs.hostname}/bin/hostname)

    # Options
    shutdown=''
    reboot=''
    lock=''
    suspend=''
    logout=''
    yes=''
    no=''

    # Rofi CMD
    rofi_cmd() {
    	${pkgs.rofi}/bin/rofi -dmenu \
        -p "Uptime: $uptime" \
    		-mesg "Uptime: $uptime" \
    		-theme "''${dir}/''${theme}.rasi"
    }

    # Confirmation CMD
    confirm_cmd() {
    	${pkgs.rofi}/bin/rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
    		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
    		-theme-str 'listview {columns: 2; lines: 1;}' \
    		-theme-str 'element-text {horizontal-align: 0.5;}' \
    		-theme-str 'textbox {horizontal-align: 0.5;}' \
    		-dmenu \
    		-p 'Confirmation' \
    		-mesg 'Are you Sure?' \
    		-theme "''${dir}/''${theme}.rasi"
    }

    # Ask for confirmation
    confirm_exit() {
    	${pkgs.coreutils}/bin/echo -e "$yes\n$no" | confirm_cmd
    }

    # Pass variables to rofi dmenu
    run_rofi() {
    	${pkgs.coreutils}/bin/echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
    }

    # Execute Command
    run_cmd() {
    	selected="$(confirm_exit)"
    	if [[ "$selected" == "$yes" ]]; then
    		if [[ $1 == '--shutdown' ]]; then
    			systemctl poweroff
    		elif [[ $1 == '--reboot' ]]; then
    			systemctl reboot
    		elif [[ $1 == '--suspend' ]]; then
    			${pkgs.playerctl}/bin/playerctl pause
    			${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
    			systemctl suspend
    		elif [[ $1 == '--logout' ]]; then
    			loginctl terminate-user $USER
    		fi
    	else
    		exit 0
    	fi
    }

    # Actions
    chosen="$(run_rofi)"
    case ''${chosen} in
        $shutdown)
    		run_cmd --shutdown
            ;;
        $reboot)
    		run_cmd --reboot
            ;;
        $lock)
          loginctl lock-session
            ;;
        $suspend)
    		run_cmd --suspend
            ;;
        $logout)
    		run_cmd --logout
            ;;
    esac
  '';

in {

  environment.systemPackages = [ rofi-hypr-powermenu ];

  home-manager.users.${vars.username} = {
    home.file.".config/rofi/hypr-powermenu/style-10.rasi" = {
      text = ''
        /**
         * Author : Aditya Shakya (adi1090x)
         * Github : @adi1090x
         * Rofi Theme File
         * Rofi Version: 1.7.3
         **/

        /*****----- Configuration -----*****/
        configuration {
            show-icons:                 false;
        }

        /*****----- Global Properties -----*****/
        @import                          "/home/${vars.username}/.config/rofi/colors.rasi"
        @import                          "/home/${vars.username}/.config/rofi/font.rasi"

        /*
        USE_BUTTONS=YES
        */

        /*****----- Main Window -----*****/
        window {
            /* properties for window widget */
            transparency:                "real";
            location:                    center;
            anchor:                      center;
            fullscreen:                  false;
            width:                       1200px;
            x-offset:                    0px;
            y-offset:                    0px;

            /* properties for all widgets */
            enabled:                     true;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @selected;
            cursor:                      "default";
            background-color:            transparent;
        }

        /*****----- Main Box -----*****/
        mainbox {
            enabled:                     true;
            spacing:                     25px;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @selected;
            background-color:            transparent;
            children:                    [ "inputbar", "listview" ];
        }

        /*****----- Inputbar -----*****/
        inputbar {
            enabled:                     true;
            spacing:                     0px;
            margin:                      0px;
            padding:                     0px;
            border:                      0px;
            border-radius:               0px;
            border-color:                @selected;
            background-color:            transparent;
            text-color:                  @foreground;
            children:                    [ "textbox-prompt-colon", "prompt"];
        }

        dummy {
            background-color:            transparent;
        }

        textbox-prompt-colon {
            enabled:                     true;
            expand:                      false;
            str:                         "";
            padding:                     20px 24px;
            border-radius:               100% 0px 0px 100%;
            background-color:            @urgent;
            text-color:                  @background;
        }
        prompt {
            enabled:                     true;
            padding:                     20px;
            border-radius:               0px 100% 100% 0px;
            background-color:            @background;
            text-color:                  @active;
        }

        /*****----- Message -----*****/
        message {
            enabled:                     true;
            margin:                      0px 50px;
            padding:                     15px;
            border:                      0px solid;
            border-radius:               100%;
            border-color:                @selected;
            background-color:            @background-alt;
            text-color:                  @foreground;
        }
        textbox {
            background-color:            inherit;
            text-color:                  inherit;
            vertical-align:              0.5;
            horizontal-align:            0.5;
            placeholder-color:           @foreground;
            blink:                       true;
            markup:                      true;
        }
        error-message {
            padding:                     12px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @selected;
            background-color:            @background;
            text-color:                  @foreground;
        }

        /*****----- Listview -----*****/
        listview {
            enabled:                     true;
            columns:                     5;
            lines:                       1;
            cycle:                       true;
            dynamic:                     true;
            scrollbar:                   false;
            layout:                      vertical;
            reverse:                     false;
            fixed-height:                true;
            fixed-columns:               true;

            spacing:                     15px;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @selected;
            background-color:            transparent;
            text-color:                  @foreground;
            cursor:                      "default";
        }

        /*****----- Elements -----*****/
        element {
            enabled:                     true;
            spacing:                     0px;
            margin:                      0px;
            padding:                     70px 10px;
            border:                      0px solid;
            border-radius:               100%;
            border-color:                @selected;
            background-color:            @background-alt;
            text-color:                  @foreground;
            cursor:                      pointer;
        }
        element-text {
            font:                        "feather bold 48";
            background-color:            transparent;
            text-color:                  inherit;
            cursor:                      inherit;
            vertical-align:              0.5;
            horizontal-align:            0.5;
        }
        element selected.normal {
            background-color:            var(selected);
            text-color:                  var(background);
        }
      '';
    };
  };
}
