os: linux
tag: vim
-

(fugitive|git) status: user.vim_normal_mode(":Gstatus\n")
(fugitive|git) diff: user.vim_normal_mode(":Gdiff\n")
(fugitive|git) (delete|remove): user.vim_normal_mode(":Gdelete")
(fugitive|git) split diff: user.vim_normal_mode(":Gsplitdiff!")
(fugitive|git) write: user.vim_normal_mode(":Gwrite")
(fugitive|git) force write: user.vim_normal_mode(":Gwrite!")
(fugitive|git) blame: user.vim_normal_mode(":Gblame\n")
(fugitive|git) commit: user.vim_normal_mode(":G commit\n")
(fugitive|git) add (current|this) file: user.vim_normal_mode(":G add %\n")
(fugitive|git) add everything: user.vim_normal_mode(":G add -u\n")
(fugitive|git) reset (current|reset) file: user.vim_normal_mode(":G reset HEAD %\n")
(fugitive|git) rename: user.vim_normal_mode(":GRename ")
(fugitive|git) move: user.vim_normal_mode(":Gmove ")
