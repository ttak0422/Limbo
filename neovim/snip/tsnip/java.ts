import type { Snippet } from "./deps.ts";

const completedFuture: Snippet = {
  name: "completedFuture",
  params: [],
  render: (_, { postCursor }) =>
    `CompletableFuture.completedFuture(${postCursor})`,
};

const inheritDoc: Snippet = {
  name: "inheritDoc",
  params: [],
  render: (_, { postCursor }) => `/** {@inheritDoc} */${postCursor}`,
};

export default {
  completedFuture,
  inheritDoc,
};
