## Create project from skel
(Alternatively to all this you can do "use this template on github")

```
git clone https://github.com/Streq/GodotSkel.git miproject
cd miproject
rm -rf .git
git init -b develop
git add .
git commit -m"first commit"
gh repo create

? What would you like to do? Push an existing local repository to GitHub
? Path to local repository .
? Repository name miproject
? Description description
? Visibility Public
✓ Created repository Streq/miproject on GitHub
? Add a remote? Yes
? What should the new remote be called? origin
✓ Added remote git@github.com:Streq/miproject.git
? Would you like to push commits from the current branch to "origin"? Yes
✓ Pushed commits to git@github.com:Streq/miproject.git
```

## Setup main and gh-pages branches and scripts
```
chmod +x setup.sh
./setup.sh
```

## Update secrets
```
#edit secrets.sh with keys and configs
./secrets.sh
```

## Create nightly release
```
gh release create nightly
? Title (optional) nightly
? Release notes Leave blank
? Is this a prerelease? No
? Submit? Publish release
```

## Release
```
chmod +x release.sh
./release.sh "release message"
```

## Versioning by commit message
```
#in develop
git commit -m"(MAJOR) algo" # 1.0.0 -> 2.0.0
git commit -m"(MINOR) algo" # 1.0.0 -> 1.1.0
git commit -m"algo"         # 1.0.0 -> 1.0.1
```
