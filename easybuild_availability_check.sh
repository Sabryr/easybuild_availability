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
				TOOL_SEARCH_TERM="$(echo $TOOL | tr + ' ')"
				ebcommand="$ebcommand --search $TOOL_SEARCH_TERM" 
				#echo $ebcommand
				TOOL_VERIONS=$(cat $MPATH/$TOOL/.version | grep set |awk -F '\\"' '{print $2}')
			        ebcommand_version="$ebcommand-$TOOL_VERIONS" 
				echo "$TOOL-$TOOL_VERIONS" >> all_on_abel.txt
				ebcommand_version="eb $ebcommand_version"
				ebcommand="eb $ebcommand"
				echo  $ebcommand
				result=$(eval $ebcommand |grep -v -i patch |grep "*" |tail -1 | awk -F "/" '{print $NF}')
				#echo "$result"
				if [ ! -z "$result" ]
				then
					#echo "$result"
					echo "$TOOL-$TOOL_VERIONS  --found--  $result" >> found_in_easybuild.txt
					#result_v=$(eval $ebcommand_version)
					if [ ! -z "$result_v" ]
					then
						echo  "$TOOL-$TOOL_VERIONS --found-- " >> exact_version_in_easybuild
					fi

				else
					echo "$TOOL-$TOOL_VERIONS  --not-found--  $result" >> not_found_in_easybuild.txt
				fi				
			#else
			#	echo "$MPATH/$TOOL/.version not found"
			fi
		done
	fi
done
