{**
 * templates/frontend/objects/article_summary.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article summary which is shown within a list of articles.
 *
 * @uses $article Article The article
 * @uses $authorUserGroups Traversible The set of author user groups
 * @uses $hasAccess bool Can this user access galleys for this context? The
 *       context may be an issue or an article
 * @uses $showDatePublished bool Show the date this article was published?
 * @uses $hideGalleys bool Hide the article galleys for this article?
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 * @uses $heading string HTML heading element, default: h2
 *}
{assign var=publication value=$article->getCurrentPublication()}

{assign var=articlePath value=$publication->getData('urlPath')|default:$article->getId()}
{if !$heading}
	{assign var="heading" value="h2"}
{/if}

{if (!$section.hideAuthor && ($publication->getData('hideAuthor') == $smarty.const.AUTHOR_TOC_DEFAULT || $publication->getData('hideAuthor') == 0)) || $publication->getData('hideAuthor') == $smarty.const.AUTHOR_TOC_SHOW || $publication->getData('hideAuthor') == 1}
	{assign var="showAuthor" value=true}
{/if}

<div class="group relative flex flex-col sm:flex-row gap-4 sm:gap-6 p-4 sm:p-5 rounded-2xl bg-white dark:bg-slate-900/60 border border-slate-200/70 dark:border-slate-800/80 hover:border-slate-300 dark:hover:border-slate-700 shadow-sm hover:shadow-md transition-all duration-200 w-full my-3">
    {if $publication->getLocalizedData('coverImage')}
        <div class="w-full sm:w-32 sm:h-40 flex-shrink-0 overflow-hidden rounded-xl bg-slate-100 dark:bg-slate-800 border border-slate-200/60 dark:border-slate-800">
            <a {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if} class="block h-full w-full">
                {assign var="coverImage" value=$publication->getLocalizedData('coverImage')}
                <img class="h-full w-full object-cover transition-transform duration-300 group-hover:scale-105" src="{$publication->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}" alt="{$coverImage.altText|escape|default:''}">
            </a>
        </div>
    {/if}

    <div class="flex-1 flex flex-col justify-between min-w-0">
        <div>
            <div class="flex items-start justify-between gap-3">
                <{$heading} class="text-base sm:text-lg font-bold text-slate-900 dark:text-slate-100 leading-snug group-hover:text-{$activeTheme->getBaseColour()}-600 dark:group-hover:text-{$activeTheme->getBaseColour()}-400 transition-colors">
                    <a id="article-{$article->getId()}" {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
                        {$publication->getLocalizedTitle(null, 'html')|strip_unsafe_html}
                    </a>
                </{$heading}>
            </div>

            {assign var=localizedSubtitle value=$publication->getLocalizedSubtitle(null, 'html')|strip_unsafe_html}
            {if $localizedSubtitle}
                <div class="text-sm font-medium text-slate-500 dark:text-slate-400 mt-1 leading-normal">
                    {$localizedSubtitle}
                </div>
            {/if}

            {if $showAuthor}
                <div class="text-sm font-medium text-slate-600 dark:text-slate-300 mt-2 flex flex-wrap items-center gap-1.5">
                    <svg class="w-4 h-4 text-slate-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                    <span>{$publication->getAuthorString($authorUserGroups)|escape}</span>
                </div>
            {/if}

            {if $publication->getLocalizedData('abstract')}
                <div class="text-sm text-slate-500 dark:text-slate-400 line-clamp-2 mt-2.5 leading-relaxed">
                    {$publication->getLocalizedData('abstract')|strip_tags|truncate:220:"..."}
                </div>
            {/if}
        </div>

        <div class="mt-4 pt-3 border-t border-slate-100 dark:border-slate-800/80 flex flex-wrap items-center justify-between gap-3">
            <div class="flex flex-wrap items-center gap-2 text-xs">
                {assign var=submissionPages value=$publication->getData('pages')}
                {assign var=submissionDatePublished value=$publication->getData('datePublished')}
                
                {if $submissionDatePublished && $showDatePublished}
                    <span class="inline-flex items-center space-x-1.5 px-2.5 py-1 rounded-lg bg-slate-100 dark:bg-slate-800/80 text-slate-600 dark:text-slate-300 border border-slate-200/50 dark:border-slate-700/50 font-medium">
                        <svg class="w-3.5 h-3.5 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                        <span>{$submissionDatePublished|date_format:$dateFormatShort}</span>
                    </span>
                {/if}

                {if $submissionPages}
                    <span class="inline-flex items-center space-x-1.5 px-2.5 py-1 rounded-lg bg-slate-100 dark:bg-slate-800/80 text-slate-600 dark:text-slate-300 border border-slate-200/50 dark:border-slate-700/50 font-medium">
                        <svg class="w-3.5 h-3.5 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
                        <span>pp. {$submissionPages|escape}</span>
                    </span>
                {/if}
            </div>

            {if !$hideGalleys}
                <div class="flex flex-wrap items-center gap-2">
                    {foreach from=$article->getGalleys() item=galley}
                        {if $primaryGenreIds}
                            {assign var="file" value=$galley->getFile()}
                            {if !$galley->getData('urlRemote') && !($file && in_array($file->getGenreId(), $primaryGenreIds))}
                                {continue}
                            {/if}
                        {/if}
                        {assign var="hasArticleAccess" value=$hasAccess}
                        {if $currentContext->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_OPEN || $currentContext->getSetting('publishingMode') == 0 || $publication->getData('accessStatus') == $smarty.const.ARTICLE_ACCESS_OPEN || $publication->getData('accessStatus') == 1}
                            {assign var="hasArticleAccess" value=1}
                        {/if}
                        {assign var="id" value="article-{$article->getId()}-galley-{$galley->getId()}"}
                        {include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication id=$id labelledBy="{$id} article-{$article->getId()}" hasAccess=$hasArticleAccess purchaseFee=$currentJournal->getData('purchaseArticleFee') purchaseCurrency=$currentJournal->getData('currency')}
                    {/foreach}
                </div>
            {/if}
        </div>
    </div>

    {call_hook name="Templates::Issue::Issue::Article"}
</div>
