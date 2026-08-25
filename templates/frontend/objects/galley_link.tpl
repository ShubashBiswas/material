{**
 * templates/frontend/objects/galley_link.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of a galley object as a button/link to view or download the galley.
 *
 * @uses $galley Galley
 * @uses $parent Issue|Article Object which these galleys are attached to
 * @uses $publication Publication Optionally the publication (version) to which this galley is attached
 * @uses $isSupplementary bool Is this a supplementary file?
 * @uses $hasAccess bool Can this user access galleys for this context?
 * @uses $restrictOnlyPdf bool Is access only restricted to PDF galleys?
 * @uses $purchaseArticleEnabled bool Can this article be purchased?
 * @uses $currentJournal Journal The current journal context
 * @uses $journalOverride Journal An optional argument to override the current journal
 *}

{if $journalOverride}
	{assign var="currentJournal" value=$journalOverride}
{/if}

{if $galley->isPdfGalley()}
	{assign var="type" value="pdf"}
{else}
	{assign var="type" value="file"}
{/if}

{if $parent|is_a:'Issue'}
	{assign var="page" value="issue"}
	{assign var="parentId" value=$parent->getBestIssueId()}
	{assign var="path" value=$parentId|to_array:$galley->getBestGalleyId()}
{else}
	{assign var="page" value="article"}
	{assign var="parentId" value=$parent->getBestId()}
	{if $publication && $publication->getId() !== $parent->getCurrentPublication()->getId()}
		{assign var="path" value=$parentId|to_array:"version":$publication->getId():$galley->getBestGalleyId()}
	{else}
		{assign var="path" value=$parentId|to_array:$galley->getBestGalleyId()}
	{/if}
{/if}

{if !$hasAccess}
	{if $restrictOnlyPdf && $type=="pdf"}
		{assign var=restricted value="1"}
	{elseif !$restrictOnlyPdf}
		{assign var=restricted value="1"}
	{/if}
{/if}

<a class="
	group w-full inline-flex items-center justify-between px-5 py-3.5 rounded-xl font-bold text-sm tracking-wide transition-all duration-200 shadow-sm hover:shadow-md border
	{if $restricted}
		bg-rose-500 hover:bg-rose-600 text-white border-rose-600 focus:ring-2 focus:ring-rose-500
	{elseif $isSupplementary}
		bg-slate-800 hover:bg-slate-900 text-slate-100 border-slate-700 dark:bg-slate-700 dark:hover:bg-slate-600 dark:border-slate-600
	{else}
		bg-gradient-to-r from-sky-500 to-indigo-600 hover:from-sky-600 hover:to-indigo-700 text-white border-transparent shadow-sky-500/20 active:scale-[0.99]
	{/if}"
	href="{url page=$page op="view" path=$path}"
	{if $labelledBy}
		aria-labelledby="{$labelledBy}"
	{/if}>

	<div class="flex items-center space-x-3 min-w-0">
		<div class="p-1.5 rounded-lg bg-white/10 text-white shrink-0 group-hover:scale-110 transition-transform">
			{if $restricted}
				<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path></svg>
			{elseif $type == "pdf"}
				<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z"></path></svg>
			{else}
				<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
			{/if}
		</div>
		<span class="truncate uppercase text-xs sm:text-sm font-extrabold tracking-wider">
			{$galley->getGalleyLabel()|escape}
		</span>
	</div>

	<div class="flex items-center space-x-2 shrink-0">
		{if $restricted && $purchaseFee && $purchaseCurrency}
			<span class="text-xs font-semibold px-2 py-0.5 rounded bg-black/20 text-white">
				{translate key="reader.purchasePrice" price=$purchaseFee currency=$purchaseCurrency}
			</span>
		{else}
			<svg class="w-4 h-4 text-white/80 group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
				<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M14 5l7 7-7 7M3 12h18"></path>
			</svg>
		{/if}
	</div>
</a>
