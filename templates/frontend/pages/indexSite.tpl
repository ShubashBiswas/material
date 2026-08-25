{**
 * templates/frontend/pages/indexSite.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Site index for multi-journal platform.
 *}
{include file="frontend/components/header.tpl"}

<div class="page_index_site w-full space-y-10">

	{* Portal Hero About Section *}
	{if $about}
		<div class="relative overflow-hidden rounded-3xl bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 p-6 sm:p-10 text-white shadow-xl border border-slate-800">
			<!-- Background Glow -->
			<div class="absolute -right-16 -top-16 h-64 w-64 rounded-full bg-{$activeTheme->getBaseColour()}-500/10 blur-3xl pointer-events-none"></div>
			
			<div class="relative z-10 space-y-4 max-w-4xl">
				<div class="inline-flex items-center space-x-2 px-3 py-1 rounded-full text-xs font-bold uppercase tracking-widest bg-{$activeTheme->getBaseColour()}-500/20 text-{$activeTheme->getBaseColour()}-400 ring-1 ring-{$activeTheme->getBaseColour()}-500/30">
					<span>Academic Publishing Portal</span>
				</div>
				<div class="prose prose-invert max-w-none text-slate-200 leading-relaxed text-base sm:text-lg">
					{$about}
				</div>
			</div>
		</div>
	{/if}

	{include file="frontend/objects/announcements_list.tpl" numAnnouncements=$numAnnouncementsHomepage}

	{* Journals Listing Grid (2x2) *}
	<div class="journals w-full space-y-6">
		<div class="flex items-center justify-between pb-3 border-b border-slate-200/70 dark:border-slate-800">
			<div class="flex items-center space-x-3">
				<div class="h-7 w-1.5 rounded-full bg-{$activeTheme->getBaseColour()}-500"></div>
				<h2 class="text-2xl sm:text-3xl font-extrabold text-slate-900 dark:text-white tracking-tight">
					{translate key="context.contexts"}
				</h2>
			</div>
			{if $journals}
				<span class="px-3 py-1 rounded-full text-xs font-bold bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-300 border border-slate-200 dark:border-slate-700">
					{$journals|@count} {if $journals|@count == 1}Journal{else}Journals{/if}
				</span>
			{/if}
		</div>

		{if !$journals|@count}
			<div class="p-10 rounded-2xl bg-slate-50 dark:bg-slate-800/40 text-center text-slate-500 dark:text-slate-400 border border-slate-200/60 dark:border-slate-800">
				{translate key="site.noJournals"}
			</div>
		{else}
			<div class="grid grid-cols-1 md:grid-cols-2 gap-6 lg:gap-8">
				{foreach from=$journals item=journal}
					{capture assign="url"}{url journal=$journal->getPath()}{/capture}
					{assign var="thumb" value=$journal->getLocalizedData('journalThumbnail')}
					{assign var="description" value=$journal->getLocalizedDescription()}
					
					<div class="group relative flex flex-col justify-between p-6 sm:p-7 rounded-3xl bg-white dark:bg-slate-900/60 border border-slate-200/80 dark:border-slate-800 hover:border-slate-300 dark:hover:border-slate-700 shadow-sm hover:shadow-lg transition-all duration-300 h-full">
						<div>
							{if $thumb}
								<div class="w-full h-44 rounded-2xl bg-slate-100 dark:bg-slate-800/80 overflow-hidden border border-slate-200/60 dark:border-slate-700/60 flex items-center justify-center p-3 mb-4">
									<a href="{$url}" class="block h-full w-full">
										<img src="{$journalFilesPath}{$journal->getId()}/{$thumb.uploadName|escape:"url"}"{if $thumb.altText} alt="{$thumb.altText|escape|default:''}"{/if} class="h-full w-full object-contain transition-transform duration-300 group-hover:scale-105">
									</a>
								</div>
							{/if}

							<div class="space-y-2">
								<h3 class="text-lg sm:text-xl font-bold text-slate-900 dark:text-white group-hover:text-{$activeTheme->getBaseColour()}-600 dark:group-hover:text-{$activeTheme->getBaseColour()}-400 transition-colors leading-snug">
									<a href="{$url}" rel="bookmark">
										{$journal->getLocalizedName()|escape}
									</a>
								</h3>

								{if $description}
									<div class="prose prose-sm dark:prose-invert line-clamp-3 text-slate-600 dark:text-slate-300 text-xs sm:text-sm leading-relaxed">
										{$description}
									</div>
								{/if}
							</div>
						</div>

						<div class="mt-6 pt-4 border-t border-slate-100 dark:border-slate-800/80 flex flex-wrap items-center justify-between gap-2.5">
							<a href="{$url}" class="inline-flex items-center space-x-2 px-4 py-2 rounded-xl bg-{$activeTheme->getBaseColour()}-500 hover:bg-{$activeTheme->getBaseColour()}-600 text-white font-semibold text-xs shadow-sm hover:shadow transition-all">
								<span>{translate key="site.journalView"}</span>
								<svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7-7 7M3 12h18"></path></svg>
							</a>
							<a href="{url journal=$journal->getPath() page="issue" op="current"}" class="inline-flex items-center space-x-2 px-4 py-2 rounded-xl bg-slate-100 dark:bg-slate-800 hover:bg-slate-200 dark:hover:bg-slate-700 text-slate-700 dark:text-slate-200 font-semibold text-xs border border-slate-200 dark:border-slate-700 transition-all">
								<svg class="w-3.5 h-3.5 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z"></path></svg>
								<span>{translate key="site.journalCurrent"}</span>
							</a>
						</div>
					</div>
				{/foreach}
			</div>
		{/if}
	</div>

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
