import { BaseConfig } from "https://deno.land/x/ddu_vim@v4.0.0/types.ts";
import { ConfigArguments } from "https://deno.land/x/ddu_vim@v4.0.0/base/config.ts";
import { Denops, fn } from "https://deno.land/x/ddu_vim@v4.0.0/deps.ts";
import {
  Params as FfParams,
  Ui as FfUi,
} from "https://deno.land/x/ddu_ui_ff@v1.1.0/ff.ts";

export class Config extends BaseConfig {
  override config({
    contextBuilder,
    setAlias,
  }: ConfigArguments): Promise<void> {
    setAlias("source", "file_fd", "file_external");
    setAlias("source", "mru", "mr");
    setAlias("source", "mrw", "mr");
    setAlias("source", "mrr", "mr");

    const ffParamsDefault = new FfUi().params();
    const ffUiParams: FfParams = {
      ...ffParamsDefault,
      ignoreEmpty: true,
      startAutoAction: false,
      autoAction: {
        name: "preview",
        delay: 250, // same as telescope.nvim
      },
      autoResize: false,
      displaySourceName: "no",
      // floatingBorder: ["┏", "━", "┓", "┃", "┛", "━", "┗", "┃"],
      floatingBorder: "none",
      split: "floating",
      winCol: "&columns / 4",
      winWidth: "&columns / 2",
      winRow: "&lines / 3",
      // winCol: "&columns / 2",
      // winWidth: "&columns / 2 - 2",
      // winRow: "&lines / 3 * 2",
      // winHeight: "&lines / 3",
      filterFloatingPosition: "top",
      filterSplitDirection: "topleft",
      highlights: {
        filterText: "Statement",
        floating: "NormalFloat",
        floatingBorder: "none",
        selected: "CursorLine",
      },
      onPreview: async (args: { denops: Denops; previewWinId: number }) => {
        await fn.win_execute(args.denops, args.previewWinId, "normal! zt");
      },
      previewFloating: true,
      previewFloatingBorder: "none",
      previewSplit: "vertical",
      // previewCol: "&columns / 2",
      previewCol: "1",
      // previewRow: "&columns / 3 * 2",
      previewWidth: "&columns / 2 - 2",
      previewHeight: "&lines / 3",
      prompt: " ",
      statusline: false,
    };

    contextBuilder.patchGlobal({
      ui: "ff",
      profile: false,
      sources: ["file", "file_rec", "file_external", "mr", "ghq"],
      uiOptions: {},
      uiParams: {
        ff: ffUiParams,
      },
      sourceOptions: {
        _: {
          matchers: ["matcher_fzf"],
          sorters: ["sorter_fzf"],
          smartCase: true,
        },
        file: {
          matchers: ["matcher_substring", "matcher_hidden"],
          sorters: ["sorter_alpha"],
          converters: [
            "converter_hl_dir",
            // "converter_devicon"
          ],
          smartCase: true,
        },
        rg: {
          matchers: [
            "converter_display_word",
            "matcher_substring",
            "matcher_files",
          ],
          sorters: ["sorter_alpha"],
        },
        ghq: {
          defaultAction: "cd",
        },
      },
      sourceParams: {
        mru: {
          kind: "mru",
        },
        mrw: {
          kind: "mrw",
        },
        mrr: {
          kind: "mrr",
        },
        file: {
          new: false,
        },
        file_fd: {
          cmd: ["fd", ".", "-H", "-t", "f", "--exclude", ".git"],
        },
        rg: {
          args: ["--json"],
        },
      },
      filterOptions: {},
      filterParams: {
        matcher_substring: {
          highlightMatched: "Search",
        },
        matcher_fzf: {
          highlightMatched: "Search",
        },
        converter_hl_dir: {
          hlGroup: ["Directory", "Keyword"],
        },
      },
      kindOptions: {
        file: {
          defaultAction: "open",
        },
        // ui_select: {
        //   defaultAction: "select",
        // },
      },
      kindParams: {},
      actionOptions: {},
      actionParams: {},
    });
    return Promise.resolve();
  }
}
