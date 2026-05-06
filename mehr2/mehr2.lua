MEHR2 = {
    -- a provider is a package manager
    providers = {
        {
            -- list all packages to be installed with the pacman provider,
            name = "pacman",
            packages = {
                "git",
                "picom",
                "fish",
                "imagemagick",
                "firefox",
                "flameshot",
                "pipewire",
                "dunst",
                "rofi",

                -- Avoid package groups here.
                -- mehr2 queries package names (eg. via pacman -Q), not group aliases.
                -- Groups like "i3" may appear missing in `mehr info` even when their
                -- member packages are installed, so list individual packages explicitly.
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
            },
        },
        -- list all packages to be installed with the cargo provider
        { name = "cargo", packages = { "exa", "bat", "ripgrep" } },
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
                    rustup component add rust-docs
                    rustup component add cargo
                    rustup component add clippy
                    rustup component add rustfmt
                    ]]
                },
                {
                    identifier = "nvim",
                    needs = { "git", "make", "cmake", "gcc" },
                    script = [[
                    git clone https://github.com/neovim/neovim
                    cd neovim
                    git switch nightly
                    make CMAKE_BUILD_TYPE=Release
                    make install
                    ]]
                },
            },
        }
    },
}
