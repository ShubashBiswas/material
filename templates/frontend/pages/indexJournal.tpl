{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the index page for a journal
 *
 * @uses $currentJournal Journal This journal
 * @uses $journalDescription string Journal description from HTML text editor
 * @uses $homepageImage object Image to be displayed on the homepage
 * @uses $additionalHomeContent string Arbitrary input from HTML text editor
 * @uses $announcements array List of announcements
 * @uses $numAnnouncementsHomepage int Number of announcements to display on the
 *       homepage
 * @uses $issue Issue Current issue
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<div class="page_index_journal w-full space-y-10">

	{call_hook name="Templates::Index::journal"}

	{if !$activeTheme->getOption('useHomepageImageAsHeader') && $homepageImage}
		<div class="homepage_image overflow-hidden rounded-3xl shadow-sm border border-slate-200/80 dark:border-slate-800">
			<img class="w-full h-auto object-cover" src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}"{if $homepageImage.altText} alt="{$homepageImage.altText|escape}"{/if}>
		</div>
	{/if}

	{* Journal Description *}
	{if $activeTheme->getOption('showDescriptionInJournalIndex') && $currentContext->getLocalizedData('description')}
		<section class="homepage_about rounded-3xl bg-slate-50 dark:bg-slate-800/40 p-6 sm:p-8 border border-slate-200/80 dark:border-slate-800/80">
			<a id="homepageAbout"></a>
			<h2 class="text-xl font-bold text-slate-900 dark:text-white tracking-tight mb-3">
				{translate key="about.aboutContext"}
			</h2>
			<div class="prose prose-slate dark:prose-invert max-w-none text-slate-600 dark:text-slate-300 leading-relaxed text-sm sm:text-base">
				{$currentContext->getLocalizedData('description')}
			</div>
		</section>
	{/if}

	{include file="frontend/objects/announcements_list.tpl" numAnnouncements=$numAnnouncementsHomepage}

	{* Latest issue *}
	{if $issue}
		<section class="current_issue w-full space-y-6">
			<a id="homepageIssue"></a>
			<div class="relative overflow-hidden rounded-2xl bg-gradient-to-r from-slate-900 via-slate-800 to-slate-900 p-5 sm:p-6 text-white shadow-lg mb-6 border border-slate-800/80">
				<!-- Background Glow -->
				<div class="absolute -right-10 -top-10 h-40 w-40 rounded-full bg-{$activeTheme->getBaseColour()}-500/10 blur-2xl pointer-events-none"></div>
				
				<div class="relative flex flex-col sm:flex-row sm:items-center justify-between gap-4">
					<div class="flex items-center space-x-4">
						<div class="flex h-12 w-12 flex-shrink-0 items-center justify-center rounded-xl bg-{$activeTheme->getBaseColour()}-500/20 text-{$activeTheme->getBaseColour()}-400 ring-1 ring-{$activeTheme->getBaseColour()}-500/30">
							<svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z"></path></svg>
						</div>
						<div class="flex flex-col justify-center min-w-0">
							<span class="text-xs font-bold uppercase tracking-widest text-{$activeTheme->getBaseColour()}-400 leading-none mb-1 block">Featured Publication</span>
							<h2 class="text-xl sm:text-2xl font-extrabold text-white tracking-tight leading-tight m-0 p-0" style="margin: 0 !important;">
								{translate key="journal.currentIssue"}
							</h2>
						</div>
					</div>

					<a href="{url page="issue" op="archive"}" class="inline-flex items-center justify-center space-x-2 px-4 py-2.5 rounded-xl bg-white/10 hover:bg-white/20 text-white text-xs font-bold uppercase tracking-wider backdrop-blur-md transition-all border border-white/10 shadow-sm hover:shadow flex-shrink-0">
						<span>{translate key="journal.viewAllIssues"}</span>
						<svg class="w-4 h-4 text-{$activeTheme->getBaseColour()}-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7-7 7M3 12h18"></path></svg>
					</a>
				</div>
			</div>



			{include file="frontend/objects/issue_toc.tpl" heading="h3"}
		</section>
	{/if}

	{* Additional Homepage Content *}
	{if $additionalHomeContent}
		<div class="additional_content prose prose-slate dark:prose-invert max-w-none">
			{$additionalHomeContent}
		</div>
	{/if}
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
