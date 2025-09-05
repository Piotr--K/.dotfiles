# Lazy.nvim Usage Guide

## Opening Lazy

### Main UI:
```vim
:Lazy
```
Opens the main dashboard where you can see all plugins and their status.

## Key Operations in the UI

### Navigation & Actions:
- **`I`** - Install missing plugins
- **`U`** - Update all plugins  
- **`S`** - Sync (clean + install + update)
- **`C`** - Check for updates (without installing)
- **`X`** - Clean unused plugins
- **`R`** - Reload a plugin
- **`L`** - Show plugin logs
- **`P`** - Show plugin profile/details
- **`?`** - Show help/keymaps

### Individual Plugin Actions:
- **`u`** - Update selected plugin
- **`r`** - Reload selected plugin
- **`gb`** - Go to plugin's Git repository
- **`gf`** - Find files in plugin directory

## Command Line Options

### Essential Commands:
```vim
:Lazy install    " Install missing plugins
:Lazy update     " Update plugins
:Lazy sync       " Run install, clean and update
:Lazy clean      " Clean plugins that are no longer needed
:Lazy check      " Check for plugin updates
```

### Additional Commands:
```vim
:Lazy log        " Show recent updates
:Lazy restore    " Restore plugins to lockfile state
:Lazy profile    " Show startup profiling
:Lazy debug      " Show debug information
:Lazy help       " Show help
```

## Typical Workflows

### Daily Usage:
1. **Check for updates**: `:Lazy` → press `C`
2. **Update all**: Press `U` to update everything
3. **Update selectively**: Navigate to plugin → press `u`

### After Config Changes:
1. **Full sync**: `:Lazy sync` (recommended)
2. **Or step by step**:
   - `:Lazy clean` (remove unused)
   - `:Lazy install` (add new)
   - `:Lazy update` (update existing)

### Troubleshooting:
1. **Plugin issues**: `:Lazy` → navigate to plugin → press `R` (reload)
2. **Rollback updates**: `:Lazy restore`
3. **Check logs**: `:Lazy log` or select plugin → press `L`

## UI Indicators

### Status Icons:
- **●** - Plugin has updates available
- **✓** - Plugin is up to date
- **✗** - Plugin has errors
- **⏳** - Plugin is loading/installing
- **🔒** - Plugin is pinned to specific version

### Color Coding:
- **Green** - Installed and up to date
- **Yellow** - Updates available
- **Red** - Errors or issues
- **Blue** - Currently processing

## Pro Tips

### Performance:
- **Startup profiling**: `:Lazy profile` to see load times
- **Lazy loading**: Most plugins load only when needed
- **Cleanup regularly**: Use `:Lazy clean` to remove unused plugins

### Safety:
- **Lockfile**: Lazy creates `lazy-lock.json` for reproducible installs
- **Rollback**: `:Lazy restore` reverts to lockfile versions
- **Backup config**: Always backup before major changes

### Efficiency:
- **Batch operations**: Use `S` (sync) for multiple operations
- **Auto-check**: Lazy shows update dots without manual checking
- **Quick access**: `:Lazy` is faster than `:PackerSync` was

## Migration Notes

### From Packer:
- **Old**: `:PackerSync`, `:PackerInstall`, `:PackerUpdate`
- **New**: `:Lazy sync`, `:Lazy install`, `:Lazy update`
- **UI**: Much more informative and interactive
- **Performance**: Significantly faster with lazy loading

### Key Differences:
- **Automatic lazy loading** - plugins load when needed
- **Better dependency management** - cleaner resolution
- **Real-time UI** - see progress and status immediately
- **Simpler commands** - fewer commands to remember

---

**Quick Reference**: `:Lazy` → `U` (update all) → `S` (sync) for most operations!