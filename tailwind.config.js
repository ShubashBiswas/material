const defaultTheme = require('tailwindcss/defaultTheme')

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./templates/**/*.{tpl,html,js}", "*.php"],
  safelist: [
    {
      pattern: /(bg|text|border|ring|hover:bg|hover:text|focus:border|focus:ring|active:bg)-(green|indigo|blue|sky|orange|emerald|purple|violet|teal|rose|amber|slate)-(100|200|300|400|500|600|700|800|900)/,
    },
  ],
  darkMode: 'class',
  theme: {
    fontSize: {
      xs: ['0.75rem', { lineHeight: '1rem' }],
      sm: ['0.875rem', { lineHeight: '1.5rem' }],
      base: ['1rem', { lineHeight: '2rem' }],
      lg: ['1.125rem', { lineHeight: '1.75rem' }],
      xl: ['1.25rem', { lineHeight: '2rem' }],
      '2xl': ['1.5rem', { lineHeight: '2.5rem' }],
      '3xl': ['2rem', { lineHeight: '2.5rem' }],
      '4xl': ['2.5rem', { lineHeight: '3rem' }],
      '5xl': ['3rem', { lineHeight: '3.5rem' }],
      '6xl': ['3.75rem', { lineHeight: '1' }],
      '7xl': ['4.5rem', { lineHeight: '1' }],
      '8xl': ['6rem', { lineHeight: '1' }],
      '9xl': ['8rem', { lineHeight: '1' }],
    },
    extend: {
      fontFamily: {
        'inter': ['Inter', ...defaultTheme.fontFamily.sans],
        'merriweather': ['Merriweather', ...defaultTheme.fontFamily.serif],
        'lora': ['Lora', ...defaultTheme.fontFamily.serif],
        'open-sans': ['Open Sans', ...defaultTheme.fontFamily.sans],
        'plus-jakarta-sans': ['Plus Jakarta Sans', ...defaultTheme.fontFamily.sans],
        'comic-sans': ['Comic Sans', ...defaultTheme.fontFamily.sans],
        'comic-neue': ['Comic Neue', ...defaultTheme.fontFamily.sans],
        'cardo': ['Cardo', ...defaultTheme.fontFamily.sans],
        'cormorant': ['Cormorant', ...defaultTheme.fontFamily.sans],
        'old-standard-tt': ['Old Standard TT', ...defaultTheme.fontFamily.sans],
        'roboto-serif': ['Roboto Serif', ...defaultTheme.fontFamily.sans],
      },
      maxWidth: {
        '8xl': '88rem',
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
    require('tailwind-scrollbar')
  ],
}

