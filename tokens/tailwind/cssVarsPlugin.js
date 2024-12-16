import plugin from 'tailwindcss/plugin.js';

export default plugin(function ({ addBase }) {
	addBase({
		':root': {
			'--reference-color-pink': '255 153 250',
			'--reference-color-blue': '130 216 255',
			'--reference-color-green': '107 255 206',
			'--system-color-primary': '255 153 250',
			'--system-color-secondary': '130 216 255',
			'--system-color-tertiary': '107 255 206',
			'--component-color-title-1': '130 216 255',
		},
	});
});
