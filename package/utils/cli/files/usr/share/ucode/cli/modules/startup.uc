#!/usr/bin/env ucode

'use strict';

import { stat, popen } from 'fs';
import * as uci from 'uci';

const cursor = uci.cursor();
const module_path = '/usr/share/ucode/cli/modules';

function show_config(ctx, argv, named) {
	const handle = popen('/sbin/uci changes');
	let content = handle.read('all');
	return ctx.ok(sprintf('%s', content));
}

function save(ctx, argv, named) {
	system('/sbin/uci commit');
	return ctx.ok('Applied changes to configuration.');
}

function reload(ctx, argv, named) {
	system('/sbin/reload_config');
	return ctx.ok('Successfully reloaded configuration.');
}

function reboot(ctx, argv, named) {
	system('/sbin/reboot -f');
	return ctx.ok('Rebooting...');
}

function revert(ctx, argv, named) {
	system(sprintf('/sbin/uci revert %s', argv[0]));
	return ctx.ok('Reverted changes to configuration');
}

const Config = {
	changes: {
		help: 'Show the config you want to apply',
		call: show_config,
	},
	reload: {
		help: 'Reload configuration after modification',
		call: reload,
	},
	revert: {
		help: 'Revert modification',
		args: [
		{
			required: true,
			name: "config",
			type: "string",
		}
		],
		call: revert,
	},
	save: {
		help: 'Apply changes to configuration',
		call: save,
	}
};

const System = {
	reboot: {
		help: 'Reboot the system',
		call: reboot,
	},
};

const Root = {
	configure: {
		help: 'Configure system',
		select_node: 'Config',
	},

	system: {
		help: 'Show system settings',
		select_node: 'System',
	},
};

model.add_nodes({ Root, Config, System });
