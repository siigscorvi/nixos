{ pkgs, ... }:

let
  docs-update = pkgs.writeShellScriptBin "docs-update" ''
LOGFILE="/tmp/docs-update.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

{
  ${pkgs.libnotify}/bin/notify-send "docs-update" "[$TIMESTAMP] Starting update of docs..."

  ssh siigs@rpi.siigs.de << 'EOF'
cd quartz/vault || { echo "Failed to cd into quartz/vault"; exit 1; }
git pull || { echo "Git pull failed"; exit 1; }
docker exec quartz npx quartz build || { echo "Quartz build failed"; exit 1; }
EOF

  if [ $? -eq 0 ]; then
    ${pkgs.libnotify}/bin/notify-send "Deploy Script" "✅ Deployment successful"
  else
    ${pkgs.libnotify}/bin/notify-send "Deploy Script" "❌ Deployment failed"
  fi

} >> "$LOGFILE" 2>&1

  '';

in {
  environment.systemPackages = [ docs-update ];
}
