{**
 * templates/frontend/pages/issue.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display landing page for a single issue.
 *
 * @uses $issue Issue The issue
 * @uses $issueIdentification string Label for this issue
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$issueIdentification}

<div class="page page_issue w-full space-y-6">

	{* Display a message if no current issue exists *}
	{if !$issue}
		{include file="frontend/components/breadcrumbs_issue.tpl" currentTitleKey="current.noCurrentIssue"}
		<div class="py-6">
			<h1 class="text-2xl sm:text-3xl font-extrabold text-slate-900 dark:text-white tracking-tight mb-4">
				{translate key="current.noCurrentIssue"}
			</h1>
			{include file="frontend/components/notification.tpl" type="warning" messageKey="current.noCurrentIssueDesc"}
		</div>

	{* Display an issue with the Table of Contents *}
	{else}
		{include file="frontend/components/breadcrumbs_issue.tpl" currentTitle=$issueIdentification}
		
		<div class="relative flex flex-col sm:flex-row sm:items-center justify-between gap-4 p-5 sm:p-6 rounded-2xl bg-slate-50 dark:bg-slate-800/40 border border-slate-200/80 dark:border-slate-800/80">
			<div class="flex items-center space-x-3.5">
				<div class="p-2.5 rounded-xl bg-{$activeTheme->getBaseColour()}-500/10 text-{$activeTheme->getBaseColour()}-600 dark:text-{$activeTheme->getBaseColour()}-400 ring-1 ring-{$activeTheme->getBaseColour()}-500/20">
					<svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z"></path></svg>
				</div>
				<div>
					<span class="text-xs font-bold uppercase tracking-wider text-{$activeTheme->getBaseColour()}-600 dark:text-{$activeTheme->getBaseColour()}-400">Issue</span>
					<h1 class="text-xl sm:text-2xl lg:text-3xl font-extrabold text-slate-900 dark:text-white tracking-tight leading-tight">
						{$issueIdentification|escape}
					</h1>
				</div>
			</div>
		</div>

		{include file="frontend/objects/issue_toc.tpl"}
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
