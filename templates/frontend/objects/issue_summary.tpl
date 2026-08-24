{**
 * templates/frontend/objects/issue_summary.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a summary for use in lists
 *
 * @uses $issue Issue The issue
 *}
{if $issue->getShowTitle()}
	{assign var=issueTitle value=$issue->getLocalizedTitle()|escape}
{/if}
{assign var=issueSeries value=$issue->getIssueSeries()}
{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}

<div class="group relative flex flex-col justify-between overflow-hidden rounded-2xl bg-white dark:bg-slate-900/60 border border-slate-200/70 dark:border-slate-800/80 hover:border-slate-300 dark:hover:border-slate-700 shadow-sm hover:shadow-md transition-all duration-200 p-5 h-full">
    {if $issueCover}
        <div class="w-full h-48 overflow-hidden rounded-xl bg-slate-100 dark:bg-slate-800 border border-slate-200/60 dark:border-slate-800 mb-4">
            <a href="{url op="view" path=$issue->getBestIssueId()}" class="block h-full w-full">
                <img src="{$issueCover|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}" class="h-full w-full object-cover transition-transform duration-300 group-hover:scale-105">
            </a>
        </div>
    {/if}
    
    <div class="flex-1 flex flex-col justify-between">
        <div>
            {if $issueSeries}
                <div class="text-xs font-bold uppercase tracking-wider text-{$activeTheme->getBaseColour()}-600 dark:text-{$activeTheme->getBaseColour()}-400 mb-1">
                    {$issueSeries|escape}
                </div>
            {/if}

            <h3 class="text-base font-bold text-slate-900 dark:text-slate-100 group-hover:text-{$activeTheme->getBaseColour()}-600 dark:group-hover:text-{$activeTheme->getBaseColour()}-400 transition-colors leading-snug">
                <a class="title" href="{url op="view" path=$issue->getBestIssueId()}">
                    <span aria-hidden="true" class="absolute inset-0"></span>
                    {if $issueTitle}
                        {$issueTitle|escape}
                    {else}
                        {$issueSeries|escape}
                    {/if}
                </a>
            </h3>

            {if $issue->getLocalizedDescription()}
                <p class="mt-2 text-xs text-slate-500 dark:text-slate-400 line-clamp-3 leading-relaxed">
                    {$issue->getLocalizedDescription()|strip_unsafe_html}
                </p>
            {/if}
        </div>

        {if $issue->getDatePublished()}
            <div class="mt-4 pt-3 border-t border-slate-100 dark:border-slate-800/80 text-xs font-medium text-slate-400 dark:text-slate-500 flex items-center space-x-1.5">
                <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                <span>{$issue->getDatePublished()|date_format:$dateFormatShort}</span>
            </div>
        {/if}
    </div>
</div>
