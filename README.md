# my-zsh
my zsh dotfiles

## slick
`my-zsh` now only sets `SLICK_PROMPT_*` customizations. Load `slick` separately so the prompt integration stays synced with upstream.

Example with `zinit`:

```zsh
zinit load nbari/my-zsh
zinit light nbari/slick
```
