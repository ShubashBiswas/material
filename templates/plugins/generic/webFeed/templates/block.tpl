{**
 * plugins/generic/webFeed/templates/block.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Feed plugin navigation sidebar.
 *}
<div class="pkp_block block_web_feed">
	<h2 class="text-base font-bold text-slate-900 dark:text-white mb-3">
		{translate key="plugins.generic.webfeed.displayName"}
	</h2>
	<div class="content flex flex-wrap gap-2 text-xs">
		<a href="{url page="gateway" op="plugin" path="WebFeedGatewayPlugin"|to_array:"atom"}" class="inline-flex items-center space-x-1.5 px-3 py-1.5 rounded-lg bg-orange-50 text-orange-700 dark:bg-orange-950/40 dark:text-orange-300 border border-orange-200 dark:border-orange-800/60 font-semibold hover:bg-orange-100 transition-colors">
			<span>Atom</span>
		</a>
		<a href="{url page="gateway" op="plugin" path="WebFeedGatewayPlugin"|to_array:"rss2"}" class="inline-flex items-center space-x-1.5 px-3 py-1.5 rounded-lg bg-amber-50 text-amber-700 dark:bg-amber-950/40 dark:text-amber-300 border border-amber-200 dark:border-amber-800/60 font-semibold hover:bg-amber-100 transition-colors">
			<span>RSS 2.0</span>
		</a>
		<a href="{url page="gateway" op="plugin" path="WebFeedGatewayPlugin"|to_array:"rss"}" class="inline-flex items-center space-x-1.5 px-3 py-1.5 rounded-lg bg-amber-50 text-amber-700 dark:bg-amber-950/40 dark:text-amber-300 border border-amber-200 dark:border-amber-800/60 font-semibold hover:bg-amber-100 transition-colors">
			<span>RSS 1.0</span>
		</a>
	</div>
</div>