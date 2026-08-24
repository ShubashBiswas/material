{**
 * templates/frontend/components/breadcrumbs_issue.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display a breadcrumb nav item showing current issue page.
 *}

<nav class="cmp_breadcrumbs" role="navigation" aria-label="{translate key="navigation.breadcrumbLabel"}">
	<ol class="not-prose flex items-center flex-wrap gap-1.5 text-xs font-medium text-slate-500 dark:text-slate-400 list-none p-0 m-0">
		<li class="flex items-center space-x-1.5">
			<a class="hover:text-{$activeTheme->getBaseColour()}-500 dark:hover:text-{$activeTheme->getBaseColour()}-400 transition-colors" href="{url page="index"}">
				{translate key="common.homepageNavigationLabel"}
			</a>
			<svg class="w-3.5 h-3.5 text-slate-400 dark:text-slate-600" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>
		</li>
		<li class="flex items-center space-x-1.5">
			<a class="hover:text-{$activeTheme->getBaseColour()}-500 dark:hover:text-{$activeTheme->getBaseColour()}-400 transition-colors" href="{url page="issue" op="archive"}">
				{translate key="navigation.archives"}
			</a>
			<svg class="w-3.5 h-3.5 text-slate-400 dark:text-slate-600" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>
		</li>
		<li class="current text-{$activeTheme->getBaseColour()}-600 dark:text-{$activeTheme->getBaseColour()}-400 font-semibold truncate" aria-current="page">
			<span>
				{if $currentTitleKey}
					{translate key=$currentTitleKey}
				{else}
					{$currentTitle|escape}
				{/if}
			</span>
		</li>
	</ol>
</nav>
