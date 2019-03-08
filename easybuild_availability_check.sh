#!/bin/bash
# find all the module-file locations, get the default versions 
# (TODO: modify to use when defualt version not available
# Search easybuild for that version 
# (TODO; Fix  easybuld should be loaded for this to work at the moment)

for MPATH in $(echo $MODULEPATH | tr : ' '); 
do 
	#echo $MPATH 
	if [ -d  $MPATH ]
	then
		for TOOL in $(ls $MPATH | head -n 3); 
		do 
			#echo "$MPATH/$TOOL"
			ebcommand="eb "
			if [ -f  "$MPATH/$TOOL/.version" ]
			then
				#printf "eb --search \"$TOOL-" 
				#cat "$MPATH/$TOOL/.version" |grep set |awk -F '\\"' '{print $2 "\""}' 

				ebcommand="$ebcommand --search \"$TOOL-" 
			        ebcommand="$ebcommand $MPATH/$TOOL/.version" |grep set |awk -F '\\"' '{print $2 "\""}' 
				echo $ebcommand
			#else
			#	echo "$MPATH/$TOOL/.version not found"
			fi
		done
	fi
done
