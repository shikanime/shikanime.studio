import { fontFamily } from "tailwindcss/defaultTheme";
import daisyui from "daisyui";

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{astro,html,svelte,vue,js,ts,jsx,tsx}"],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter Variable", ...fontFamily.sans],
      },
    },
  },
  daisyui: {
    themes: [
      {
        newfuture: {
          primary: "#F5712C",
          "base-100": "#F6F6F6",
        },
      },
      "light",
    ],
  },
  plugins: [daisyui],
};
