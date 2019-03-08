#!/bin/bash
# find all the module-file locations, get the default versions 
# (TODO: modify to use when defualt version not available
# Search easybuild for that version 
# (TODO; Fix  easybuld should be loaded for this to work at the moment)

#for MPATH in $(echo $MODULEPATH | tr : ' '); 
for MPATH in $(echo "/cluster/etc/modulefiles" | tr : ' '); 
do 
	echo $MPATH 
	if [ -d  $MPATH ]
	then
		for TOOL in $(ls $MPATH) ; 
		do 
			#echo "$MPATH/$TOOL"
			ebcommand=""
			#echo "$MPATH/$TOOL/.version"
			if [ -f  "$MPATH/$TOOL/.version" ]
			then
				#printf "eb --search \"$TOOL-" 
				#cat "$MPATH/$TOOL/.version" |grep set |awk -F '\\"' '{print $2 "\""}' 
				#cat $MPATH/$TOOL/.version
				ebcommand="$ebcommand --search $TOOL" 
				TOOL_VERIONS=$(cat $MPATH/$TOOL/.version | grep set |awk -F '\\"' '{print $2}')
			        ebcommand_version="$ebcommand-$TOOL_VERIONS" 
				echo ebcommand_version >> all_packages.txt
				#ebcommand_version="eb $ebcommand_version"
				#ebcommand="eb $ebcommand"
				echo  $ebcommand
				result=$(eval $ebcommand |  grep "*" |tail -1)
				if [ ! -z "$result" ]
				then
					#echo "$result"
					echo "$TOOL  --  fonud  $result" >> found.txt
					result_v=$(eval $ebcommand_version)
					if [ ! -z "$result_v" ]
					then
						echo  "$TOOL-$TOOL_VERIONS --  fonud " >> exact_version_of_defualt_found.txt
					fi

				#else
				fi				
			#else
			#	echo "$MPATH/$TOOL/.version not found"
			fi
		done
	fi
done
