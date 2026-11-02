# my-zsh
my zsh dotfiles

## Git history

- `gl`: local branch history with local branch and HEAD labels, from the last week.
- `gla`: history across all refs, including remote branches, tags, and stash, from the last week.
- Add `-a` to either command to remove the time limit: `gl -a` or `gla -a`.
- Other `git log` arguments pass through, for example `gl -a -n 30`.

`gl` includes `main`, `develop`, and `sandbox` when they exist locally, along with
any other local branches. To focus strictly on those three branches, use
`git log --graph --oneline --decorate main develop sandbox`.

## slick
`my-zsh` now only sets `SLICK_PROMPT_*` customizations. Load `slick` separately so the prompt integration stays synced with upstream.

Example with `zinit`:

```zsh
zinit load nbari/my-zsh
zinit light nbari/slick
```
