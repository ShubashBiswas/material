{**
 * templates/frontend/components/headerSection.tpl
 *
 * Copyright (c) 2025 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *}

{* Determine Journal Thumbnail or Cover Image URL *}
{assign var="headerThumbnailUrl" value=""}
{if !empty($homepageImageUrl)}
   {assign var="headerThumbnailUrl" value=$homepageImageUrl}
{elseif !empty($homepageImage) && !empty($homepageImage.uploadName)}
   {assign var="headerThumbnailUrl" value="`$publicFilesDir`/`$homepageImage.uploadName|escape:'url'`"}
{elseif !empty($displayPageHeaderLogo) && is_array($displayPageHeaderLogo) && !empty($displayPageHeaderLogo.uploadName)}
   {assign var="headerThumbnailUrl" value="`$publicFilesDir`/`$displayPageHeaderLogo.uploadName|escape:'url'`"}
{elseif !empty($issue) && $issue->getLocalizedCoverImageUrl()}
   {assign var="headerThumbnailUrl" value=$issue->getLocalizedCoverImageUrl()}
{/if}

<div class="relative overflow-hidden bg-slate-900 text-white py-12 lg:py-16 border-b border-slate-800">
   {* Ambient radial glow *}
   <div class="absolute -right-20 -top-20 h-96 w-96 rounded-full bg-{$activeTheme->getBaseColour()}-500/15 blur-3xl pointer-events-none"></div>

   <div class="relative mx-auto max-w-8xl px-4 sm:px-6 lg:px-8 xl:px-12">
      <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 lg:gap-12 items-center">
         
         {* Left Column: Title, Description & CTAs *}
         <div class="{if $headerThumbnailUrl}lg:col-span-7{else}lg:col-span-12{/if} space-y-5 text-left">
            <h1 class="text-3xl sm:text-4xl lg:text-5xl font-extrabold text-white tracking-tight leading-tight">
               {$displayPageHeaderTitle|escape}
            </h1>

            {if $activeTheme->getOption('showDescriptionInJournalIndex') && $currentContext->getLocalizedData('description')}
               <div class="text-base sm:text-lg text-slate-300 line-clamp-3 leading-relaxed max-w-3xl">
                  {$currentContext->getLocalizedData('description')}
               </div>
            {/if}

            <div class="pt-2 flex flex-wrap items-center gap-4">
               <a class="inline-flex items-center justify-center rounded-xl bg-{$activeTheme->getBaseColour()}-600 hover:bg-{$activeTheme->getBaseColour()}-700 py-3 px-6 text-sm font-extrabold text-white shadow-lg shadow-{$activeTheme->getBaseColour()}-900/40 ring-1 ring-{$activeTheme->getBaseColour()}-400/30 hover:scale-[1.02] active:scale-[0.98] transition-all" href="{url page="about" op="submissions"}">
                  <svg class="w-4 h-4 mr-2 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M12 4v16m8-8H4"></path></svg>
                  <span>{translate key="plugins.themes.material.makeSubmission"}</span>
               </a>
               <a class="inline-flex items-center justify-center rounded-xl bg-slate-800/90 hover:bg-slate-700/90 py-3 px-6 text-sm font-semibold text-white border border-slate-700/80 hover:border-slate-600 transition-all" href="{url page="issue" op="archive"}">
                  {translate key="archive.archives"}
               </a>
            </div>
         </div>

         {* Right Column: Journal Cover / Thumbnail Image (Desktop Only) *}
         {if $headerThumbnailUrl}
            <div class="hidden lg:flex lg:col-span-5 justify-center lg:justify-end">
               <div class="relative group max-w-xs sm:max-w-sm w-full flex justify-center lg:justify-end">
                  <div class="absolute -inset-1.5 rounded-3xl bg-gradient-to-tr from-{$activeTheme->getBaseColour()}-500/40 to-indigo-500/40 opacity-40 blur-xl group-hover:opacity-60 transition duration-300"></div>
                  <img src="{$headerThumbnailUrl}" alt="{$displayPageHeaderTitle|escape}" class="relative max-h-80 sm:max-h-96 w-auto object-contain rounded-2xl shadow-2xl border border-white/10 bg-slate-800/50">
               </div>
            </div>
         {/if}


      </div>
   </div>
</div>
