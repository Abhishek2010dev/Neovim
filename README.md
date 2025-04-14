# My Custom Neovim Configuration

This is my custom Neovim setup, designed for efficiency, performance, and a smooth development experience. The configuration is written in **Lua** and managed with **Lazy.nvim**.

## 📂 Directory Structure

```
.
├── init.lua                # Main Neovim configuration entry point
├── lazy-lock.json          # Lazy.nvim lockfile
├── lua/
│   ├── config/             # Core configurations
│   │   ├── lazy.lua        # Plugin manager setup
│   │   ├── lsp.lua         # LSP configuration
│   │   └── options.lua     # General editor options
│   └── plugins/            # Plugin configurations
│       ├── autopairs.lua   # Autopairing brackets/quotes
│       ├── colorscheme.lua # Theme and UI settings
│       ├── flash.lua       # Flash navigation
│       ├── format.lua      # Code formatting
│       ├── gitsigns.lua    # Git signs and integration
│       ├── go.lua          # Go language support
│       ├── indent_line.lua # Indentation guides
│       ├── init.lua        # Plugin loader
│       ├── lint.lua        # Linter setup
│       ├── lsp.lua         # Language server configurations
│       ├── lualine.lua     # Statusline setup
│       ├── rust.lua        # Rust language support
│       ├── snacks.lua      # Additional small utilities
│       ├── trouble.lua     # Diagnostics list
│       └── which_key.lua   # Keybinding helper
└── README.md               # This file
```

## 📊 Code Stats

```
===============================================================================
 Language            Files        Lines         Code     Comments       Blanks
===============================================================================
 JSON                    1           28           28            0            0
 Lua                    19         1083         1010           32           41
 Markdown                1            1            0            1            0
===============================================================================
 Total                  21         1112         1038           33           41
===============================================================================
```

## ⚡ Features

- **Minimal & Fast**: Optimized for speed without unnecessary bloat.
- **LSP Support**: Integrated Language Server Protocol for better coding experience.
- **Autocomplete & Formatting**: Auto-pairing, linting, and formatting.
- **Git Integration**: Gitsigns and other utilities for Git workflows.
- **Beautiful UI**: Custom themes, status line, and UI enhancements.
- **Rust & Go Support**: Language-specific enhancements for Rust and Go.

## 🛠️ Installation

1. Install Neovim (v0.9+ recommended).
2. Clone this repository into your Neovim config directory:
   ```sh
   git clone https://github.com/Abhishek2010dev/Neovim ~/.config/nvim
   ```
3. Open Neovim and install plugins:
   ```sh
   nvim
   ```
   Lazy.nvim will automatically install required plugins.

## 🔧 Customization

Modify files inside `lua/config` and `lua/plugins` to tweak the setup to your liking.

## 📜 License

This configuration is open-source and available under the MIT License.

---

Enjoy coding with Neovim! 🚀
