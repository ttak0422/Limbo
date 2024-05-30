{ inputs, pkgs, ... }:
let
  inherit (builtins) readFile;
  inherit (pkgs) callPackage;
  plugins = callPackage ./plugins.nix { };
  groups = callPackage ./groups.nix { inherit inputs; };
  ftplugins = callPackage ./ftplugins.nix { };
in {
  test-v9 = {
    package = pkgs.neovim-v9;
    lazyGroups = with groups; [ treesitter ];
  };
  skkeleton = {
    package = pkgs.neovim-nightly;
    eagerPlugins = with pkgs.vimPlugins; [
      {
        plugin = denops-vim;
        extraPackages = [ pkgs.pkgs-unstable.deno ];
      }
      {
        plugin = skkeleton;
        startupConfig = ''
          call skkeleton#config({ 'globalDictionaries': [ '~/SKK-JISYO.L' ] })
          imap <C-j> <Plug>(skkeleton-toggle)
        '';
      }
    ];
  };
  skkeleton-lazy = {
    package = pkgs.neovim-nightly;
    lazyPlugins = with pkgs.vimPlugins; [{
      plugin = skkeleton;
      postConfig = ''
        call skkeleton#config({ 'globalDictionaries': [ '~/SKK-JISYO.L' ] })
        imap <C-j> <Plug>(skkeleton-toggle)
      '';
      dependPlugins = [{
        plugin = denops-vim;
        extraPackages = [ pkgs.pkgs-unstable.deno ];
      }];
      useDenops = true;
      onEvents = [ "InsertEnter" "CmdlineEnter" ];
    }];
  };
  skkeleton-with-ddc = {
    package = pkgs.neovim-nightly;
    eagerPlugins = with pkgs.vimPlugins; [
      {
        plugin = denops-vim;
        extraPackages = [ pkgs.pkgs-unstable.deno ];
      }
      {
        plugin = skkeleton;
        startupConfig = ''
          call skkeleton#config({ 'globalDictionaries': [ '~/SKK-JISYO.L' ] })
          imap <C-j> <Plug>(skkeleton-toggle)
        '';
      }
      {
        plugin = ddc-vim;
        startupConfig = {
          language = "vim";
          code = ''
            call ddc#custom#patch_global(#{
                    \   ui: 'pum',
                    \   autoCompleteEvents: [
                    \     'InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged',
                    \   ],
                    \ })
            call ddc#custom#patch_global('sources', ['skkeleton'])
            call ddc#custom#patch_global('sourceOptions', {
                    \   '_': {
                    \     'matchers': ['matcher_head'],
                    \     'sorters': ['sorter_rank']
                    \   },
                    \   'skkeleton': {
                    \     'mark': 'skkeleton',
                    \     'matchers': [],
                    \     'sorters': [],
                    \     'converters': [],
                    \     'isVolatile': v:true,
                    \     'minAutoCompleteLength': 1,
                    \   },
                    \ })
          '';
        };
      }
      # denops-signature_help
      ddc-matcher_head
      ddc-sorter_rank
      ddc-ui-pum
      {
        plugin = pum-vim;
        startupConfig = ''
          call pum#set_option(#{
                \ auto_select: v:true,
                \ auto_confirm_time: 0,
                \ direction: 'auto',
                \ padding: v:false,
                \ item_orders: ['abbr', 'space', 'kind', 'space', 'menu'],
                \ max_height: 20,
                \ use_setline: v:true,
                \ offset_cmdcol: 0,
                \ offset_cmdrow: 0,
                \ preview: v:true,
                \ preview_width: 120,
                \ })

          inoremap <expr> <TAB>
                \ pum#visible() ?
                \   '<Cmd>call pum#map#select_relative(+1)<CR>' :
                \ col('.') <= 1 ? '<TAB>' :
                \ getline('.')[col('.') - 2] =~# '\s' ? '<TAB>' :
                \ ddc#map#manual_complete()
          inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
          inoremap <expr> <C-n> pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' : '<C-n>'
          inoremap <expr> <C-p> pum#visible() ? '<Cmd>call pum#map#select_relative(-1)<CR>' : '<C-p>'
          inoremap <expr> <C-e> pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<End>'
          inoremap <C-y> <Cmd>call pum#map#confirm()<CR>
          inoremap <C-o> <Cmd>call pum#map#confirm_word()<CR>
        '';
      }
    ];
  };
}
