{**
 * plugins/blocks/makeSubmission/templates/block.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- "Make a Submission" block.
 *}
<div class="pkp_block block_make_submission relative overflow-hidden rounded-2xl bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 p-5 text-white shadow-md border border-slate-800 mb-6">
	<div class="absolute -right-8 -top-8 h-28 w-28 rounded-full bg-{$activeTheme->getBaseColour()}-500/20 blur-xl pointer-events-none"></div>
	<div class="relative z-10 space-y-3">
		<div class="flex items-center space-x-2 text-{$activeTheme->getBaseColour()}-400">
			<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path></svg>
			<span class="text-xs font-bold uppercase tracking-wider">{translate key="article.submission"}</span>
		</div>
		<p class="text-xs text-slate-300 leading-relaxed">
			Submit your research manuscript for peer review and publication.
		</p>
		<a href="{url page="about" op="submissions"}" class="inline-flex items-center justify-center w-full space-x-2 px-4 py-2.5 rounded-xl bg-{$activeTheme->getBaseColour()}-600 hover:bg-{$activeTheme->getBaseColour()}-700 text-white font-extrabold text-xs shadow-md hover:shadow-lg transition-all">
			<span>{translate key="plugins.block.makeSubmission.linkLabel"}</span>
			<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M14 5l7 7-7 7M3 12h18"></path></svg>
		</a>

	</div>
</div>
