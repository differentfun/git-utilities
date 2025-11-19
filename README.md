# git-discard

`git-discard` wires Git aliases that drop local work and quickly commit/push pending changes.

- `discard`: reset tracked files to `HEAD` and delete untracked files/dirs (`git reset --hard HEAD && git clean -fd`).
- `shoot`: run `git add . && git commit -am "<msg>" && git push` with a single command. Requires a non-empty message.

## Install the alias

Run the installer scripts (each defaults to `--global`):

```sh
./git-discard.sh
# or: ./git-discard.sh --local

./git-shoot.sh
# or: ./git-shoot.sh --local
```

## Use the alias

From inside a repository:

```sh
git discard

git shoot "your commit message"
```

What happens:
- Tracked files are reset to `HEAD`.
- Untracked files/dirs are removed.
- Ignored files are left untouched; add `x` to `git clean` if you want those gone too.

**Danger:** this is destructive. Consider a dry run with `git status` and `git clean -fdn` before using it.

Note: running the installer will also remove the legacy alias `git-discard` if you created it previously.
