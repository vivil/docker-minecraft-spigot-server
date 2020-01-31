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

if [ "$SAVEROOT" == "" ]; then
  echo ""
  echo "Invalid SAVE parameter."
  echo ""
  exit 1
else
  echo ""
  echo "DEBUG:SAVEROOT is :${SAVEROOT}"
  echo "DEBUG:CLASS is :${CLASS}"
  echo "DEBUG:DATE is :${DATE}"
  echo "DEBUG:TIME is :${TIME}"
  
  cp /minecraft/bukkit.yml /minecraft/bukkit.yml.org
  sed -e "s/WORLDCONTAINER/\/${SAVEROOT}\/${CLASS}\/${DATE}_${TIME}/g" /minecraft/bukkit.yml.org > /minecraft/bukkit.yml
fi

java -Xmx${MEMORY} -jar /minecraft/spigot.jar nogui
