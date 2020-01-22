#!/bin/ash
if [ ! -e /minecraft/eula.txt ]; then
  if [ "$EULA" != "true" -a "$EULA" != "TRUE" ]; then
    echo ""
    echo "You need to accept Minecraft EULA"
    echo "  https://account.mojang.com/documents/minecraft_eula"
    echo "if you accept Minecraft EULA, add "
    echo "  -e EULA=true"
    echo "option on startup."
    exit 1
  fi
  echo "eula=$EULA" >> eula.txt
  if [ $? != 0 ]; then
    echo "ERROR: unable to write eula to /minecraft."
    exit 1
  fi
fi

cp /minecraft/bukkit.yml /minecraft/bukkit.yml.org
sed -e "s/WORLDCONTAINER/\/vol\/ver151\/2020_01_21/g" /minecraft/bukkit.yml.org > /minecraft/bukkit.yml
echo "---DEBUG---"
echo "1:${SAVE};"
echo "2:$SAVE;"
echo "---END---"
java -Xmx${MEMORY} -jar /minecraft/spigot.jar nogui
