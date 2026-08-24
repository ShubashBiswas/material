{**
 * templates/frontend/components/headerSection.tpl
 *
 * Copyright (c) 2025 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 *  bg-green-300
 *  bg-blue-300
 *  bg-sky-300
 *  bg-indigo-300
 *  bg-orange-300
 *  bg-emerald-300
 *  bg-purple-300
 *  bg-violet-300
 *  bg-teal-300
 *  bg-rose-300
 *  bg-amber-300
 *  bg-slate-300
 *  focus-visible:outline-green-300/50
 *  focus-visible:outline-blue-300/50
 *  focus-visible:outline-sky-300/50
 *  focus-visible:outline-indigo-300/50
 *  focus-visible:outline-orange-300/50
 *  focus-visible:outline-emerald-300/50
 *  focus-visible:outline-purple-300/50
 *  focus-visible:outline-violet-300/50
 *  focus-visible:outline-teal-300/50
 *  focus-visible:outline-rose-300/50
 *  focus-visible:outline-amber-300/50
 *  focus-visible:outline-slate-300/50
 *  active:bg-green-500
 *  active:bg-blue-500
 *  active:bg-sky-500
 *  active:bg-indigo-500
 *  active:bg-orange-500
 *  active:bg-emerald-500
 *  active:bg-purple-500
 *  active:bg-violet-500
 *  active:bg-teal-500
 *  active:bg-rose-500
 *  active:bg-amber-500
 *  active:bg-slate-500
 *  hover:bg-green-200
 *  hover:bg-blue-200
 *  hover:bg-sky-200
 *  hover:bg-indigo-200
 *  hover:bg-orange-200
 *  hover:bg-emerald-200
 *  hover:bg-purple-200
 *  hover:bg-violet-200
 *  hover:bg-teal-200
 *  hover:bg-rose-200
 *  hover:bg-amber-200
 *  hover:bg-slate-200
 *  font-inter
 *  font-plus-jakarta-sans
 *  font-open-sans
 *  font-merriweather
 *  font-lora
 *  font-comic-sans
 *  font-comic-neue
 *  font-cardo
 *  font-cormorant
 *  font-old-standard-tt
 *  font-roboto-serif
 *}

<div class="relative overflow-hidden {if isset($homepageImageUrl)}bg-slate-900{else}bg-slate-900{/if} dark:bg-slate-900 _dark:-mb-32 _dark:mt-[-4.75rem] _dark:pb-32 _dark:pt-[4.75rem]">
   {if isset($homepageImageUrl)}
      <img alt="" fetchpriority="high" decoding="async" data-nimg="1" class="absolute  -mb-56 -mr-72 opacity-50" style="color:transparent;width:100%;height:100%" src="{$homepageImageUrl}">
   {else}   
      <img alt="" fetchpriority="high" decoding="async" data-nimg="1" class="absolute  -mb-56 -mr-72 opacity-50" style="color:transparent" src="{$gradientImageUrl}">
   {/if}
   <div class="py-16 sm:px-2 lg:relative lg:px-0 lg:py-20">
      <div class="mx-auto grid max-w-2xl grid-cols-1 items-center gap-x-8 gap-y-16 px-4 lg:max-w-8xl lg:grid-cols-2 lg:px-8 xl:gap-x-16 xl:px-12">
         <div class="relative z-10 md:text-center lg:text-left">
            <!--img alt=""-->
            <div class="relative">
              <p class="inline font-extrabold {if isset($homepageImageUrl)}text-white{else}text-white{/if} dark:text-white bg-clip-text font-display text-5xl tracking-tight">
                {$displayPageHeaderTitle|escape}
              </p>
              {if $activeTheme->getOption('showDescriptionInJournalIndex')}
                <div class="mt-3 text-2xl tracking-tight {if isset($homepageImageUrl)}text-slate-200{else}text-slate-400 line-clamp-3{/if}">
                  {$currentContext->getLocalizedData('description')}
                </div>
              {/if}
              <div class="mt-8 flex gap-4 md:justify-center lg:justify-start">
                <a class="rounded-full bg-{$activeTheme->getBaseColour()}-300 py-2 px-4 text-sm font-semibold text-slate-900 hover:bg-{$activeTheme->getBaseColour()}-200 focus:outline-none focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-{$activeTheme->getBaseColour()}-300/50 active:bg-{$activeTheme->getBaseColour()}-500" href="{url page="about" op="submissions"}" role="button">
                  {translate key="plugins.themes.material.makeSubmission"}
                </a>
                <a class="rounded-full bg-slate-800 py-2 px-4 text-sm font-medium text-white hover:bg-slate-700 focus:outline-none focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-white/50 active:text-slate-400" href="{url page="issue" op="archive"}">
                  {translate key="archive.archives"}
                </a>
              </div>
            </div>
         </div>
      </div>
   </div>
</div>

