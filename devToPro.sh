
cd /Users/111244rfsf/Documents/Repositories/alecscripts


IN="$(git tag)"

# must have $ for \n 
arrIN=(${IN//$\n/ })
LEN=${#arrIN[@]}
MAX=${arrIN[LEN - 1]}
decimal=(${MAX//./ })

major=${decimal[0]}
minor=${decimal[1]}
patch=${decimal[2]}

echo "Patch(p) Major(M) Minor(m)"
read choice
echo "Commit Message: "
read commitMessage
case $choice in

  p)
    patch=$(($patch+1))
    ;;

  M)
    major=$(($major+1))
    ;;
  m)
    minor=$(($minor+1))
    ;;
  *)
	patch=$(($patch+1))
	;;
esac


V="$major.$minor.$patch"

git checkout dev 
# push most recent changes 
git add .
git commit -m "$commitMessage"
git push 

# get version with git tag (list tags)
git tag -a $V -m "$commitMessage"

# Push all tags with --tags
git push origin --tags

git checkout production 
git merge dev 
git push