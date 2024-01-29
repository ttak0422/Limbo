import type { Param } from "./deps.ts";

export type SnipType = "single_line" | "multi_line";

/**
 * mapping to tsnip param.
 *
 * @param name param name
 * @param type single_line | multi_line
 * @returns tsnip param
 */
export function mapToParam(
  name: string,
  type: SnipType = "single_line",
): Param {
  return {
    name,
    type,
  };
}

/**
 * mapping to tsnip params.
 *
 * @param names param names
 * @returns tsnip param
 */
export function mapToSingleLineParams(names: string[]): Param[] {
  return names.map((name) => mapToParam(name, "single_line"));
}
