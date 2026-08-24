{**
 * templates/frontend/objects/issue_toc.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a full table of contents.
 *
 * @uses $issue Issue The issue
 * @uses $issueTitle string Title of the issue. May be empty
 * @uses $issueSeries string Vol/No/Year string for the issue
 * @uses $issueGalleys array Galleys for the entire issue
 * @uses $hasAccess bool Can this user access galleys for this context?
 * @uses $publishedSubmissions array Lists of articles published in this issue
 *   sorted by section.
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 * @uses $heading string HTML heading element, default: h2
 *}
{if !$heading}
	{assign var="heading" value="h2"}
{/if}
{assign var="articleHeading" value="h3"}
{if $heading == "h3"}
	{assign var="articleHeading" value="h4"}
{elseif $heading == "h4"}
	{assign var="articleHeading" value="h5"}
{elseif $heading == "h5"}
	{assign var="articleHeading" value="h6"}
{/if}

<div class="obj_issue_toc w-full space-y-8">

	{* Preview Notification *}
	{if !$issue->getPublished()}
		{include file="frontend/components/notification.tpl" type="warning" messageKey="editor.issues.preview"}
	{/if}

	{* Hero Issue Banner *}
	<div class="relative overflow-hidden rounded-3xl bg-gradient-to-br from-slate-50 via-white to-slate-100/70 dark:from-slate-900/90 dark:via-slate-900/60 dark:to-slate-800/40 p-6 sm:p-8 border border-slate-200/80 dark:border-slate-800 shadow-sm">
		<div class="flex flex-col md:flex-row gap-6 lg:gap-8 items-start">
			{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
			{if $issueCover}
				<div class="w-full md:w-56 flex-shrink-0">
					<img src="{$issueCover|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}" class="w-full max-h-72 object-contain rounded-2xl shadow-md border border-slate-200/80 dark:border-slate-700/80">
				</div>
			{/if}
			
			<div class="flex-1 space-y-3 min-w-0">
				{assign var=issueTitle value=$issue->getLocalizedTitle()|escape}
				{assign var=issueSeries value=$issue->getIssueSeries()}
				
				{if $issueSeries}
					<div class="text-xs font-bold uppercase tracking-wider text-{$activeTheme->getBaseColour()}-600 dark:text-{$activeTheme->getBaseColour()}-400">
						{$issueSeries|escape}
					</div>
				{/if}

				{if $issueTitle}
					<h2 class="text-2xl sm:text-3xl font-extrabold text-slate-900 dark:text-white tracking-tight leading-tight">
						{$issueTitle}
					</h2>
				{/if}

				{if $issue->getDatePublished()}
					<div class="inline-flex items-center space-x-2 px-3 py-1 rounded-full text-xs font-semibold bg-slate-100 text-slate-600 dark:bg-slate-800 dark:text-slate-300 border border-slate-200/60 dark:border-slate-700/60">
						<svg class="w-3.5 h-3.5 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
						<span>{translate key="submissions.published"}: {$issue->getDatePublished()|date_format:$dateFormatShort}</span>
					</div>
				{/if}

				{if $issue->hasDescription()}
					<div class="prose prose-sm dark:prose-invert text-slate-600 dark:text-slate-300 leading-relaxed max-w-none pt-2">
						{$issue->getLocalizedDescription()|strip_unsafe_html}
					</div>
				{/if}

				{* Full-issue Galleys *}
				{if $issueGalleys}
					<div class="pt-3">
						<h3 class="text-xs font-semibold uppercase tracking-wider text-slate-400 dark:text-slate-500 mb-2">{translate key="issue.fullIssue"}</h3>
						<div class="flex flex-wrap items-center gap-2">
							{foreach from=$issueGalleys item=galley}
								{include file="frontend/objects/galley_link.tpl" parent=$issue labelledBy="issueTocGalleyLabel" purchaseFee=$currentJournal->getData('purchaseIssueFee') purchaseCurrency=$currentJournal->getData('currency')}
							{/foreach}
						</div>
					</div>
				{/if}
			</div>
		</div>
	</div>

	{* Articles sorted by section *}
	<div class="w-full space-y-10">
		{foreach name=sections from=$publishedSubmissions item=section}
			{if $section.articles}
				<div class="space-y-4">
					{if $section.title}
						<div class="flex items-center justify-between p-3.5 px-4 rounded-xl bg-slate-100/80 dark:bg-slate-800/50 border-l-4 border-{$activeTheme->getBaseColour()}-500 border-r border-t border-b border-slate-200/60 dark:border-slate-800">
							<div class="flex items-center space-x-2.5">
								<svg class="w-5 h-5 text-{$activeTheme->getBaseColour()}-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"></path></svg>
								<h2 class="text-lg font-bold text-slate-900 dark:text-white tracking-tight">{$section.title|escape}</h2>
							</div>
							{if $section.articles}
								<span class="px-2.5 py-0.5 rounded-full text-xs font-semibold bg-slate-200/70 dark:bg-slate-700/60 text-slate-700 dark:text-slate-300">
									{count($section.articles)} {if count($section.articles) == 1}article{else}articles{/if}
								</span>
							{/if}
						</div>
					{/if}

					<div class="space-y-3">
						{foreach from=$section.articles item=article}
							{include file="frontend/objects/article_summary.tpl" heading=$articleHeading section=$section}
						{/foreach}
					</div>
				</div>
			{/if}
		{/foreach}
	</div>
</div>
