# bulk-git-script

This script does GIT bulk operation like status, pull, push


# Examples

Bulk git status operation (all repositories folders)

```
bulk-git --bulk --status main 
```

Bulk git pull operation (all repositories folders)
 
```
bulk-git --bulk --pull main 
```

Bulk git push operation (all repositories folders)
 
```
bulk-git --bulk --push main 
```

Bulk git push operation (some repositries folders)
 
```
bulk-git --status repFolder01 repFolder02 respFolder03 branch 
```

Git status of the myrepA and myrepB prj
```
bulk-git --status myrepA myrepB main 
```


# Compiled with shc

```
shc -f bulk-git.sh
```

