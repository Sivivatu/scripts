# command for formatting a device with a specific filesystem for Unraid
# size require is 512 byte sectors.
# Info taken from https://forum.level1techs.com/t/how-to-reformat-520-byte-drives-to-512-bytes-usually/133021

# Command commented out after running
# sg_format -v --format --size=512 /dev/sdg
# sg_format -v --format --size=512 /dev/sde
# sg_format -v --format --size=512 /dev/sdf
sg_format -v --format --size=512 /dev/sdh

#clearLog=true
#argumentDescription=list of devices to format
#argumentDefault=/dev/drive1 /dev/drive2 etc
#argumentDefault=/dev/sdt /dev/sdu /dev/sdv /dev/sdw /dev/sdx /dev/sdy /dev/sdz

for var in $1
do
    if sg_format $var | grep "size=520"
    then
        echo "$(date +%F_%T) - Formatting $var"
        sg_format -v --format --size=512 $var
    else
        echo "$(date +%F_%T) - Skipping $var"
    fi
done