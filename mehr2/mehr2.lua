MEHR2 = {
    -- a provider is a package manager
    providers = {
        {
            -- list all packages to be installed with the pacman provider,
            name = "pacman",
            packages = {
                "git",
                "fish",
                "eza",
                "imagemagick",
                "firefox",
                "flameshot",
                "pipewire",
                "dunst",
                "rofi",
                "playerctl",
                "brightnessctl",
                "network-manager-applet",
                "thunar",
                "xorg-xwayland",

                "sway",
                "swaybg",
                "swayidle",
                "swaylock",
                "xdg-desktop-portal",
                "xdg-desktop-portal-wlr",
                "fuzzel",
                "wl-clipboard",

                -- Avoid package groups here.
                -- mehr2 queries package names (eg. via pacman -Q), not group aliases.
                -- Groups like "i3" may appear missing in `mehr info` even when their
                -- member packages are installed, so list individual packages explicitly.

                -- i3
                "i3-wm",
                "i3lock",
                "i3blocks",
                "i3status",

                "acpi",
                "zathura",
                "curl",
                "base-devel",
                "pamixer",
                "hugo",
                "go",
                "ghostty",
                "rustup",
                "yazi",
                "github-cli",

                "tree-sitter",
                "tree-sitter-cli",
            },
        },
        -- list all packages to be installed with the cargo provider
        { name = "cargo", packages = { "bat", "ripgrep" } },
        -- scratch runs these IF the scratch.identifier is not in the lock file
        {
            name = "scratch",
            packages = {
                {
                    -- the name of the package we are installing from scratch
                    identifier = "rustup-tooling",
                    -- this will error if rustup is not in the path or not executable
                    needs = { "rustup" },
                    -- the script to run in $SHELL in a /tmp directory
                    -- If the exit code is non-zero, the install is considered a failure.
                    script = [[
                        # chose default toolchain, depending on arch-os combination
                        rustup default stable

                        rustup component add rust-docs
                        rustup component add cargo
                        rustup component add clippy
                        rustup component add rustfmt
                        rustup component add rust-analyzer
                    ]]
                },
                {
                    identifier = "sway-session",
                    needs = { "sway" },
                    script = [[
                        chmod +x ~/.config/sway/start
                    ]]
                }
            },
        }
    },
}
