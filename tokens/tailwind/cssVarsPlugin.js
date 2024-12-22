import plugin from 'tailwindcss/plugin.js';

export default plugin(function ({ addBase }) {
	addBase({
		':root': {
			'--global-color-reference-blue001': '0 159 255',
			'--global-color-reference-blue002': '0 132 201',
			'--global-color-reference-blue003': '50 152 161',
			'--global-color-reference-blue004': '0 159 255',
			'--global-color-reference-purple001': '203 7 127',
			'--global-color-reference-purple002': '178 123 207',
			'--global-color-reference-white001': '255 255 255',
			'--global-color-reference-yellow001': '253 201 7',
			'--global-color-reference-red001': '225 6 19',
			'--global-color-reference-red002': '255 0 0',
			'--global-color-reference-black001': '18 18 18',
			'--global-color-reference-black002': '34 34 34',
			'--global-color-reference-orange001': '255 143 0',
			'--global-color-reference-dark-grey001': '51 51 51',
			'--global-border-reference-radius001': '12',
			'--global-border-reference-size001': '5',
			'--global-border-reference-radius002': '2',
			'--global-typography-reference-font-size001': '16',
			'--global-typography-reference-font-size002': '24',
			'--global-typography-reference-font-size003': '42',
			'--global-typography-reference-font-size004': '64',
		},
	});
});
