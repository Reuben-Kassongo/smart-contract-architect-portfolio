# Release Checklist

This checklist defines the standard release process for `forge-std`.

## Steps

- [ ] Update the version in `package.json`
- [ ] Open and merge a pull request containing the version bump
- [ ] Tag the merged commit with the release version: `git tag v<X.Y.Z>`
- [ ] Push the tag to the repository: `git push --tags`
- [ ] Create a new GitHub release named `v<X.Y.Z>` using the auto-generated changelog
- [ ] Add a `## Featured Changes` section at the top of the release notes

