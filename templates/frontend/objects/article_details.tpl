{**
 * templates/frontend/objects/article_details.tpl
 *
 * Copyright (c) 2014-2026 Simon Fraser University
 * Copyright (c) 2003-2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Premium Material Theme Article Landing Page Layout.
 *
 * @uses $article Submission This article
 * @uses $publication Publication The publication being displayed
 * @uses $firstPublication Publication The first published version of this article
 * @uses $currentPublication Publication The most recently published version of this article
 * @uses $issue Issue The issue this article is assigned to
 * @uses $section Section The journal section this article is assigned to
 * @uses $categories Category The category this article is assigned to
 * @uses $primaryGalleys array List of article galleys that are not supplementary or dependent
 * @uses $supplementaryGalleys array List of article galleys that are supplementary
 * @uses $keywords array List of keywords assigned to this article
 * @uses $pubIdPlugins Array of pubId plugins which this article may be assigned
 * @uses $licenseTerms string License terms.
 * @uses $licenseUrl string URL to license. Only assigned if license should be included with published submissions.
 * @uses $ccLicenseBadge string An image and text with details about the license
 *}
{if !$heading}
	{assign var="heading" value="h3"}
{/if}

<article class="obj_article_details w-full space-y-8">

	{* System Notifications *}
	{if $publication->getData('status') !== $smarty.const.STATUS_PUBLISHED}
		<div class="cmp_notification notice p-4 rounded-2xl bg-amber-500/10 border border-amber-500/30 text-amber-900 dark:text-amber-200 text-sm font-medium flex items-center space-x-3">
			<svg class="w-5 h-5 text-amber-500 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
			<div>
				{capture assign="submissionUrl"}{url page="workflow" op="access" path=$article->getId()}{/capture}
				{translate key="submission.viewingPreview" url=$submissionUrl}
			</div>
		</div>
	{elseif $currentPublication->getId() !== $publication->getId()}
		<div class="cmp_notification notice p-4 rounded-2xl bg-sky-500/10 border border-sky-500/30 text-sky-900 dark:text-sky-200 text-sm font-medium flex items-center space-x-3">
			<svg class="w-5 h-5 text-sky-500 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
			<div>
				{capture assign="latestVersionUrl"}{url page="article" op="view" path=$article->getBestId()}{/capture}
				{translate key="submission.outdatedVersion"
					datePublished=$publication->getData('datePublished')|date_format:$dateFormatShort
					urlRecentVersion=$latestVersionUrl|escape
				}
			</div>
		</div>
	{/if}

	{* Full-Width Hero Header Card *}
	<header class="relative overflow-hidden rounded-3xl bg-gradient-to-br from-slate-900 via-slate-800 to-indigo-950 p-6 sm:p-10 text-white shadow-2xl ring-1 ring-white/10">
		{* Background Decorative Mesh Glows *}
		<div class="absolute -right-20 -top-20 h-80 w-80 rounded-full bg-sky-500/20 blur-3xl pointer-events-none"></div>
		<div class="absolute -left-20 -bottom-20 h-80 w-80 rounded-full bg-indigo-500/20 blur-3xl pointer-events-none"></div>

		<div class="relative z-10 space-y-6">
			{* Meta Chips Line (Issue, Section, Date) *}
			<div class="flex flex-wrap items-center gap-2 text-xs font-semibold">
				{if $issue}
					<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}" class="inline-flex items-center space-x-1.5 px-3.5 py-1.5 rounded-full bg-white/10 hover:bg-white/20 text-white backdrop-blur-md transition-colors">
						<svg class="w-3.5 h-3.5 text-sky-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z"></path></svg>
						<span>{$issue->getIssueIdentification()|escape}</span>
					</a>
				{/if}

				{if $section}
					<span class="inline-flex items-center px-3.5 py-1.5 rounded-full bg-sky-500/20 text-sky-300 border border-sky-500/30">
						{$section->getLocalizedTitle()|escape}
					</span>
				{/if}

				{if $publication->getData('datePublished')}
					<span class="inline-flex items-center space-x-1.5 px-3.5 py-1.5 rounded-full bg-white/5 text-slate-300 border border-white/10">
						<svg class="w-3.5 h-3.5 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
						<span>{$publication->getData('datePublished')|date_format:$dateFormatShort}</span>
					</span>
				{/if}
			</div>

			{* Title & Subtitle *}
			<div class="space-y-3">
				<h1 class="page_title text-2xl sm:text-4xl lg:text-5xl font-black tracking-tight text-white leading-snug break-words">
					{$publication->getLocalizedTitle(null, 'html')|strip_unsafe_html}
				</h1>

				{if $publication->getLocalizedData('subtitle')}
					<h2 class="subtitle text-base sm:text-xl font-medium text-slate-300 leading-normal break-words">
						{$publication->getLocalizedSubTitle(null, 'html')|strip_unsafe_html}
					</h2>
				{/if}
			</div>

			{* Action Bar (Stats & DOI) *}
			<div class="pt-4 border-t border-white/10 flex flex-wrap items-center justify-between gap-4 text-xs sm:text-sm">
				<div class="flex flex-wrap items-center gap-3">
					{if $activeTheme && $activeTheme->getOption('showReadingTime')}
						<div class="inline-flex items-center space-x-1.5 px-3 py-1.5 rounded-xl bg-white/10 text-slate-200 border border-white/10">
							<svg class="w-4 h-4 text-sky-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
							<span>{translate key="plugins.themes.material.readingTime.label"}: {material_reading_time text=$publication->getLocalizedData('abstract')}</span>
						</div>
					{/if}

					{viewcounterStats submission=$article fontSize="14px"}
				</div>

				{* DOI Badge *}
				{assign var=doiObject value=$article->getCurrentPublication()->getData('doiObject')}
				{assign var="doiUrl" value=""}
				{if !$doiObject && $publication->getDoi()}
					{assign var="doiUrl" value=$publication->getDoi()|escape}
				{elseif $doiObject}
					{if $doiObject|method_exists:'getResolvingUrl'}
						{assign var="doiUrl" value=$doiObject->getResolvingUrl()|escape}
					{elseif $doiObject|method_exists:'getData'}
						{assign var="doiUrl" value=$doiObject->getData('resolvingUrl')|escape}
					{else}
						{assign var="doiUrl" value=$doiObject|escape}
					{/if}
				{/if}
				{if $doiUrl}
					<div class="inline-flex items-center space-x-2 px-3 py-1.5 rounded-xl bg-white/10 text-sky-300 border border-white/10 max-w-full truncate" x-data="{ doiCopied: false }">
						<span class="font-bold text-white shrink-0">DOI:</span>
						<a href="{$doiUrl}" target="_blank" class="hover:underline truncate text-sky-300 font-mono text-xs">
							{$doiUrl}
						</a>
						<button @click="navigator.clipboard.writeText('{$doiUrl}'); doiCopied = true; setTimeout(() => doiCopied = false, 2000)" class="p-1 hover:bg-white/20 rounded transition-colors shrink-0" title="Copy DOI">
							<svg class="w-3.5 h-3.5 text-slate-300" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path></svg>
						</button>
					</div>
				{/if}
			</div>
		</div>
	</header>

	<style>
		@media (min-width: 1024px) {
			.article-grid-layout {
				display: grid !important;
				grid-template-columns: repeat(12, minmax(0, 1fr)) !important;
				gap: 2.5rem !important;
			}
			.article-main-col {
				grid-column: span 8 / span 8 !important;
			}
			.article-sidebar-col {
				grid-column: span 4 / span 4 !important;
			}
		}
		@media (max-width: 1023px) {
			.article-grid-layout {
				display: flex !important;
				flex-direction: column !important;
				gap: 2rem !important;
			}
			.article-main-col, .article-sidebar-col {
				width: 100% !important;
			}
		}
	</style>

	{* 2-Column Layout Grid (8 cols Main + 4 cols Sidebar) *}
	<div class="row article-grid-layout">

		{* Left Main Entry Column (8 of 12 cols = 66.6% width) *}
		<div class="main_entry article-main-col space-y-8 sm:space-y-10">

			{* Authors Cards Grid *}
			{if $publication->getData('authors')}
				<section class="item authors space-y-4">
					<h2 class="pkp_screen_reader text-xs font-bold uppercase tracking-wider text-slate-500 dark:text-slate-400">
						{translate key="article.authors"}
					</h2>
					<div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
						{foreach from=$publication->getData('authors') item=author}
							<div class="p-4 sm:p-5 rounded-2xl bg-white dark:bg-slate-900/60 border border-slate-200/80 dark:border-slate-800/80 shadow-sm hover:shadow-md transition-all flex items-start space-x-3.5 min-w-0 overflow-hidden">
								<div class="min-w-0 flex-1 space-y-1">
									<div class="flex items-center justify-between gap-2">
										<h3 class="text-base font-bold text-slate-900 dark:text-slate-100 truncate min-w-0">
											{$author->getFullName()|escape}
										</h3>
										{assign var=authorUserGroup value=$userGroupsById[$author->getData('userGroupId')]}
										{if $authorUserGroup && $authorUserGroup->showTitle}
											<span class="userGroup shrink-0 inline-flex items-center px-2 py-0.5 rounded-md text-[10px] font-bold uppercase tracking-wider bg-green-50 text-green-700 dark:bg-green-500/10 dark:text-green-400 ring-1 ring-green-600/20">
												{$authorUserGroup->getLocalizedData('name')|escape}
											</span>
										{/if}
									</div>

									{if count($author->getAffiliations()) > 0}
										<p class="text-xs text-slate-600 dark:text-slate-400 leading-snug">
											<span class="affiliation inline-flex flex-wrap gap-1 items-center">
												{foreach name="affiliations" from=$author->getAffiliations() item="affiliation"}
													<span>{$affiliation->getLocalizedName()|escape}</span>
													{if $affiliation->getRor()}
														<a href="{$affiliation->getRor()|escape}" target="_blank" class="text-sky-600 hover:text-sky-700 inline-flex items-center shrink-0" title="ROR Identifier">
															{include file="frontend/components/ui/material_icon_ror.tpl"}
														</a>
													{/if}
													{if !$smarty.foreach.affiliations.last}{translate key="common.commaListSeparator"}{/if}
												{/foreach}
											</span>
										</p>
									{/if}

									{if $author->getData('orcid')}
										<div class="pt-1 min-w-0 max-w-full">
											<a href="{$author->getData('orcid')|escape}" target="_blank" class="inline-flex items-center space-x-1.5 text-xs text-emerald-600 dark:text-emerald-400 font-medium hover:underline min-w-0 max-w-full">
												{include file="frontend/components/ui/material_icon_orcid.tpl"}
												<span class="truncate min-w-0 flex-1">{$author->getOrcidDisplayValue()|escape}</span>
											</a>
										</div>
									{/if}
								</div>
							</div>
						{/foreach}
					</div>
				</section>
			{/if}

			{* Subject Keywords *}
			{if !empty($publication->getLocalizedData('keywords'))}
				<section class="item keywords p-5 rounded-2xl bg-white dark:bg-slate-900/60 border border-slate-200/80 dark:border-slate-800/80 shadow-sm space-y-2">
					<h2 class="label text-xs font-bold uppercase tracking-wider text-slate-500 dark:text-slate-400">
						{capture assign=translatedKeywords}{translate key="article.subject"}{/capture}
						{translate key="semicolon" label=$translatedKeywords}
					</h2>
					<div class="value flex flex-wrap gap-2 pt-1">
						{foreach name="keywords" from=$publication->getLocalizedData('keywords') item="keyword"}
							<span class="inline-flex items-center rounded-xl bg-slate-100 dark:bg-slate-800 px-3 py-1 text-xs font-semibold text-slate-700 dark:text-slate-300 hover:bg-sky-50 hover:text-sky-700 dark:hover:bg-slate-700 transition-colors">
								#{$keyword.name|default:$keyword|escape}
							</span>
						{/foreach}
					</div>
				</section>
			{/if}

			{* Abstract *}
			{if $publication->getLocalizedData('abstract')}
				<section class="item abstract p-6 sm:p-8 rounded-3xl bg-white dark:bg-slate-900/60 border border-slate-200/80 dark:border-slate-800/80 shadow-sm space-y-4">
					<div class="flex items-center justify-between border-b border-slate-100 dark:border-slate-800 pb-4">
						<h2 class="label text-xl font-extrabold text-slate-900 dark:text-white tracking-tight flex items-center space-x-2">
							<svg class="w-5 h-5 text-sky-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
							<span>{translate key="article.abstract"}</span>
						</h2>
					</div>
					<div class="value prose prose-slate dark:prose-invert max-w-none text-slate-700 dark:text-slate-300 text-base leading-relaxed">
						{$publication->getLocalizedData('abstract')|strip_unsafe_html}
					</div>
				</section>
			{/if}

			{* Social Share Toolbar *}
			{if $activeTheme && $activeTheme->getOption('showSocialShare')}
				<section class="item share p-5 rounded-2xl bg-slate-50 dark:bg-slate-900/40 border border-slate-200/80 dark:border-slate-800/80 flex flex-wrap items-center justify-between gap-4" x-data="{ copied: false }">
					<span class="label text-xs font-bold uppercase tracking-wider text-slate-500 dark:text-slate-400">
						{translate key="plugins.themes.material.share.label"}
					</span>
					<div class="flex flex-wrap items-center gap-2">
						<a href="https://twitter.com/intent/tweet?text={$publication->getLocalizedTitle(null, 'html')|strip_tags|escape:'url'}&url={$currentUrl|escape:'url'}" target="_blank" rel="noopener" class="p-2.5 rounded-xl bg-white dark:bg-slate-800 hover:bg-slate-100 dark:hover:bg-slate-700 text-slate-700 dark:text-slate-200 border border-slate-200/60 dark:border-slate-700 transition-colors shadow-2xs" title="Share on X / Twitter">
							<svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/></svg>
						</a>
						<a href="https://www.linkedin.com/sharing/share-offsite/?url={$currentUrl|escape:'url'}" target="_blank" rel="noopener" class="p-2.5 rounded-xl bg-white dark:bg-slate-800 hover:bg-slate-100 dark:hover:bg-slate-700 text-slate-700 dark:text-slate-200 border border-slate-200/60 dark:border-slate-700 transition-colors shadow-2xs" title="Share on LinkedIn">
							<svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24"><path d="M19 3a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14m-.5 15.5v-5.3a3.26 3.26 0 0 0-3.26-3.26c-.85 0-1.84.52-2.28 1.3v-1.11h-2.79v8.37h2.79v-4.93c0-.77.62-1.4 1.39-1.4a1.4 1.4 0 0 1 1.4 1.4v4.93h2.75M6.88 8.56a1.68 1.68 0 0 0 1.68-1.68c0-.93-.75-1.69-1.68-1.69a1.69 1.69 0 0 0-1.69 1.69c0 .93.76 1.68 1.69 1.68m1.39 9.94v-8.37H5.5v8.37h2.77z"/></svg>
						</a>
						<a href="https://www.facebook.com/sharer/sharer.php?u={$currentUrl|escape:'url'}" target="_blank" rel="noopener" class="p-2.5 rounded-xl bg-white dark:bg-slate-800 hover:bg-slate-100 dark:hover:bg-slate-700 text-slate-700 dark:text-slate-200 border border-slate-200/60 dark:border-slate-700 transition-colors shadow-2xs" title="Share on Facebook">
							<svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24"><path d="M22 12c0-5.52-4.48-10-10-10S2 6.48 2 12c0 4.84 3.44 8.87 8 9.8V15H7.5v-3H10V9.5C10 7.01 11.49 5.65 13.7 5.65c1.06 0 2.17.19 2.17.19v2.38h-1.22c-1.23 0-1.62.77-1.62 1.56V12h2.69l-.43 3h-2.26v6.8c4.56-.93 8-4.96 8-9.8z"/></svg>
						</a>
						<button @click="navigator.clipboard.writeText(window.location.href); copied = true; setTimeout(() => copied = false, 2500)" class="inline-flex items-center space-x-1.5 px-4 py-2.5 rounded-xl bg-white dark:bg-slate-800 hover:bg-slate-100 dark:hover:bg-slate-700 text-xs font-bold text-slate-700 dark:text-slate-200 border border-slate-200/60 dark:border-slate-700 transition-colors shadow-2xs">
							<svg class="w-4 h-4 text-sky-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path></svg>
							<span x-text="copied ? '{translate key="plugins.themes.material.share.linkCopied"}' : '{translate key="plugins.themes.material.share.copyLink"}'"></span>
						</button>
					</div>
				</section>
			{/if}

			{* Main Hooks *}
			{call_hook name="Templates::Article::Main"}

			{* Usage statistics chart *}
			{if $activeTheme && $activeTheme->getOption('displayStats') != 'none'}
				{if $activeTheme|method_exists:'displayUsageStatsGraph'}
					{$activeTheme->displayUsageStatsGraph($article->getId())}
				{/if}
				<section class="item downloads_chart p-6 rounded-3xl bg-white dark:bg-slate-900/60 border border-slate-200/80 dark:border-slate-800/80 shadow-sm space-y-3">
					<h2 class="label text-base font-bold text-slate-900 dark:text-slate-100">
						{translate key="plugins.themes.default.displayStats.downloads"}
					</h2>
					<div class="value">
						<canvas class="usageStatsGraph" data-object-type="Submission" data-object-id="{$article->getId()|escape}"></canvas>
						<div class="usageStatsUnavailable" data-object-type="Submission" data-object-id="{$article->getId()|escape}">
							{translate key="plugins.themes.default.displayStats.noStats"}
						</div>
					</div>
				</section>
			{/if}

			{* Author biographies *}
			{assign var="hasBiographies" value=0}
			{foreach from=$publication->getData('authors') item=author}
				{if $author->getLocalizedData('biography')}
					{assign var="hasBiographies" value=$hasBiographies+1}
				{/if}
			{/foreach}
			{if $hasBiographies}
				<section class="item author_bios p-6 rounded-3xl bg-white dark:bg-slate-900/60 border border-slate-200/80 dark:border-slate-800/80 shadow-sm space-y-4">
					<h2 class="label text-lg font-bold text-slate-900 dark:text-slate-100 border-b border-slate-100 dark:border-slate-800 pb-3">
						{if $hasBiographies > 1}
							{translate key="submission.authorBiographies"}
						{else}
							{translate key="submission.authorBiography"}
						{/if}
					</h2>
					<div class="authors space-y-4">
						{foreach from=$publication->getData('authors') item=author}
							{if $author->getLocalizedData('biography')}
								<div class="sub_item p-4 rounded-2xl bg-slate-50 dark:bg-slate-800/40 border border-slate-200/60 dark:border-slate-800/60 space-y-2">
									<div class="label font-bold text-sm text-slate-900 dark:text-slate-100">
										{if $author->getLocalizedAffiliationNamesAsString()}
											{capture assign="authorName"}{$author->getFullName()|escape}{/capture}
											{capture assign="authorAffiliations"} {$author->getLocalizedAffiliationNamesAsString(null, ', ')|escape} {/capture}
											{translate key="submission.authorWithAffiliation" name=$authorName affiliation=$authorAffiliations}
										{else}
											{$author->getFullName()|escape}
										{/if}
									</div>
									<div class="value text-sm text-slate-700 dark:text-slate-300 prose dark:prose-invert max-w-none">
										{$author->getLocalizedData('biography')|strip_unsafe_html}
									</div>
								</div>
							{/if}
						{/foreach}
					</div>
				</section>
			{/if}

			{* References *}
			{assign var="hasCitations" value=false}
			{assign var="citationsText" value=""}

			{if is_array($parsedCitations) && count($parsedCitations) > 0}
				{assign var="hasCitations" value=true}
			{elseif is_string($parsedCitations) && $parsedCitations|trim neq ""}
				{assign var="hasCitations" value=true}
				{assign var="citationsText" value=$parsedCitations|trim}
			{elseif $publication->getData('citationsRaw') && $publication->getData('citationsRaw')|trim neq ""}
				{assign var="hasCitations" value=true}
				{assign var="citationsText" value=$publication->getData('citationsRaw')|trim}
			{elseif $publication->getData('citations') && is_string($publication->getData('citations')) && $publication->getData('citations')|trim neq ""}
				{assign var="hasCitations" value=true}
				{assign var="citationsText" value=$publication->getData('citations')|trim}
			{/if}

			{if $hasCitations}
				<section class="item references p-6 sm:p-8 rounded-3xl bg-white dark:bg-slate-900/60 border border-slate-200/80 dark:border-slate-800/80 shadow-sm space-y-4">
					<h2 class="label text-xl font-extrabold text-slate-900 dark:text-white tracking-tight border-b border-slate-100 dark:border-slate-800 pb-3 flex items-center space-x-2">
						<svg class="w-5 h-5 text-indigo-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path></svg>
						<span>{translate key="submission.citations"}</span>
					</h2>
					<div class="value text-sm text-slate-700 dark:text-slate-300 space-y-3 break-words [word-break:break-word]">
						{if is_array($parsedCitations) && count($parsedCitations) > 0}
							<ol class="list-decimal list-inside space-y-2 divide-y divide-slate-100 dark:divide-slate-800 break-words [word-break:break-word]">
								{foreach from=$parsedCitations item="parsedCitation"}
									<li class="pt-2 first:pt-0 leading-relaxed font-normal break-words [word-break:break-word]">
										{if is_object($parsedCitation)}
											<span class="break-words [word-break:break-word]">{$parsedCitation->getCitationWithLinks()|strip_unsafe_html}</span>
											{call_hook name="Templates::Article::Details::Reference" citation=$parsedCitation}
										{else}
											<span class="break-words [word-break:break-word]">{$parsedCitation|escape}</span>
										{/if}
									</li>
								{/foreach}
							</ol>
						{elseif $citationsText neq ""}
							<div class="leading-relaxed whitespace-pre-line font-normal break-words [word-break:break-word]">
								{$citationsText|escape|nl2br}
							</div>
						{/if}
					</div>
				</section>
			{/if}

		</div><!-- .main_entry -->

		{* Right Sticky Sidebar Column (4 of 12 cols = 33.3% width) *}
		<div class="entry_details article-sidebar-col space-y-4 sm:space-y-5 lg:sticky lg:top-6 self-start">

			{* Galleys / PDF Downloads (Featured Action Box) *}
			{if $primaryGalleys || $supplementaryGalleys}
				<div class="item galleys p-6 rounded-3xl bg-white dark:bg-slate-900/60 border border-slate-200/80 dark:border-slate-800/80 shadow-md space-y-4 ring-1 ring-sky-500/10">
					<div class="flex items-center space-x-2 text-xs font-extrabold uppercase tracking-wider text-slate-500 dark:text-slate-400">
						<svg class="w-4 h-4 text-sky-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"></path></svg>
						<span>{translate key="submission.downloads"}</span>
					</div>

					{if $primaryGalleys}
						<ul class="value galleys_links flex flex-col gap-2.5">
							{foreach from=$primaryGalleys item=galley}
								<li>
									{include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication galley=$galley purchaseFee=$currentJournal->getData('purchaseArticleFee') purchaseCurrency=$currentJournal->getData('currency')}
								</li>
							{/foreach}
						</ul>
					{/if}

					{if $supplementaryGalleys}
						<div class="pt-3 border-t border-slate-100 dark:border-slate-800">
							<h3 class="text-xs font-bold text-slate-500 mb-2">
								{translate key="submission.additionalFiles"}
							</h3>
							<ul class="value supplementary_galleys_links flex flex-col gap-2">
								{foreach from=$supplementaryGalleys item=galley}
									<li>
										{include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication galley=$galley isSupplementary="1"}
									</li>
								{/foreach}
							</ul>
						</div>
					{/if}
				</div>
			{/if}

			{* Cover Image *}
			{if $publication->getLocalizedData('coverImage') || ($issue && $issue->getLocalizedCoverImage())}
				<div class="item cover_image p-5 rounded-3xl bg-white dark:bg-slate-900/60 border border-slate-200/80 dark:border-slate-800/80 shadow-sm flex justify-center">
					<div class="sub_item">
						{if $publication->getLocalizedData('coverImage')}
							{assign var="coverImage" value=$publication->getLocalizedData('coverImage')}
							<img
								src="{$publication->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}"
								alt="{$coverImage.altText|escape|default:''}"
								class="max-w-full h-auto rounded-2xl shadow-md object-contain max-h-80"
							>
						{else}
							<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
								<img 
									src="{$issue->getLocalizedCoverImageUrl()|escape}" 
									alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}"
									class="max-w-full h-auto rounded-2xl shadow-md object-contain max-h-80"
								>
							</a>
						{/if}
					</div>
				</div>
			{/if}

			{* Published Date & Version History *}
			{if $publication->getData('datePublished')}
				<div class="item published p-6 rounded-3xl bg-white dark:bg-slate-900/60 border border-slate-200/80 dark:border-slate-800/80 shadow-sm space-y-3">
					<section class="sub_item space-y-1">
						<h2 class="label text-xs font-bold uppercase tracking-wider text-slate-500 dark:text-slate-400">
							{translate key="submissions.published"}
						</h2>
						<div class="value text-base font-extrabold text-slate-900 dark:text-slate-100">
							{if $firstPublication->getId() === $publication->getId()}
								<span>{$firstPublication->getData('datePublished')|date_format:$dateFormatShort}</span>
							{else}
								<span>{translate key="submission.updatedOn" datePublished=$firstPublication->getData('datePublished')|date_format:$dateFormatShort dateUpdated=$publication->getData('datePublished')|date_format:$dateFormatShort}</span>
							{/if}
						</div>
					</section>

					{if count($article->getPublishedPublications()) > 1}
						<section class="sub_item versions border-t border-slate-100 dark:border-slate-800 pt-3 space-y-2">
							<h2 class="label text-xs font-bold uppercase tracking-wider text-slate-500 dark:text-slate-400">
								{translate key="submission.versions"}
							</h2>
							<ul class="value text-xs space-y-1">
								{foreach from=array_reverse($article->getPublishedPublications()) item=iPublication}
									{capture assign="name"}{translate key="submission.versionIdentity" datePublished=$iPublication->getData('datePublished')|date_format:$dateFormatShort version=$iPublication->getData('version')}{/capture}
									<li>
										{if $iPublication->getId() === $publication->getId()}
											<span class="font-bold text-slate-900 dark:text-white">{$name}</span>
										{elseif $iPublication->getId() === $currentPublication->getId()}
											<a class="text-sky-600 dark:text-sky-400 hover:underline font-medium" href="{url page="article" op="view" path=$article->getBestId()}">{$name}</a>
										{else}
											<a class="text-sky-600 dark:text-sky-400 hover:underline font-medium" href="{url page="article" op="view" path=$article->getBestId()|to_array:"version":$iPublication->getId()}">{$name}</a>
										{/if}
									</li>
								{/foreach}
							</ul>
						</section>
					{/if}
				</div>
			{/if}

			{* Data Availability *}
			{if $publication->getLocalizedData('dataAvailability')}
				<section class="item dataAvailability p-6 rounded-3xl bg-white dark:bg-slate-900/60 border border-slate-200/80 dark:border-slate-800/80 shadow-sm space-y-2" id="data-availability-statement">
					<h2 class="label text-xs font-bold uppercase tracking-wider text-slate-500 dark:text-slate-400">
						{translate key="submission.dataAvailability"}
					</h2>
					<div class="value text-xs sm:text-sm text-slate-700 dark:text-slate-300 leading-relaxed">
						{$publication->getLocalizedData('dataAvailability')|strip_unsafe_html}
					</div>
				</section>
			{/if}

			{* Issue / Section Info Card *}
			{if $issue || $section || $categories}
				<div class="item issue p-6 rounded-3xl bg-white dark:bg-slate-900/60 border border-slate-200/80 dark:border-slate-800/80 shadow-sm space-y-4">
					{if $issue}
						<section class="sub_item space-y-1">
							<h2 class="label text-xs font-bold uppercase tracking-wider text-slate-500 dark:text-slate-400">
								{translate key="issue.issue"}
							</h2>
							<div class="value text-sm font-bold">
								<a class="title text-sky-600 dark:text-sky-400 hover:underline" href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
									{$issue->getIssueIdentification()|escape}
								</a>
							</div>
						</section>
					{/if}

					{if $section}
						<section class="sub_item space-y-1 border-t border-slate-100 dark:border-slate-800 pt-3">
							<h2 class="label text-xs font-bold uppercase tracking-wider text-slate-500 dark:text-slate-400">
								{translate key="section.section"}
							</h2>
							<div class="value text-sm font-medium text-slate-800 dark:text-slate-200">
								{$section->getLocalizedTitle()|escape}
							</div>
						</section>
					{/if}

					{if $categories}
						<section class="sub_item space-y-1 border-t border-slate-100 dark:border-slate-800 pt-3">
							<h2 class="label text-xs font-bold uppercase tracking-wider text-slate-500 dark:text-slate-400">
								{translate key="category.category"}
							</h2>
							<div class="value text-xs">
								<ul class="categories flex flex-wrap gap-1.5">
									{foreach from=$categories item=category}
										<li><a class="inline-flex px-2.5 py-1 rounded-lg bg-slate-100 dark:bg-slate-800 text-sky-600 dark:text-sky-400 hover:bg-slate-200 transition-colors font-medium" href="{url page="catalog" op="category" path=$category->getPath()|escape}">{$category->getLocalizedTitle()|escape}</a></li>
									{/foreach}
								</ul>
							</div>
						</section>
					{/if}
				</div>
			{/if}

			{* Other PubIds *}
			{foreach from=$pubIdPlugins item=pubIdPlugin}
				{if $pubIdPlugin->getPubIdType() == 'doi'}
					{continue}
				{/if}
				{assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
				{if $pubId}
					<div class="item pubid p-6 rounded-3xl bg-white dark:bg-slate-900/60 border border-slate-200/80 dark:border-slate-800/80 shadow-sm space-y-1">
						<h2 class="label text-xs font-bold uppercase tracking-wider text-slate-500 dark:text-slate-400">
							{$pubIdPlugin->getPubIdDisplayType()|escape}
						</h2>
						<div class="value text-sm font-medium">
							{if $pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
								<a id="pub-id::{$pubIdPlugin->getPubIdType()|escape}" href="{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}" class="text-sky-600 dark:text-sky-400 hover:underline break-all">
									{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
								</a>
							{else}
								{$pubId|escape}
							{/if}
						</div>
					</div>
				{/if}
			{/foreach}

			{* License / Copyright *}
			{if $currentContext->getLocalizedData('licenseTerms') || $publication->getData('licenseUrl')}
				<div class="item copyright p-6 rounded-3xl bg-white dark:bg-slate-900/60 border border-slate-200/80 dark:border-slate-800/80 shadow-sm space-y-3">
					<h2 class="label text-xs font-bold uppercase tracking-wider text-slate-500 dark:text-slate-400">
						{translate key="submission.license"}
					</h2>
					<div class="value text-xs text-slate-600 dark:text-slate-400 space-y-2 leading-relaxed">
						{if $publication->getData('licenseUrl')}
							{if $ccLicenseBadge}
								{if $publication->getLocalizedData('copyrightHolder')}
									<p>{translate key="submission.copyrightStatement" copyrightHolder=$publication->getLocalizedData('copyrightHolder') copyrightYear=$publication->getData('copyrightYear')}</p>
								{/if}
								<div class="pt-1">{$ccLicenseBadge}</div>
							{else}
								<a href="{$publication->getData('licenseUrl')|escape}" class="copyright text-sky-600 dark:text-sky-400 hover:underline block font-medium">
									{if $publication->getLocalizedData('copyrightHolder')}
										{translate key="submission.copyrightStatement" copyrightHolder=$publication->getLocalizedData('copyrightHolder') copyrightYear=$publication->getData('copyrightYear')}
									{else}
										{translate key="submission.license"}
									{/if}
								</a>
							{/if}
						{/if}
						{if $currentContext->getLocalizedData('licenseTerms')}
							<div class="prose dark:prose-invert text-xs pt-1 border-t border-slate-100 dark:border-slate-800">
								{$currentContext->getLocalizedData('licenseTerms')}
							</div>
						{/if}
					</div>
				</div>
			{/if}

			{* Details Hook (Includes CSL "How to Cite" & Citation formats) *}
			<div class="item details_hooks space-y-4">
				{call_hook name="Templates::Article::Details"}
			</div>

		</div><!-- .entry_details -->
	</div><!-- .row -->

</article>
