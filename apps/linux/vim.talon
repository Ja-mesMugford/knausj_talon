# Usage:
#  - See doc/vim.md
#  - See code/vim.py
# ToDo:
#  - new terminal buffer command

os:linux
app:gvim
app:/term/
and win.title:/VIM/
-

tag(): vim
settings():
    # Whether or not to always revert back to the previous mode
    user.vim_preserve_insert_mode = 1
    user.vim_adjust_modes = 1
    user.vim_notify_mode_changes = 0

###
# Actions - Talon generic_editor.talon implementation
###
#
# NOTE: You can disable generic_editor.talon by renaming it, and still fully
# control vim. These are more for people that are used to the official talon
# editor commands that want to trial vim a bit.
#
# If you prefer to work from INSERT mode, you may want to add the ctrl-o key
# prior to most of these
#
# Note that I don't use any of the below, so they have not been thoroughly
# tested and the VISUAL mode selection stuff will almost certainly not work as
# expected.
###
action(edit.find):
    key(/)
action(edit.find_next):
    key(n)
action(edit.word_left):
    key(b)
action(edit.word_right):
    key(w)
action(edit.left):
    key(left)
action(edit.right):
    key(right)
action(edit.up):
    key(up)
action(edit.down):
    key(down)
action(edit.line_start):
    key(^)
action(edit.line_end):
    key($)
action(edit.file_end):
    key(G)
action(edit.file_start):
    "gg"
action(edit.page_down):
    key(ctrl-f)
action(edit.page_up):
    key(ctrl-b)
action(edit.extend_line_end):
    "v$"
action(edit.extend_left):
    "vh"
action(edit.extend_right):
    "vl"
action(edit.extend_line_up):
    "vk"
action(edit.extend_line_down):
    "vj"
action(edit.extend_word_left):
    "vb"
action(edit.extend_word_right):
    "vw"
action(edit.extend_line_start):
    "v^"
action(edit.extend_file_start):
# creating splits
    "vgg"
action(edit.extend_file_end):
    "vG"
action(edit.indent_more):
    ">>"
action(edit.indent_less):
    "<<"
action(edit.delete_line):
    "dd"
action(edit.delete):
    key(x)

# note these are for mouse highlighted copy/paste. shouldn't be used for actual
# vim commands
action(edit.copy):
    key(ctrl-shift-c)
action(edit.paste):
    key(ctrl-shift-v)

###
# `code/vim.py` actions based on vimspeak
###
# commands that can be triggered in visual or normal mode, and generally don't
# have counting, etc
<user.vim_normal_counted_motion_command>:
    insert("{vim_normal_counted_motion_command}")
#<user.vim_counted_command>:
#    insert("{vim_counted_command}")
<user.vim_motions_all_adjust>:
    insert("{vim_motions_all_adjust}")
<user.vim_normal_counted_action>:
    insert("{vim_normal_counted_action}")

# XXX YYY ZZZ

###
# File editing and management
###
# NOTE: using `save` alone conflicts too much with the `say`
save file:
    user.vim_normal_mode(":w\n")
save [file] as:
    key(escape)
    user.vim_normal_mode(":w ")
save all:
    user.vim_normal_mode(":wa\n")
save and (quit|close):
    user.vim_normal_mode(":wq\n")
(close|quit) file:
    user.vim_normal_mode(":q\n")
force (close|quit):
    user.vim_normal_mode(":q!\n")
refresh file:
    user.vim_normal_mode(":e!\n")
edit [file|new]:
    user.vim_normal_mode(":e ")
reload [vim] config:
    user.vim_normal_mode(":so $MYVIMRC\n")

# For when the VIM cursor is hovering on a path
# XXX - need to test if technically these work in visual
open [this] link: user.vim_normal_mode("gx")
open this file: user.vim_normal_mode("gf")
open this file in [split|window]:
    key(ctrl-w)
    key(f)
open this file in vertical [split|window]:
    insert(":vertical wincmd f\n")

(show|list) current directory: user.vim_normal_mode(":pwd\n")
change buffer directory: user.vim_normal_mode(":lcd %:p:h\n")

^#
###
# Standard commands
###
# XXX - are technically handled by vim.py
redo:
    user.vim_normal_mode_key("ctrl-r")
#undo:
#    user.vim_normal_mode_key("u")

###
# Navigation, movement and jumping
#
# NOTE: Majority of more core movement verbs are in code/vim.py
###
[(go|jump)] [to] line <number>:
    user.vim_normal_mode(":{number}\n")

# XXX - could be multiple modes
matching: key(%)

# jump list
show jump list: user.vim_normal_mode(":jumps\n")
clear jump list: user.vim_normal_mode(":clearjumps\n")
(prev|previous|older) jump [entry]: user.vim_normal_mode_key("ctrl-o")
(next|newer) jump [entry]: user.vim_normal_mode_key("ctrl-i")

# ctags/symbol
(jump|dive) [to] (symbol|tag): user.vim_normal_mode_key("ctrl-]")
(pop|leave) (symbol|tag): user.vim_normal_mode_key("ctrl-t")

# scrolling and page position
(focus|orient) [on] line <number>: ":{number}\nzt"
center [on] line <number>: ":{number}\nz."
scroll top: user.vim_normal_mode("zt")
scroll (center|middle): "zz"
scroll bottom: "zb"
scroll top reset cursor: "z\n"
scroll middle reset cursor: "z."
scroll bottom reset cursor: "z "
scroll up: user.vim_normal_mode_key("ctrl-y")
scroll down: key(ctrl-e)
page down: key(ctrl-f)
page up: key(ctrl-b)
half [page] down: key(ctrl-d)
half [page] up: key(ctrl-u)

###
# Text editing, copying, and manipulation
###

change remaining line: key(C)
change line: "cc"
# XXX - this might be suited for some automatic motion thing in vim.py
swap characters: "xp"
swap words: "dwwP"
swap lines: "ddp"
swap paragraph: "d}}p"
replace <user.any>: "r{any}"
replace (ship|upper|upper case) <user.letters>:
    "r"
    user.keys_uppercase_letters(letters)

# indenting
(shift|indent) right: ">>"
indent [line] <number> through <number>$: ":{number_1},{number_2}>\n"
(shift|indent) left: "<<"
unindent [line] <number> through <number>$: ":{number_1},{number_2}>\n"


# XXX - this doesn't work with numbers below nine, because the nine will
# trigger its own discrete command in the first part of the command will
# trigger the dd below. we probably need to come up with different trigger for
# the one were you specify the line

# deleting
delete remaining line: key(D)
delete line (at|number) <number>$: ":{number}d\n"
delete line (at|number) <number> through <number>$: ":{number_1},{number_2}d\n"
delete line: "dd"

# insert mode only
clear line: key(ctrl-u)

# copying
(copy|yank) line (at|number) <number>$: ":{number}y\n"
(copy|yank) line (at|number) <number> through <number>: ":{number_1},{number_2}y\n"
(copy|yank) line: "Y"

# duplicating
(duplicate|paste) line <number> on line <number>$: ":{number_1}y\n:{number_2}\np"
(duplicate|paste) line (at|number) <number> through <number>$: ":{number_1},{number_2}y\np"
(duplicate|paste) line <number>$: ":{number}y\np"

(dup|duplicate) line: "Yp"

# start ending at end of line
push line:
    key(escape)
    key(A)

# start ending at end of file
push file:
    key(escape)
    insert("Go")

# helpful for fixing typos or bad lexicons that miss a character
inject <user.any> [before]:
    insert("i{any}")
    key(escape)

inject <user.any> after:
    insert("a{any}")
    key(escape)

filter line: "=="

[add] gap above: ":pu! _\n:'[+1\n"
[add] gap below: ":pu _\n:'[-1\n"

# XXX - This should be a callable function so we can do things like:
#       'swap on this <highlight motion>'
#       'swap between line x, y'
swap (selected|highlighted):
    insert(":")
    # leave time for vim to populate '<,'>
    sleep(50ms)
    insert("s///g")
    key(left)
    key(left)
    key(left)

reswap (selected|highlighted):
    insert(":")
    # leave time for vim to populate '<,'>
    sleep(50ms)
    key(up)

# Selects current line in visual mode and triggers a word swap
swap [word] on [this] line:
    key(V)
    insert(":")
    sleep(50ms)
    insert("s///g")
    key(left)
    key(left)
    key(left)

deleted selected empty lines:
    insert(":")
    # leave time for vim to populate '<,'>
    sleep(50ms)
    insert("g/^$/d\j")

swap global:
    insert(":%s///g")
    key(left)
    key(left)
    key(left)

# XXX - these should not retain insert mode across jumps
# XXX - should explicitly call terminal-escaping method
###
# Buffers
###
((buf|buffer) list|list (buf|buffer)s):
    user.vim_normal_mode(":ls\n")
(buf|buffer) (close|delete) <number>: user.vim_normal_mode(":bd {number} ")
(close|delete) (buf|buffer) <number>: user.vim_normal_mode(":bd {number} ")
(buf|buffer) close current: user.vim_normal_mode(":bd\n")
(delete|close) (current|this) buffer: user.vim_normal_mode(":bd\n")
force (buf|buffer) close: user.vim_normal_mode(":bd!\n")
(buf|buffer) open: user.vim_normal_mode(":b ")
(buf|buffer) (first|rewind): user.vim_normal_mode(":br\n")
(buf|buffer) (left|prev): user.vim_normal_mode(":bprev\n")
(buf|buffer) (right|next): user.vim_normal_mode(":bnext\n")
(buf|buffer) flip: user.vim_normal_mode(":b#\n")
(buf|buffer) last: user.vim_normal_mode(":bl\n")
close (bufs|buffers): user.vim_normal_mode(":bd ")
[(go|jump|open)] (buf|buffer) <number>: user.vim_normal_mode(":b {number}\n")

# XXX - these should not retain insert mode across jumps
# XXX - should explicitly call terminal-escaping method
###
# Splits
###
# creating splits
new split:
    # XXX - until we have key combo support
    user.vim_set_normal_mode()
    key("ctrl-w")
    key(s)
new vertical split:
    # XXX - until we have key combo support
    user.vim_set_normal_mode()
    key("ctrl-w")
    key(v)
split (close|quit):
    # XXX - until we have key combo support
    user.vim_set_normal_mode()
    key(ctrl-w)
    key(q)

new empty split:
    key(escape)
    user.vim_normal_mode(":new\n")
new empty vertical split:
    key(escape)
    user.vim_normal_mode(":vnew\n")

# navigating splits
split <user.vim_arrow>:
    # XXX - until we have key combo support
    user.vim_set_normal_mode()
    key(ctrl-w)
    key("{vim_arrow}")
split last:
    # XXX - until we have key combo support
    user.vim_set_normal_mode()
    key(ctrl-w)
    key(p)
split top left:
    # XXX - until we have key combo support
    user.vim_set_normal_mode()
    key(ctrl-w)
    key(t)
split next:
    # XXX - until we have key combo support
    user.vim_set_normal_mode()
    key(ctrl-w)
    key(w)
split (previous|prev):
    # XXX - until we have key combo support
    user.vim_set_normal_mode()
    key(ctrl-w)
    key(W)
split bottom right:
    # XXX - until we have key combo support
    user.vim_set_normal_mode()
    key(ctrl-w)
    key(b)
split preview:
    key(ctrl-w)
    key(P)

# moving windows
split (only|exclusive):
    key(ctrl-w)
    key(o)
split rotate [right]:
    key(ctrl-w)
    key(r)
split rotate left:
    key(ctrl-w)
    key(R)
move split top:
    key(ctrl-w)
    key(K)
move split bottom:
    key(ctrl-w)
    key(J)
move split right:
    key(ctrl-w)
    key(H)
move split left:
    key(ctrl-w)
    key(L)
move split to tab:
    key(ctrl-w)
    key(T)

# window resizing
split (balance|equalize):
    key(ctrl-w)
    key(=)
split taller:
    key(ctrl-w)
    key(+)
split shorter:
    key(ctrl-w)
    key(-)
split fatter:
    key(ctrl-w)
    key(>)
split skinnier:
    key(ctrl-w)
    key(<)
set split width:
    key(escape)
    insert(":resize ")
set split height:
    key(escape)
    insert(":vertical resize ")

###
# Diffing
###
(split|window) start diff:
    key(escape)
    insert(":windo diffthis\n")

(split|window) end diff:
    key(escape)
    insert(":windo diffoff\n")

buffer start diff:
    key(escape)
    insert(":bufdo diffthis\n")

buffer end diff:
    key(escape)
    insert(":bufdo diffoff\n")

###
# Tab
###
# XXX - these should not retain insert mode across jumps
# XXX - should explicitly call terminal-escaping method

(list|show) tabs: user.vim_normal_mode(":tabs\n")
tab close: user.vim_normal_mode(":tabclose\n")
tab (next|right): user.vim_normal_mode(":tabnext\n")
tab (left|prev|previous): user.vim_normal_mode(":tabprevious\n")
tab first: user.vim_normal_mode(":tabfirst\n")
tab last: user.vim_normal_mode(":tablast\n")
tab flip: user.vim_normal_mode("g\t")
tab new: user.vim_normal_mode(":tabnew\n")
tab edit: user.vim_normal_mode(":tabedit ")
[(go|jump|open)] tab <number>: user.vim_normal_mode("{number}gt")
[new] tab terminal: user.vim_normal_mode(":tab term://bash\n")
move tab right: user.vim_normal_mode(":tabm +\n")
move tab left: user.vim_normal_mode(":tabm -\n")

###
# Settings
###
(hide|unset) (highlight|hightlights): user.vim_normal_mode(":nohl\n")
set highlight search: user.vim_normal_mode(":set hls\n")
set no highlight search: user.vim_normal_mode(":set nohls\n")
(show|set) line numbers: user.vim_normal_mode(":set nu\n")
(hide|set no) line numbers: user.vim_normal_mode(":set nonu\n")
show [current] settings: user.vim_normal_mode(":set\n")
unset paste: user.vim_normal_mode(":set nopaste\n")
# very useful for reviewing code you don't want to accidintally edit if talon
# mishears commands
set modifiable: user.vim_normal_mode(":set modifiable\n")
unset modifiable: user.vim_normal_mode(":set nomodifiable\n")

###
# Marks
###
new mark <user.letter>:
    key(m)
    key(letter)
(go|jump) [to] mark <user.letter>:
    key(`)
    key(letter)
(del|delete) (mark|marks):
    key(escape)
    insert(":delmarks ")
(del|delete) all (mark|marks):
    key(escape)
    insert(":delmarks! ")
(list|show) [all] marks:
    key(escape)
    insert(":marks\n")
(list|show) specific marks:
    key(escape)
    insert(":marks ")
(go|jump) [to] [last] edit: "`."
(go|jump) [to] [last] (cursor|location): "``"

###
# Sessions
###
(make|save) session: ":mksession "
force (make|save) session: ":mksession! "
(load|open) session: user.vim_normal_mode(":source ")

###
# Macros and registers ''
###
show (registers|macros): user.vim_normal_mode(":reg\n")
show (register|macro) <user.letter>: user.vim_normal_mode(":reg {letter}\n")
play macro <user.letter>: user.vim_any_motion_mode("@{letter}")
repeat macro: "@@"
record macro <user.letter>: "q{letter}"
stop recording: key(q)
modify [register|macro] <user.letter>:
    ":let @{letter}='"
    key(ctrl-r)
    key(ctrl-r)
    insert("{letter}")
    key(')

# XXX - these could be valid in normal or visual
paste from register <user.any>: insert('"{any}p')
yank to register <user.any>: insert('"{any}y')

###
# Informational
###
display current line number: user.vim_normal_mode_key(ctrl-g)
file info: user.vim_normal_mode_key(ctrl-g)
# shows buffer number by pressing 2
extra file info:
    key(2)
    key(ctrl-g)
vim help: user.vim_normal_mode(":help ")

###
# Mode Switching
###
normal mode: user.vim_set_normal_mode_np()
insert mode: user.vim_set_insert_mode()
replace mode: key(R)
overwrite: key(R)

visual mode: user.vim_set_visual_mode()
(visual|select|highlight) line: key(V)

visual block mode: key(ctrl-v)
(visual|select|highlight) block: key(ctrl-v)

###
# Searching
###
search:
    user.vim_any_motion_mode("/\c")

search sensitive:
    key(escape)
    insert("/\C")

search <phrase>$:
    key(escape)
    insert("/\c{phrase}\n")

search <phrase> sensitive$:
    key(escape)
    insert("/\C{phrase}\n")

search <user.ordinals> <phrase>$:
    key(escape)
    insert("{ordinals}/\c{phrase}\n")

search (reversed|reverse) <phrase>$:
    key(escape)
    insert("?\c{phrase}\n")

search (reversed|reverse):
    key(escape)
    insert("?\c")

search (reversed|reverse) sensitive:
    key(escape)
    insert("?\C")

###
# Text Selection
###
select <user.vim_select_motion>:
    insert("v{vim_select_motion}")

select lines <number> through <number>:
    insert("{number_1}G")
    key(V)
    insert("{number_2}G")

###
# Convenience
###
run as python:
    insert(":w\n")
    insert(":exec '!python' shellescape(@%, 1)\n")

remove trailing white space: insert(":%s/\s\+$//e\n")
remove all tabs: insert(":%s/\t/    /eg\n")

# XXX - Just for testing run_vim_cmd. To be deleted
spider man:
    user.run_vim_cmd("beep")

###
# Auto completion
###
complete: key(ctrl-n)
complete next: key(ctrl-n)
complete previous: key(ctrl-n)

###
# Visual Mode
###
(select|highlight) all: "ggVG"
reselect: "gv"

###
# Terminal mode
#
# NOTE: Only applicable to newer vim and neovim
###
(escape|pop) terminal:
    key(ctrl-\)
    key(ctrl-n)

split (term|terminal):
    # NOTE: if your using zsh you might have to switch this, though depending
    # on your setup it will still work (this loads zsh on mine)
    user.vim_normal_mode(":split term://bash\n")

vertical split (term|terminal):
    user.vim_normal_mode(":vsplit term://bash\n")

###
# Folding
###
fold (lines|line): "fZ"
fold line <number> through <number>$: ":{number_1},{number_2}fo\n"
(unfold|open fold|fold open): "zo"
(close fold|fold close): "zc"
open all folds: "zR"
close all folds: "zM"

###
# Plugins
###

# NOTE: These are here rather than nerdtree.talon to allow it to load the
# split buffer, which in turn loads nerdtree.talon when focused. Don't move
# these into nerdtree.talon for now
nerd tree: insert(":NERDTree\n")
nerd find [current] file: insert(":NERDTreeFind\n")
