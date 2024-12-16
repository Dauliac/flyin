import type { Config } from "tailwindcss";
import tailwindPreset from "./tokens/tailwind/preset.js";

export default {
  content: ["./src/**/*.{html,js,svelte,ts}"],

  theme: {
    extend: {},
  },
  presets: [tailwindPreset],

  plugins: [],
} satisfies Config;
