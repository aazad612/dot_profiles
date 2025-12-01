gittest() {
  git add .
  git commit -m "${1:-test}"
  git push
}

# Cleanup after updating gitignore
git rm --cached `git ls-files -i -c --exclude-from=.gitignore`

# Forced Cleanup
# rm -rf .git
# git init
# git add .
# git commit -m "Initial clean commit without .terraform junk"
# git branch -M main
# git remote add origin https://github.com/aazad612/smartui.git
# git push -u origin main
