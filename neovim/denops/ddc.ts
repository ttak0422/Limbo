import { BaseConfig } from "https://deno.land/x/ddc_vim@v4.2.0/types.ts";
import { ConfigArguments } from "https://deno.land/x/ddc_vim@v4.2.0/base/config.ts";

export class Config extends BaseConfig {
  override config(
    { contextBuilder, denops }: ConfigArguments,
  ): Promise<void> {
    contextBuilder.patchFiletype("vim", {
      sources: ["necovim", "around"],
    });
    contextBuilder.patchGlobal({
      ui: "pum",
      keywordPattern: "[0-9a-zA-Z]\\k*",
      // VSCode
      autoCompleteDelay: 10,
      autoCompleteEvents: [
        "InsertEnter",
        "TextChangedI",
        "TextChangedP",
        "CmdlineChanged",
      ],
      backspaceCompletion: false,
      sources: [
        "lsp",
        "tsnip",
        "vsnip",
        "around",
      ],
      sourceOptions: {
        _: {
          isVolatile: true,
          ignoreCase: true,
          matchers: [
            // "matcher_head",
            "matcher_fuzzy",
          ],
          sorters: [
            // "sorter_reverse",
            "sorter_rank",
            "sorter_fuzzy",
          ],
          converters: [
            "converter_remove_overlap",
            "converter_truncate",
            "converter_fuzzy",
          ],
          dup: "ignore",
          minKeywordLength: 2,
        },
        around: {
          mark: "[AROUND]",
        },
        tsnip: {
          mark: "[TSNIP]",
          sorters: ["sorter_rank"],
        },
        vsnip: {
          mark: "[VSNIP]",
        },
        line: {
          mark: "[LINE]",
          maxItems: 50,
        },
        file: {
          mark: "[FILE]",
          forceCompletionPattern: "\\S/\\S*",
          isVolatile: true,
        },
        buffer: {
          mark: "[BUFFER]",
        },
        skkeleton: {
          mark: "[SKK]",
          matchers: ["skkeleton"],
          isVolatile: true,
          sorters: [],
        },
        lsp: {
          mark: "[LSP]",
          keywordPattern: "\\k+",
          dup: "keep",
          forceCompletionPattern: "\\.\\w*|::\\w*|->\\w*",
          maxItems: 800,
          minKeywordLength: 0,
          sorters: [
            // "sorter_itemsize",
            "sorter_lsp-detail-size",
            "sorter_lsp-kind",
            "sorter_fuzzy",
            // "sorter_rank",
          ],
        },
        tmux: {
          mark: "[TMUX]",
        },
        necovim: {
          mark: "[VIM]",
        },
        cmdline: {
          mark: "[CMD]",
        },
        "cmdline-history": {
          mark: "[HIST]",
        },
      },
      sourceParams: {
        lsp: {
          snippetEngine: async (body: string) => {
            await denops.call("vsnip#anonymous", body);
            return Promise.resolve();
          },
          enableResolveItem: true,
          enableAdditionalTextEdit: true,
        },
        buffer: {
          requireSameFiletype: true,
          limitBytes: 500000,
          fromAltBuf: true,
          forceCollect: true,
        },
        tmux: {
          currentWinOnly: true,
          excludeCurrentPane: true,
          kindFormat: "#{pane_current_command}",
        },
        file: {
          projAsRoot: false,
          cwdMaxItems: 0,
          projFromCwdMaxItems: [0],
          projFromBufMaxItems: [0],
          displayFile: "",
          displayDir: "",
          displaySym: "",
          displaySymFile: "",
          displaySymDir: "",
        },
        "node-modules": {
          cwdMaxItems: 0,
          bufMaxItems: 0,
          followSymlinks: true,
          projMarkers: ["node_modules"],
          projFromCwdMaxItems: [],
          projFromBufMaxItems: [1000, 1000, 1000],
          beforeResolve: "node_modules",
          displayBuf: "",
        },
      },
      filterOptions: {},
      filterParams: {
        converter_truncate: {
          maxAbbrWidth: 60,
          maxKindWidth: 10,
          maxMenuWidth: 40,
        },
        "sorter_itemsize": {
          sameWordOnly: true,
        },
        "sorter_lsp-detail-size": {
          sameWordOnly: true,
        },
        "sorter_lsp-kind": {
          priority: [
            ["Method", "Function"],
            ["Constant", "Variable"],
            "Constructor",
            "Field",
            "Interface",
            ["Class", "Module"],
            "Property",
            "Unit",
            "Value",
            "Enum",
            "Color",
            "File",
            "Reference",
            "Folder",
            "EnumMember",
            "Struct",
            "Event",
            "Operator",
            "TypeParameter",
            "Text",
            "Snippet",
            "Keyword",
          ],
        },
      },
      cmdlineSources: {
        ":": ["file", "necovim", "cmdline", "cmdline-history", "around"],
        "@": [],
        ">": [],
        "/": ["around", "line"],
        "?": ["around", "line"],
        "-": [],
        "=": ["input"],
      },
    });

    // for java
    contextBuilder.patchFiletype("java", {
      sourceOptions: {
        "nvim-lsp": {
          sorters: [
            "sorter_lsp-detail-size",
            "sorter_lsp-kind",
            "sorter_fuzzy",
          ],
        },
      },
    });
    return Promise.resolve();
  }
}

