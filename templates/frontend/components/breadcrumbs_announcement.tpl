{**
 * templates/frontend/components/breadcrumbs_announcement.tpl
 *
 * Copyright (c) 2026 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display a breadcrumb nav item for announcements.
 *
 * @uses $currentTitle string The title to use for the current page.
 * @uses $currentTitleKey string Translation key for title of current page.
 *}

<nav class="cmp_breadcrumbs cmp_breadcrumbs_announcement text-xs sm:text-sm font-medium my-2" role="navigation" aria-label="{translate key="navigation.breadcrumbLabel"}">
	<ol class="not-prose inline-flex flex-wrap items-center gap-1 px-3.5 py-1.5 rounded-full bg-slate-100/90 dark:bg-slate-800/60 border border-slate-200/80 dark:border-slate-800/80 text-slate-600 dark:text-slate-300 shadow-2xs backdrop-blur-md max-w-full">
		<li class="inline-flex items-center space-x-1">
			<a class="inline-flex items-center space-x-1.5 text-slate-600 dark:text-slate-400 hover:text-{$activeTheme->getBaseColour()}-600 dark:hover:text-{$activeTheme->getBaseColour()}-400 transition-colors font-medium" href="{url page="index"}">
				<svg class="w-3.5 h-3.5 shrink-0 text-slate-400 dark:text-slate-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 01-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path></svg>
				<span>{translate key="common.homepageNavigationLabel"}</span>
			</a>
			<svg class="w-3.5 h-3.5 text-slate-400 dark:text-slate-500 shrink-0 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>
		</li>
		<li class="inline-flex items-center space-x-1">
			<a class="text-slate-600 dark:text-slate-400 hover:text-{$activeTheme->getBaseColour()}-600 dark:hover:text-{$activeTheme->getBaseColour()}-400 transition-colors font-medium" href="{url page="announcement"}">
				{translate key="announcement.announcements"}
			</a>
			<svg class="w-3.5 h-3.5 text-slate-400 dark:text-slate-500 shrink-0 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>
		</li>
		<li class="inline-flex items-center min-w-0 max-w-xs sm:max-w-md" aria-current="page">
			<span class="truncate px-2.5 py-0.5 rounded-md bg-{$activeTheme->getBaseColour()}-500/10 text-{$activeTheme->getBaseColour()}-700 dark:text-{$activeTheme->getBaseColour()}-300 font-bold">{$currentTitle|escape}</span>
		</li>
	</ol>
</nav>
