{pkgs, ...}: {
	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;

		configure = {
			packages.myVimPackage = with pkgs.vimPlugins; {
				start  = [
					csv-vim
					vim-surround
					vim-commentary
					vim-unimpaired
					vim-sleuth
					vim-startify
					vim-easy-align
					vim-table-mode
					vim-markdown
					vim-nix
					nvim-colorizer-lua
					nvim-lspconfig
					gitsigns-nvim
					diffview-nvim
					nvim-autopairs
					vim-closetag
					nvim-tree-lua
					vim-numbertoggle
					vimwiki
					vim-colorschemes
					dracula-vim
				];
			};

			#customRC =''
			#	set list
			#	set tabstop=2
			#	set softtabstop=2
			#	set shiftwidth=2
			#	syntax on
			#'';
			
			#customRC = "lua << EOF\n" + builtins.readFile ./init.lua + "\nEOF";
			customRC = ''
				luafile ${./init.lua}
			'';
			
		};

	};


}
